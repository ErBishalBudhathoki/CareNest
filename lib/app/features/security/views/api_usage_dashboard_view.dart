import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/generated/l10n/app_localizations.dart';

class ApiUsageDashboardView extends ConsumerStatefulWidget {
  const ApiUsageDashboardView({super.key});

  @override
  ConsumerState<ApiUsageDashboardView> createState() =>
      _ApiUsageDashboardViewState();
}

class _ApiUsageDashboardViewState extends ConsumerState<ApiUsageDashboardView> {
  late final ApiMethod _api;
  Map<String, dynamic>? _analyticsData;
  Map<String, dynamic>? _realTimeData;
  Map<String, dynamic>? _rateLimitConfig;
  List<dynamic> _blockedIPs = [];
  List<dynamic> _failedAttempts = [];
  List<dynamic> _activeConnections = [];
  String? _error;
  bool _loading = true;
  bool _realTimeLoading = false;

  // Live SSE
  final List<Map<String, dynamic>> _liveEvents = [];
  StreamSubscription<String>? _sseSub;
  http.Client? _sseClient;

  // Organization ID for API calls
  String? _organizationId;

  @override
  void initState() {
    super.initState();
    _api = ref.read(app_providers.apiMethodProvider);
    _getOrganizationId().then((_) async {
      // Establish SSE first so analytics can include this connection
      _connectSSE();
      // Give the server a brief moment to register this SSE client
      await Future.delayed(const Duration(milliseconds: 300));
      _loadAll();
    });
  }

  @override
  void dispose() {
    _sseSub?.cancel();
    _sseClient?.close();
    super.dispose();
  }

  Future<void> _getOrganizationId() async {
    final sharedUtils = SharedPreferencesUtils();
    await sharedUtils.init();
    _organizationId = sharedUtils.getString('organizationId');
  }

  Map<String, String> _organizationHeaders() {
    final orgId = _organizationId;
    if (orgId == null || orgId.isEmpty) return const {};
    return {'x-organization-id': orgId};
  }

  Future<void> _loadAll() async {
    if (_organizationId == null) {
      setState(() {
        _error = AppLocalizations.of(context)!.organizationIdNotAvailable;
        _loading = false;
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final futures = [
        _api.get(
          'analytics/api-usage/$_organizationId',
          headers: _organizationHeaders(),
        ),
        _api.get(
          'analytics/api-usage/rate-limits',
          headers: _organizationHeaders(),
        ),
        _api.get(
          'analytics/api-usage/realtime/$_organizationId',
          headers: _organizationHeaders(),
        ),
      ];

      // Try to fetch admin rate limit status (optional: requires admin privileges)
      // If unauthorized, we just ignore the result and rely on analytics payload.
      futures.add(
        _api
            .get('security/rate-limit/status', headers: _organizationHeaders())
            .catchError((_) => <String, dynamic>{'success': false}),
      );

      final results = await Future.wait(futures);

      if (!mounted) return;
      // Check for errors among the first three critical calls
      String? firstError;
      for (int i = 0; i < 3; i++) {
        final r = results[i];
        if (r['success'] == false) {
          firstError =
              (r['message'] ??
                      r['error'] ??
                      AppLocalizations.of(context)!.requestFailed)
                  .toString();
          break;
        }
      }

      if (firstError != null) {
        setState(() {
          _error = firstError;
          _analyticsData = null;
          _rateLimitConfig = null;
          _realTimeData = null;
          _loading = false;
        });
        return;
      }

      setState(() {
        final analyticsResult = results[0];
        final rateLimitResult = results[1];
        final realTimeResult = results[2];
        final statusResult = results.length > 3 ? results[3] : null;

        _analyticsData = analyticsResult['data'] ?? {};
        _rateLimitConfig = rateLimitResult['data'] ?? {};
        _realTimeData = realTimeResult['data'] ?? {};

        // Extract security data from analytics by default
        _blockedIPs = _analyticsData?['security']?['blockedIPs'] ?? [];
        _failedAttempts = _analyticsData?['security']?['failedAttempts'] ?? [];

        // If admin status endpoint succeeded, prefer its data
        if (statusResult is Map) {
          final Map statusMap = statusResult as Map;
          if (statusMap['success'] == true) {
            final statusData = statusMap['data'] as Map<String, dynamic>?;
            if (statusData != null) {
              _blockedIPs = (statusData['blockedIPs'] as List?) ?? _blockedIPs;
              _failedAttempts =
                  (statusData['failedAttempts'] as List?) ?? _failedAttempts;
            }
          }
        }

        // Also update active connections from analytics/realtime
        _activeConnections =
            _analyticsData?['security']?['activeConnections'] ?? [];

        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = AppLocalizations.of(
          context,
        )!.failedToLoadApiUsage(e.toString());
        _loading = false;
      });
    }
  }

  void _connectSSE() async {
    if (_organizationId == null) {
      debugPrint(
        '[SSE] Organization ID not available, skipping SSE connection',
      );
      return;
    }

    try {
      _sseClient = http.Client();
      final resp = await _api.openSseStream(
        'analytics/api-usage/stream/$_organizationId',
        client: _sseClient!,
        headers: {
          'Accept': 'text/event-stream',
          'Cache-Control': 'no-cache',
          ..._organizationHeaders(),
        },
      );
      debugPrint('[SSE] Response status: ${resp.statusCode}');
      if (resp.statusCode != 200) {
        if (mounted) {
          _showErrorSnackbar(
            AppLocalizations.of(
              context,
            )!.liveStreamUnavailable('${resp.statusCode}'),
          );
        }
        return;
      }

      // Transform to lines and parse SSE events
      final stream = resp.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter());
      String buffer = '';
      _sseSub = stream.listen(
        (line) {
          if (line.isEmpty) {
            // end of event
            if (buffer.isNotEmpty) {
              try {
                final dataIndex = buffer.indexOf('data:');
                if (dataIndex != -1) {
                  final payload = buffer.substring(dataIndex + 5).trim();
                  final jsonStart = payload.indexOf('{');
                  final jsonStr = jsonStart == -1
                      ? payload
                      : payload.substring(jsonStart);
                  final decoded = json.decode(jsonStr);
                  // Only record actual request events; ignore ping/ready and other misc events
                  if (decoded is Map<String, dynamic> &&
                      decoded['type'] == 'request') {
                    setState(() {
                      _liveEvents.insert(0, decoded);
                      if (_liveEvents.length > 100) {
                        _liveEvents.removeLast();
                      }
                    });
                  }
                }
              } catch (e) {
                debugPrint('[SSE] Parse error: $e');
              }
              buffer = '';
            }
          } else if (line.startsWith('data:')) {
            buffer += (buffer.isEmpty ? '' : '\n') + line;
          }
        },
        onError: (err) {
          debugPrint('[SSE] Stream error: $err');
        },
        onDone: () {
          debugPrint('[SSE] Stream closed by server');
          // Retry after 5 seconds if still mounted
          if (mounted) {
            Future.delayed(const Duration(seconds: 5), () {
              if (mounted) _connectSSE();
            });
          }
        },
      );
    } catch (e) {
      debugPrint('[SSE] Exception: $e');
      // Retry after 5 seconds if still mounted
      if (mounted) {
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) _connectSSE();
        });
      }
    }
  }

  Future<void> _unblockIpAddress(String ipAddress) async {
    try {
      final res = await _api.post(
        'analytics/api-usage/unblock-ip',
        headers: _organizationHeaders(),
        body: {
          'ipAddress': ipAddress,
          if (_organizationId != null) 'organizationId': _organizationId,
        },
      );

      if (!mounted) return;

      if (res['success'] == true) {
        _showSuccessSnackbar(
          AppLocalizations.of(context)!.ipUnblockedSuccess(ipAddress),
        );
        _loadAll(); // Reload data to reflect changes
      } else {
        _showErrorSnackbar(
          AppLocalizations.of(context)!.failedToUnblockIp(
            res['message'] ?? AppLocalizations.of(context)!.unknown,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackbar(
        AppLocalizations.of(context)!.errorUnblockingIp(e.toString()),
      );
    }
  }

  Future<void> _resetRateLimitForIp(String ip) async {
    try {
      final res = await _api.post(
        'security/rate-limit/reset',
        headers: _organizationHeaders(),
        body: {
          'ip': ip,
          if (_organizationId != null) 'organizationId': _organizationId,
        },
      );

      if (!mounted) return;

      if (res['success'] == true) {
        _showSuccessSnackbar(
          AppLocalizations.of(context)!.rateLimitResetFor(ip),
        );
        _loadAll();
      } else {
        _showErrorSnackbar(
          AppLocalizations.of(context)!.failedToResetRateLimit(
            (res['message'] ?? AppLocalizations.of(context)!.unknown),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackbar(
        AppLocalizations.of(context)!.errorResettingRateLimit(e.toString()),
      );
    }
  }

  Future<void> _refreshRealTimeData() async {
    if (_organizationId == null) return;

    setState(() {
      _realTimeLoading = true;
    });

    try {
      final result = await _api.get(
        'analytics/api-usage/realtime/$_organizationId',
        headers: _organizationHeaders(),
      );

      if (result['success'] == true) {
        setState(() {
          _realTimeData = result['data'] ?? {};
          // Also update active connections from real-time endpoint if available
          final ac = _realTimeData?['activeConnections'];
          if (ac is List) {
            _activeConnections = ac;
          }
          _realTimeLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _realTimeLoading = false;
      });
    }
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: BauhausDesign.success),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Text(
                message,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
          side: const BorderSide(color: BauhausDesign.success, width: 2),
        ),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: BauhausDesign.error),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Text(
                message,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
          side: const BorderSide(color: BauhausDesign.error, width: 2),
        ),
      ),
    );
  }

  TextStyle? get _sectionTitleStyle => BauhausDesign.getTextTheme(context)
      .titleMedium
      ?.copyWith(color: BauhausDesign.textDark, fontWeight: FontWeight.w700);

  TextStyle? get _itemTitleStyle => BauhausDesign.getTextTheme(context)
      .bodyMedium
      ?.copyWith(color: BauhausDesign.textDark, fontWeight: FontWeight.w600);

  TextStyle? get _itemSubtitleStyle => BauhausDesign.getTextTheme(
    context,
  ).bodySmall?.copyWith(color: BauhausDesign.textMuted);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildBauhausAppBar(),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary),
            )
          : _error != null
          ? Center(
              child: BauhausErrorState(message: _error!, onRetry: _loadAll),
            )
          : RefreshIndicator(
              onRefresh: _loadAll,
              color: BauhausDesign.primary,
              child: ListView(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                children: [
                  _buildStatusStrip(),
                  const SizedBox(height: BauhausDesign.space4),
                  _buildOverviewCards(),
                  const SizedBox(height: BauhausDesign.space4),
                  _buildSecuritySection(),
                  const SizedBox(height: BauhausDesign.space4),
                  _buildMetricsSection(),
                  const SizedBox(height: BauhausDesign.space4),
                  _buildRateLimitSection(),
                  const SizedBox(height: BauhausDesign.space4),
                  _buildActiveConnections(),
                  const SizedBox(height: BauhausDesign.space4),
                  _buildLiveEvents(),
                ],
              ),
            ),
    );
  }

  PreferredSizeWidget _buildBauhausAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: const BoxDecoration(
          color: BauhausDesign.surfaceLight,
          border: Border(
            bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4,
            ),
            child: Row(
              children: [
                BauhausIconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icons.arrow_back,
                  variant: BauhausActionVariant.ghost,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  AppLocalizations.of(context)!.apiSecurity,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).displaySmall?.copyWith(color: BauhausDesign.textDark),
                ),
                const Spacer(),
                BauhausIconButton(
                  tooltip: AppLocalizations.of(context)!.realTimeTooltip,
                  onPressed: _refreshRealTimeData,
                  icon: Icons.refresh,
                  variant: _realTimeLoading
                      ? BauhausActionVariant.primary
                      : BauhausActionVariant.neutral,
                ),
                const SizedBox(width: BauhausDesign.space2),
                BauhausIconButton(
                  tooltip: AppLocalizations.of(context)!.reloadAllTooltip,
                  onPressed: _loadAll,
                  icon: Icons.download,
                  variant: BauhausActionVariant.neutral,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusStrip() {
    final activeCount = _activeConnections.length;
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_user, color: BauhausDesign.secondary),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.apiSecurity,
              style: BauhausDesign.getTextTheme(
                context,
              ).labelLarge?.copyWith(color: BauhausDesign.textDark),
            ),
          ),
          BauhausChip(
            text: '${AppLocalizations.of(context)!.activeUsers}: $activeCount',
            color: BauhausDesign.secondary,
            isSmall: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCards() {
    final metrics = _analyticsData?['metrics'] ?? {};
    final totalCalls = metrics['totalCalls'] ?? 0;
    final successRate = metrics['successRate']?.toStringAsFixed(1) ?? '0.0';
    final avgResponseTime =
        metrics['responseTime']?['average']?.toStringAsFixed(1) ?? '0.0';
    final activeUsers = _activeConnections.length;

    return Wrap(
      spacing: BauhausDesign.space4,
      runSpacing: BauhausDesign.space4,
      children: [
        _buildStatCard(
          title: AppLocalizations.of(context)!.totalApiCalls,
          value: '$totalCalls',
          color: BauhausDesign.secondary,
          icon: Icons.api,
        ),
        _buildStatCard(
          title: AppLocalizations.of(context)!.successRate,
          value: '$successRate%',
          color: BauhausDesign.success,
          icon: Icons.check_circle,
        ),
        _buildStatCard(
          title: AppLocalizations.of(context)!.avgResponseTime,
          value: '${avgResponseTime}ms',
          color: BauhausDesign.warning,
          icon: Icons.speed,
        ),
        _buildStatCard(
          title: AppLocalizations.of(context)!.activeUsers,
          value: '$activeUsers',
          color: BauhausDesign.primary,
          icon: Icons.people,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    IconData? icon,
  }) {
    return Container(
      width:
          (MediaQuery.of(context).size.width - (BauhausDesign.space4 * 3)) /
          2, // 2 columns
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardXs],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(color: BauhausDesign.neutral, width: 1),
                  ),
                  child: Icon(
                    icon,
                    size: 13,
                    color: BauhausDesign.surfaceLight,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space2),
              ],
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: BauhausDesign.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _CardSection({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _sectionTitleStyle),
          const Divider(
            height: BauhausDesign.space6,
            color: BauhausDesign.neutral,
            thickness: 1.2,
          ),
          child,
        ],
      ),
    );
  }

  Widget _buildSecuritySection() {
    return _CardSection(
      title: AppLocalizations.of(context)!.securityStatus,
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.block,
              size: 20,
              color: BauhausDesign.error,
            ),
            title: Text(
              AppLocalizations.of(context)!.blockedIpAddresses,
              style: _itemTitleStyle,
            ),
            subtitle: Text(
              AppLocalizations.of(
                context,
              )!.ipsCurrentlyBlocked('${_blockedIPs.length}'),
              style: _itemSubtitleStyle,
            ),
            trailing: BauhausChip(
              text: '${_blockedIPs.length}',
              color: BauhausDesign.error,
              isSmall: true,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.warning,
              size: 20,
              color: BauhausDesign.warning,
            ),
            title: Text(
              AppLocalizations.of(context)!.failedAttempts,
              style: _itemTitleStyle,
            ),
            subtitle: Text(
              AppLocalizations.of(
                context,
              )!.recentFailedAttempts('${_failedAttempts.length}'),
              style: _itemSubtitleStyle,
            ),
            trailing: BauhausChip(
              text: '${_failedAttempts.length}',
              color: BauhausDesign.warning,
              isSmall: true,
            ),
          ),
          if (_blockedIPs.isNotEmpty)
            ..._blockedIPs
                .take(3)
                .map(
                  (ip) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.computer, size: 16),
                    title: Text(
                      ip['ip'] ?? AppLocalizations.of(context)!.unknown,
                      style: _itemTitleStyle,
                    ),
                    subtitle: Text(
                      AppLocalizations.of(context)!.expiresDetailLabel(
                        ip['expiresAt']?.split('T').isNotEmpty == true
                            ? ip['expiresAt']?.split('T')[0] ??
                                  AppLocalizations.of(context)!.unknown
                            : AppLocalizations.of(context)!.unknown,
                      ),
                      style: _itemSubtitleStyle,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.lock_open, size: 16),
                      onPressed: () => _unblockIpAddress(ip['ip']),
                      tooltip: AppLocalizations.of(context)!.unblockThisIp,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildMetricsSection() {
    final metrics = _analyticsData?['metrics'] ?? {};
    final endpointStats = metrics['endpointStats'] ?? {};
    final userPatterns = _analyticsData?['userPatterns'] ?? [];

    return Column(
      children: [
        _CardSection(
          title: AppLocalizations.of(context)!.topEndpoints,
          child: Column(
            children: endpointStats.entries.take(5).map<Widget>((entry) {
              final endpoint = entry.key;
              final stats = entry.value;
              final successRate = stats['successRate'] ?? 0;
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.http, size: 16),
                title: Text(
                  endpoint,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _itemTitleStyle,
                ),
                subtitle: Text(
                  AppLocalizations.of(context)!.calls(
                    '${stats['count']}',
                    stats['avgTime']?.toStringAsFixed(1) ?? '0',
                  ),
                  style: _itemSubtitleStyle,
                ),
                trailing: BauhausChip(
                  text: '${successRate.toStringAsFixed(0)}%',
                  color: successRate > 90
                      ? BauhausDesign.success
                      : BauhausDesign.warning,
                  isSmall: true,
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: BauhausDesign.space4),
        _CardSection(
          title: AppLocalizations.of(context)!.topUsers,
          child: Column(
            children: userPatterns.take(5).map<Widget>((user) {
              final displayName =
                  user['userEmail'] ??
                  user['userId'] ??
                  AppLocalizations.of(context)!.unknown;
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.person, size: 16),
                title: Text(displayName, style: _itemTitleStyle),
                subtitle: Text(
                  AppLocalizations.of(context)!.callsAndLast(
                    '${user['totalCalls']}',
                    user['lastActivity']?.split('T').isNotEmpty == true
                        ? user['lastActivity']?.split('T')[0] ??
                              AppLocalizations.of(context)!.unknown
                        : AppLocalizations.of(context)!.unknown,
                  ),
                  style: _itemSubtitleStyle,
                ),
                trailing: BauhausChip(
                  text: user['activityLevel'] ?? 'low',
                  color: user['activityLevel'] == 'high'
                      ? BauhausDesign.primary
                      : BauhausDesign.neutral,
                  isSmall: true,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRateLimitSection() {
    return _CardSection(
      title: AppLocalizations.of(context)!.rateLimit,
      child: Column(
        children: () {
          final List<Widget> items = [];

          // Show configured limits (if available)
          final data = _rateLimitConfig;
          if (data == null) {
            items.add(
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  AppLocalizations.of(context)!.noRateLimitConfig,
                  style: _itemTitleStyle,
                ),
                leading: const Icon(Icons.info, size: 16),
              ),
            );
          } else {
            final mapData = data as Map;
            mapData.entries
                .where((entry) => entry.key != 'default')
                .take(6)
                .forEach((entry) {
                  final endpoint = entry.key.toString();
                  final cfg = entry.value;
                  final maxVal = _asInt(cfg is Map ? cfg['max'] : null);
                  final windowMsVal = _asInt(
                    cfg is Map ? cfg['windowMs'] : null,
                    fallback: 60000,
                  );

                  items.add(
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.lock_clock, size: 16),
                      title: Text(
                        endpoint,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _itemTitleStyle,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context)!.requestsPerMinutes(
                          '$maxVal',
                          '${windowMsVal ~/ 60000}',
                        ),
                        style: _itemSubtitleStyle,
                      ),
                      trailing: BauhausChip(
                        text: '$maxVal',
                        color: maxVal <= 5
                            ? BauhausDesign.error
                            : maxVal <= 10
                            ? BauhausDesign.warning
                            : BauhausDesign.success,
                        isSmall: true,
                      ),
                    ),
                  );
                });
          }

          // Divider between config and current rate-limited users
          items.add(
            const Divider(color: BauhausDesign.neutral, thickness: 0.5),
          );

          // Aggregate current rate-limited entries by IP (blocked IPs + failed attempts)
          final Map<String, Map<String, dynamic>> rateLimitedByIp = {};

          for (final fa in _failedAttempts) {
            final ip = fa is Map ? (fa['ip']?.toString() ?? '') : '';
            if (ip.isEmpty) continue;
            rateLimitedByIp[ip] = {
              'ip': ip,
              'attempts': _asInt(fa['attempts']),
              'lastAttemptAt': (fa['lastAttemptAt'] ?? '').toString(),
              'blockedUntil': null,
            };
          }

          for (final b in _blockedIPs) {
            final ip = b is Map ? (b['ip']?.toString() ?? '') : '';
            if (ip.isEmpty) continue;
            final existing =
                rateLimitedByIp[ip] ??
                {'ip': ip, 'attempts': 0, 'lastAttemptAt': ''};
            existing['blockedUntil'] = (b['expiresAt'] ?? '').toString();
            rateLimitedByIp[ip] = existing;
          }

          final entries = rateLimitedByIp.values.toList();
          // Sort: blocked first, then by attempts desc
          entries.sort((a, b) {
            final aBlocked = (a['blockedUntil'] ?? '').toString().isNotEmpty;
            final bBlocked = (b['blockedUntil'] ?? '').toString().isNotEmpty;
            if (aBlocked != bBlocked) return bBlocked ? 1 : -1; // blocked first
            return (_asInt(b['attempts']) - _asInt(a['attempts']));
          });

          items.add(
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.security, size: 18),
              title: Text(
                AppLocalizations.of(context)!.rateLimitedUsers,
                style: _itemTitleStyle,
              ),
              subtitle: Text(
                AppLocalizations.of(context)!.entries('${entries.length}'),
                style: _itemSubtitleStyle,
              ),
              trailing: TextButton.icon(
                onPressed: entries.isEmpty
                    ? null
                    : () async {
                        // Reset all - use with caution
                        try {
                          final res = await _api.post(
                            'security/rate-limit/reset',
                            headers: _organizationHeaders(),
                            body: {
                              'resetAll': true,
                              if (_organizationId != null)
                                'organizationId': _organizationId,
                            },
                          );
                          if (!mounted) return;
                          if (res['success'] == true) {
                            _showSuccessSnackbar(
                              AppLocalizations.of(context)!.allRateLimitsReset,
                            );
                            _loadAll();
                          } else {
                            _showErrorSnackbar(
                              AppLocalizations.of(context)!.failedToResetAll(
                                (res['message'] ??
                                    AppLocalizations.of(context)!.unknown),
                              ),
                            );
                          }
                        } catch (e) {
                          if (!mounted) return;
                          _showErrorSnackbar(
                            AppLocalizations.of(
                              context,
                            )!.errorResettingAll(e.toString()),
                          );
                        }
                      },
                icon: const Icon(Icons.refresh, size: 16),
                label: Text(AppLocalizations.of(context)!.resetAll),
                style: TextButton.styleFrom(
                  foregroundColor: BauhausDesign.primary,
                ),
              ),
            ),
          );

          if (entries.isEmpty) {
            items.add(
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.verified_user,
                  size: 16,
                  color: BauhausDesign.success,
                ),
                title: Text(
                  AppLocalizations.of(context)!.noRateLimitedUsers,
                  style: _itemTitleStyle,
                ),
              ),
            );
          } else {
            items.addAll(
              entries.take(10).map((e) {
                final ip = (e['ip'] ?? AppLocalizations.of(context)!.unknown)
                    .toString();
                final attempts = _asInt(e['attempts']);
                final lastAttemptAt = (e['lastAttemptAt'] ?? '').toString();
                final blockedUntil = (e['blockedUntil'] ?? '').toString();
                final isBlocked = blockedUntil.isNotEmpty;
                final subtitleParts = <String>[
                  AppLocalizations.of(context)!.attempts('$attempts'),
                  if (lastAttemptAt.isNotEmpty)
                    AppLocalizations.of(context)!.last(
                      (lastAttemptAt.split('T').isNotEmpty
                          ? lastAttemptAt.split('T').first
                          : lastAttemptAt),
                    ),
                  if (isBlocked)
                    AppLocalizations.of(context)!.blockedUntil(
                      (blockedUntil.split('T').length > 1
                          ? '${blockedUntil.split('T')[0]} ${blockedUntil.split('T')[1].substring(0, 5)}'
                          : blockedUntil),
                    ),
                ];

                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    isBlocked ? Icons.lock : Icons.error_outline,
                    size: 16,
                    color: isBlocked
                        ? BauhausDesign.error
                        : BauhausDesign.warning,
                  ),
                  title: Text(ip, style: _itemTitleStyle),
                  subtitle: Text(
                    subtitleParts.join(' • '),
                    style: _itemSubtitleStyle,
                  ),
                  trailing: TextButton.icon(
                    onPressed: () => _resetRateLimitForIp(ip),
                    icon: const Icon(Icons.restore_from_trash, size: 16),
                    label: Text(AppLocalizations.of(context)!.reset),
                    style: TextButton.styleFrom(
                      foregroundColor: BauhausDesign.primary,
                    ),
                  ),
                );
              }),
            );
          }

          return items;
        }(),
      ),
    );
  }

  int _asInt(dynamic v, {int fallback = 0}) {
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? fallback;
    return fallback;
  }

  Widget _buildActiveConnections() {
    return _CardSection(
      title: AppLocalizations.of(context)!.activeConnections,
      child: Column(
        children: _activeConnections.isEmpty
            ? [
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    AppLocalizations.of(context)!.noActiveConnections,
                    style: _itemTitleStyle,
                  ),
                  leading: const Icon(Icons.wifi_off, size: 16),
                ),
              ]
            : _activeConnections.take(5).map<Widget>((connection) {
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.wifi,
                    size: 16,
                    color: BauhausDesign.success,
                  ),
                  title: Text(
                    connection['email'] ??
                        connection['userId'] ??
                        connection['ip'] ??
                        AppLocalizations.of(context)!.unknown,
                    style: _itemTitleStyle,
                  ),
                  subtitle: Text(
                    AppLocalizations.of(context)!.connected(
                      connection['connectedAt']?.split('T').length > 1
                          ? connection['connectedAt']
                                    ?.split('T')[1]
                                    ?.substring(0, 5) ??
                                AppLocalizations.of(context)!.unknown
                          : AppLocalizations.of(context)!.unknown,
                    ),
                    style: _itemSubtitleStyle,
                  ),
                  trailing: BauhausChip(
                    text: '${connection['requests'] ?? 0}',
                    color: BauhausDesign.primary,
                    isSmall: true,
                  ),
                );
              }).toList(),
      ),
    );
  }

  Widget _buildLiveEvents() {
    return _CardSection(
      title: AppLocalizations.of(context)!.liveSse,
      child: Column(
        children: _liveEvents.map<Widget>((ev) {
          final method = ev['method'] ?? '';
          final path = ev['path'] ?? '';
          // Backend payload uses 'status' for HTTP status code
          final status = (ev['status'] ?? '').toString();
          final ip = ev['ip'] ?? '';
          final userEmail = ev['userEmail'] ?? '';
          final userInfo = userEmail.isNotEmpty ? ' • User: $userEmail' : '';
          return ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.bolt, size: 20),
            title: Text(
              '$method $path',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: _itemTitleStyle,
            ),
            subtitle: Text(
              'Status: $status • IP: $ip$userInfo',
              style: _itemSubtitleStyle,
            ),
          );
        }).toList(),
      ),
    );
  }
}

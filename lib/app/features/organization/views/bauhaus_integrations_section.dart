import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/features/organization/models/organization_model.dart' as models;
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/backend/api_method.dart';

class BauhausIntegrationsSection extends ConsumerStatefulWidget {
  final models.Organization organization;
  final Function(String, Map<String, dynamic>) onSave;

  const BauhausIntegrationsSection({
    super.key,
    required this.organization,
    required this.onSave,
  });

  @override
  ConsumerState<BauhausIntegrationsSection> createState() => _BauhausIntegrationsSectionState();
}

class _BauhausIntegrationsSectionState extends ConsumerState<BauhausIntegrationsSection> {
  // Integration states
  bool _xeroConnected = false;
  bool _myobConnected = false;
  bool _googleCalendarConnected = false;
  bool _outlookCalendarConnected = false;
  bool _slackConnected = false;
  bool _teamsConnected = false;
  
  bool _isLoading = false;
  String? _errorMessage;
  
  final ApiMethod _apiMethod = ApiMethod();

  @override
  void initState() {
    super.initState();
    final integrations = widget.organization.integrations;
    _xeroConnected = integrations?.xero?.isConnected ?? false;
    _myobConnected = integrations?.myob?.isConnected ?? false;
    _googleCalendarConnected = integrations?.googleCalendar?.isConnected ?? false;
    _outlookCalendarConnected = integrations?.outlookCalendar?.isConnected ?? false;
    _slackConnected = integrations?.slack?.isConnected ?? false;
    _teamsConnected = integrations?.teams?.isConnected ?? false;
  }

  Future<void> _toggleIntegration(String integrationName, bool currentStatus) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(currentStatus ? 'Disconnecting $integrationName...' : 'Connecting $integrationName...'),
          backgroundColor: BauhausDesign.info,
        ),
      );

      final newStatus = !currentStatus;
      
      // Map display names to integration keys
      final integrationKey = _getIntegrationKey(integrationName);
      
      if (newStatus) {
        // Connect integration - for now just toggle, OAuth flow will be added later
        await _apiMethod.connectIntegration(
          organizationId: widget.organization.id,
          integrationType: integrationKey,
        );
      } else {
        // Disconnect integration
        await _apiMethod.disconnectIntegration(
          organizationId: widget.organization.id,
          integrationType: integrationKey,
        );
      }

      // Update local state on success
      setState(() {
        switch (integrationName) {
          case 'Xero':
            _xeroConnected = newStatus;
            break;
          case 'MYOB':
            _myobConnected = newStatus;
            break;
          case 'Google Calendar':
            _googleCalendarConnected = newStatus;
            break;
          case 'Outlook Calendar':
            _outlookCalendarConnected = newStatus;
            break;
          case 'Slack':
            _slackConnected = newStatus;
            break;
          case 'Microsoft Teams':
            _teamsConnected = newStatus;
            break;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$integrationName ${newStatus ? 'connected' : 'disconnected'} successfully!'),
          backgroundColor: BauhausDesign.success,
        ),
      );

    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to ${currentStatus ? 'disconnect' : 'connect'} $integrationName: ${e.toString()}';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: BauhausDesign.error,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getIntegrationKey(String displayName) {
    switch (displayName) {
      case 'Xero':
        return 'xero';
      case 'MYOB':
        return 'myob';
      case 'Google Calendar':
        return 'googleCalendar';
      case 'Outlook Calendar':
        return 'outlookCalendar';
      case 'Slack':
        return 'slack';
      case 'Microsoft Teams':
        return 'teams';
      default:
        return displayName.toLowerCase().replaceAll(' ', '');
    }
  }

  Future<void> _syncIntegration(String integrationName) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final integrationKey = _getIntegrationKey(integrationName);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Syncing $integrationName...'),
          backgroundColor: BauhausDesign.info,
        ),
      );

      final result = await _apiMethod.syncIntegration(
        organizationId: widget.organization.id,
        integrationType: integrationKey,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? '$integrationName synced successfully!'),
          backgroundColor: BauhausDesign.success,
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to sync $integrationName: ${e.toString()}';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: BauhausDesign.error,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testIntegration(String integrationName) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final integrationKey = _getIntegrationKey(integrationName);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Testing $integrationName connection...'),
          backgroundColor: BauhausDesign.info,
        ),
      );

      final result = await _apiMethod.testIntegration(
        organizationId: widget.organization.id,
        integrationType: integrationKey,
      );

      final isSuccess = result['connected'] == true || result['success'] == true;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 
            (isSuccess ? '$integrationName connection successful!' : '$integrationName connection failed')),
          backgroundColor: isSuccess ? BauhausDesign.success : BauhausDesign.error,
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to test $integrationName: ${e.toString()}';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: BauhausDesign.error,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showIntegrationSettings(String integrationName) {
    final integrationKey = _getIntegrationKey(integrationName);
    
    showDialog(
      context: context,
      builder: (context) => _IntegrationSettingsDialog(
        integrationName: integrationName,
        integrationKey: integrationKey,
        organizationId: widget.organization.id,
        onSave: (settings) async {
          // Save custom credentials
          await widget.onSave(widget.organization.id, {
            'integrations.$integrationKey.customClientId': settings['clientId'],
            'integrations.$integrationKey.customClientSecret': settings['clientSecret'],
            'integrations.$integrationKey.useCustomCredentials': settings['useCustom'],
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$integrationName settings saved!'),
              backgroundColor: BauhausDesign.success,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        // For integrations, we can actually keep a similar vertical list structure
        // but maybe adjust padding or column counts if we had a grid.
        // Currently it's a vertical list of categories, which is already quite responsive.
        // However, we can optimize the Status Summary card to stack on mobile.

        return Container(
          padding: isMobile ? EdgeInsets.zero : const EdgeInsets.all(BauhausDesign.space6),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceOffWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: [BauhausDesign.shadowHard],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: BauhausDesign.primary,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      color: BauhausDesign.surfaceWhite,
                      child: Icon(Icons.link, color: BauhausDesign.primary, size: 24),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'INTEGRATIONS',
                            style: GoogleFonts.inter(
                              fontSize: BauhausDesign.fontLg,
                              fontWeight: FontWeight.w700,
                              color: BauhausDesign.textDark,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Connect your organization with external services',
                            style: GoogleFonts.inter(
                              fontSize: BauhausDesign.fontSm,
                              fontWeight: FontWeight.w400,
                              color: BauhausDesign.textDark.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: BauhausDesign.space6),

              // Accounting Integrations
              _BauhausIntegrationCategory(
                title: 'ACCOUNTING',
                integrations: [
                  _BauhausIntegrationItem(
                    name: 'Xero',
                    description: 'Connect your Xero accounting software',
                    icon: Icons.account_balance,
                    isConnected: _xeroConnected,
                    onToggle: () => _toggleIntegration('Xero', _xeroConnected),
                    onSync: _xeroConnected ? () => _syncIntegration('Xero') : null,
                    onTest: _xeroConnected ? () => _testIntegration('Xero') : null,
                    onSettings: () => _showIntegrationSettings('Xero'),
                    isLoading: _isLoading,
                  ),
                  _BauhausIntegrationItem(
                    name: 'MYOB',
                    description: 'Connect your MYOB accounting software',
                    icon: Icons.account_balance_wallet,
                    isConnected: _myobConnected,
                    onToggle: () => _toggleIntegration('MYOB', _myobConnected),
                    onSync: _myobConnected ? () => _syncIntegration('MYOB') : null,
                    onTest: _myobConnected ? () => _testIntegration('MYOB') : null,
                    onSettings: () => _showIntegrationSettings('MYOB'),
                    isLoading: _isLoading,
                  ),
                ],
              ),

              const SizedBox(height: BauhausDesign.space4),

              // Calendar Integrations
              _BauhausIntegrationCategory(
                title: 'CALENDAR',
                integrations: [
                  _BauhausIntegrationItem(
                    name: 'Google Calendar',
                    description: 'Sync with Google Calendar',
                    icon: Icons.calendar_today,
                    isConnected: _googleCalendarConnected,
                    onToggle: () => _toggleIntegration('Google Calendar', _googleCalendarConnected),
                    onSync: _googleCalendarConnected ? () => _syncIntegration('Google Calendar') : null,
                    onTest: _googleCalendarConnected ? () => _testIntegration('Google Calendar') : null,
                    onSettings: () => _showIntegrationSettings('Google Calendar'),
                    isLoading: _isLoading,
                  ),
                  _BauhausIntegrationItem(
                    name: 'Outlook Calendar',
                    description: 'Sync with Outlook Calendar',
                    icon: Icons.event,
                    isConnected: _outlookCalendarConnected,
                    onToggle: () => _toggleIntegration('Outlook Calendar', _outlookCalendarConnected),
                    onSync: _outlookCalendarConnected ? () => _syncIntegration('Outlook Calendar') : null,
                    onTest: _outlookCalendarConnected ? () => _testIntegration('Outlook Calendar') : null,
                    onSettings: () => _showIntegrationSettings('Outlook Calendar'),
                    isLoading: _isLoading,
                  ),
                ],
              ),

              const SizedBox(height: BauhausDesign.space4),

              // Communication Integrations
              _BauhausIntegrationCategory(
                title: 'COMMUNICATION',
                integrations: [
                  _BauhausIntegrationItem(
                    name: 'Slack',
                    description: 'Send notifications to Slack',
                    icon: Icons.chat_bubble,
                    isConnected: _slackConnected,
                    onToggle: () => _toggleIntegration('Slack', _slackConnected),
                    onSync: _slackConnected ? () => _syncIntegration('Slack') : null,
                    onTest: _slackConnected ? () => _testIntegration('Slack') : null,
                    onSettings: () => _showIntegrationSettings('Slack'),
                    isLoading: _isLoading,
                  ),
                  _BauhausIntegrationItem(
                    name: 'Microsoft Teams',
                    description: 'Send notifications to Teams',
                    icon: Icons.video_call,
                    isConnected: _teamsConnected,
                    onToggle: () => _toggleIntegration('Microsoft Teams', _teamsConnected),
                    onSync: _teamsConnected ? () => _syncIntegration('Microsoft Teams') : null,
                    onTest: _teamsConnected ? () => _testIntegration('Microsoft Teams') : null,
                    onSettings: () => _showIntegrationSettings('Microsoft Teams'),
                    isLoading: _isLoading,
                  ),
                ],
              ),

              const SizedBox(height: BauhausDesign.space6),

              // Integration Status Summary
              _BauhausIntegrationStatusCard(
                totalIntegrations: 6,
                connectedIntegrations: [
                  _xeroConnected,
                  _myobConnected,
                  _googleCalendarConnected,
                  _outlookCalendarConnected,
                  _slackConnected,
                  _teamsConnected,
                ].where((connected) => connected).length,
                isMobile: isMobile,
              ),

              if (_errorMessage != null) ...[
                const SizedBox(height: BauhausDesign.space3),
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.error.withOpacity(0.1),
                    border: Border.all(color: BauhausDesign.error, width: 2),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: GoogleFonts.inter(
                      fontSize: BauhausDesign.fontSm,
                      fontWeight: FontWeight.w500,
                      color: BauhausDesign.error,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _BauhausIntegrationCategory extends StatelessWidget {
  final String title;
  final List<_BauhausIntegrationItem> integrations;

  const _BauhausIntegrationCategory({
    required this.title,
    required this.integrations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            decoration: BoxDecoration(
              color: BauhausDesign.secondary,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontSm,
                    fontWeight: FontWeight.w700,
                    color: BauhausDesign.textDark,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                Text(
                  '${integrations.where((i) => i.isConnected).length}/${integrations.length}',
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontXs,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          ...integrations.map((integration) => 
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: BauhausDesign.neutral.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
              child: integration,
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausIntegrationItem extends StatelessWidget {
  final String name;
  final String description;
  final IconData icon;
  final bool isConnected;
  final VoidCallback onToggle;
  final VoidCallback? onSync;
  final VoidCallback? onTest;
  final VoidCallback? onSettings;
  final bool isLoading;

  const _BauhausIntegrationItem({
    required this.name,
    required this.description,
    required this.icon,
    required this.isConnected,
    required this.onToggle,
    this.onSync,
    this.onTest,
    this.onSettings,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onToggle,
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space3),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  color: isConnected ? BauhausDesign.success : BauhausDesign.neutral,
                  child: Icon(
                    icon,
                    color: BauhausDesign.textDark,
                    size: 20,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontSm,
                          fontWeight: FontWeight.w600,
                          color: BauhausDesign.textDark,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        description,
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontXs,
                          fontWeight: FontWeight.w400,
                          color: BauhausDesign.textDark.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: BauhausDesign.space2),
                if (onSettings != null)
                  InkWell(
                    onTap: isLoading ? null : onSettings,
                    child: Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.only(right: BauhausDesign.space2),
                      decoration: BoxDecoration(
                        color: BauhausDesign.neutral.withOpacity(0.3),
                        border: Border.all(color: BauhausDesign.neutral, width: 1),
                      ),
                      child: Icon(
                        Icons.settings,
                        size: 14,
                        color: BauhausDesign.textDark.withOpacity(0.7),
                      ),
                    ),
                  ),
                Container(
                  width: 60,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isConnected ? BauhausDesign.success : BauhausDesign.neutral,
                    border: Border.all(color: BauhausDesign.neutral, width: 1),
                  ),
                  child: Center(
                    child: isLoading
                        ? const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(strokeWidth: 1),
                          )
                        : Text(
                            isConnected ? 'ON' : 'OFF',
                            style: GoogleFonts.inter(
                              fontSize: BauhausDesign.fontXxs,
                              fontWeight: FontWeight.w700,
                              color: BauhausDesign.textDark,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            if (isConnected && (onSync != null || onTest != null)) ...[
              const SizedBox(height: BauhausDesign.space2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onTest != null)
                    _IntegrationActionButton(
                      label: 'TEST',
                      icon: Icons.check_circle_outline,
                      onPressed: isLoading ? null : onTest,
                      color: BauhausDesign.info,
                    ),
                  if (onTest != null && onSync != null)
                    const SizedBox(width: BauhausDesign.space2),
                  if (onSync != null)
                    _IntegrationActionButton(
                      label: 'SYNC',
                      icon: Icons.sync,
                      onPressed: isLoading ? null : onSync,
                      color: BauhausDesign.primary,
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _IntegrationActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color color;

  const _IntegrationActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space2,
          vertical: BauhausDesign.space1,
        ),
        decoration: BoxDecoration(
          color: onPressed != null ? color.withOpacity(0.1) : BauhausDesign.neutral.withOpacity(0.3),
          border: Border.all(
            color: onPressed != null ? color : BauhausDesign.neutral,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 12,
              color: onPressed != null ? color : BauhausDesign.textDark.withOpacity(0.5),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: BauhausDesign.fontXxs,
                fontWeight: FontWeight.w700,
                color: onPressed != null ? color : BauhausDesign.textDark.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BauhausIntegrationStatusCard extends StatelessWidget {
  final int totalIntegrations;
  final int connectedIntegrations;
  final bool isMobile;

  const _BauhausIntegrationStatusCard({
    required this.totalIntegrations,
    required this.connectedIntegrations,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final completionPercentage = (connectedIntegrations / totalIntegrations * 100).round();
    final isFullyConnected = connectedIntegrations == totalIntegrations;

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: isFullyConnected ? BauhausDesign.success : BauhausDesign.warning,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isFullyConnected ? Icons.check_circle : Icons.info,
                  color: BauhausDesign.textDark,
                  size: 20,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Expanded(
                  child: Text(
                    isFullyConnected 
                        ? 'ALL INTEGRATIONS CONNECTED' 
                        : '$connectedIntegrations OF $totalIntegrations CONNECTED',
                    style: GoogleFonts.inter(
                      fontSize: BauhausDesign.fontSm,
                      fontWeight: FontWeight.w600,
                      color: BauhausDesign.textDark,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Integration Status Summary',
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontMd,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space3),
                if (isMobile) ...[
                  // Mobile Layout (Stacked)
                  _BauhausStatusMetric(
                    label: 'Connected',
                    value: connectedIntegrations.toString(),
                    color: BauhausDesign.success,
                  ),
                  const SizedBox(height: BauhausDesign.space2),
                  _BauhausStatusMetric(
                    label: 'Available',
                    value: totalIntegrations.toString(),
                    color: BauhausDesign.primary,
                  ),
                  const SizedBox(height: BauhausDesign.space2),
                  _BauhausStatusMetric(
                    label: 'Completion',
                    value: '$completionPercentage%',
                    color: isFullyConnected ? BauhausDesign.success : BauhausDesign.warning,
                  ),
                ] else ...[
                  // Desktop Layout (Row)
                  Row(
                    children: [
                      Expanded(
                        child: _BauhausStatusMetric(
                          label: 'Connected',
                          value: connectedIntegrations.toString(),
                          color: BauhausDesign.success,
                        ),
                      ),
                      Expanded(
                        child: _BauhausStatusMetric(
                          label: 'Available',
                          value: totalIntegrations.toString(),
                          color: BauhausDesign.primary,
                        ),
                      ),
                      Expanded(
                        child: _BauhausStatusMetric(
                          label: 'Completion',
                          value: '$completionPercentage%',
                          color: isFullyConnected ? BauhausDesign.success : BauhausDesign.warning,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausStatusMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _BauhausStatusMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: BauhausDesign.fontXs,
              fontWeight: FontWeight.w600,
              color: BauhausDesign.textDark.withOpacity(0.7),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: BauhausDesign.fontLg,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}


class _IntegrationSettingsDialog extends StatefulWidget {
  final String integrationName;
  final String integrationKey;
  final String organizationId;
  final Function(Map<String, dynamic>) onSave;

  const _IntegrationSettingsDialog({
    required this.integrationName,
    required this.integrationKey,
    required this.organizationId,
    required this.onSave,
  });

  @override
  State<_IntegrationSettingsDialog> createState() => _IntegrationSettingsDialogState();
}

class _IntegrationSettingsDialogState extends State<_IntegrationSettingsDialog> {
  final _clientIdController = TextEditingController();
  final _clientSecretController = TextEditingController();
  bool _useCustomCredentials = false;
  bool _showClientSecret = false;

  @override
  void dispose() {
    _clientIdController.dispose();
    _clientSecretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: [BauhausDesign.shadowHard],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.primary,
                border: Border(
                  bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    color: BauhausDesign.surfaceWhite,
                    child: Icon(Icons.settings, color: BauhausDesign.primary, size: 24),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: Text(
                      '${widget.integrationName.toUpperCase()} SETTINGS',
                      style: GoogleFonts.inter(
                        fontSize: BauhausDesign.fontLg,
                        fontWeight: FontWeight.w700,
                        color: BauhausDesign.textDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32,
                      height: 32,
                      color: BauhausDesign.surfaceWhite,
                      child: Icon(Icons.close, color: BauhausDesign.textDark, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(BauhausDesign.space6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info box
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space3),
                    decoration: BoxDecoration(
                      color: BauhausDesign.info.withOpacity(0.1),
                      border: Border.all(color: BauhausDesign.info, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: BauhausDesign.info, size: 20),
                        const SizedBox(width: BauhausDesign.space2),
                        Expanded(
                          child: Text(
                            'Use custom OAuth credentials for this organization, or leave empty to use global credentials.',
                            style: GoogleFonts.inter(
                              fontSize: BauhausDesign.fontXs,
                              fontWeight: FontWeight.w400,
                              color: BauhausDesign.textDark.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: BauhausDesign.space4),

                  // Use custom credentials toggle
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space3),
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceOffWhite,
                      border: Border.all(color: BauhausDesign.neutral, width: 1),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Use Custom OAuth Credentials',
                            style: GoogleFonts.inter(
                              fontSize: BauhausDesign.fontSm,
                              fontWeight: FontWeight.w600,
                              color: BauhausDesign.textDark,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _useCustomCredentials = !_useCustomCredentials;
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 24,
                            decoration: BoxDecoration(
                              color: _useCustomCredentials ? BauhausDesign.success : BauhausDesign.neutral,
                              border: Border.all(color: BauhausDesign.neutral, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                _useCustomCredentials ? 'ON' : 'OFF',
                                style: GoogleFonts.inter(
                                  fontSize: BauhausDesign.fontXxs,
                                  fontWeight: FontWeight.w700,
                                  color: BauhausDesign.textDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (_useCustomCredentials) ...[
                    const SizedBox(height: BauhausDesign.space4),

                    // Client ID field
                    Text(
                      'CLIENT ID',
                      style: GoogleFonts.inter(
                        fontSize: BauhausDesign.fontXs,
                        fontWeight: FontWeight.w700,
                        color: BauhausDesign.textDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    Container(
                      decoration: BoxDecoration(
                        color: BauhausDesign.surfaceWhite,
                        border: Border.all(color: BauhausDesign.neutral, width: 2),
                      ),
                      child: TextField(
                        controller: _clientIdController,
                        decoration: InputDecoration(
                          hintText: 'Enter your OAuth Client ID',
                          hintStyle: GoogleFonts.inter(
                            fontSize: BauhausDesign.fontSm,
                            color: BauhausDesign.textDark.withOpacity(0.4),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(BauhausDesign.space3),
                        ),
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontSm,
                          color: BauhausDesign.textDark,
                        ),
                      ),
                    ),

                    const SizedBox(height: BauhausDesign.space4),

                    // Client Secret field
                    Text(
                      'CLIENT SECRET',
                      style: GoogleFonts.inter(
                        fontSize: BauhausDesign.fontXs,
                        fontWeight: FontWeight.w700,
                        color: BauhausDesign.textDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    Container(
                      decoration: BoxDecoration(
                        color: BauhausDesign.surfaceWhite,
                        border: Border.all(color: BauhausDesign.neutral, width: 2),
                      ),
                      child: TextField(
                        controller: _clientSecretController,
                        obscureText: !_showClientSecret,
                        decoration: InputDecoration(
                          hintText: 'Enter your OAuth Client Secret',
                          hintStyle: GoogleFonts.inter(
                            fontSize: BauhausDesign.fontSm,
                            color: BauhausDesign.textDark.withOpacity(0.4),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(BauhausDesign.space3),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _showClientSecret = !_showClientSecret;
                              });
                            },
                            child: Icon(
                              _showClientSecret ? Icons.visibility_off : Icons.visibility,
                              color: BauhausDesign.textDark.withOpacity(0.6),
                              size: 20,
                            ),
                          ),
                        ),
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontSm,
                          color: BauhausDesign.textDark,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: BauhausDesign.space6),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: BauhausDesign.space4,
                            vertical: BauhausDesign.space3,
                          ),
                          decoration: BoxDecoration(
                            color: BauhausDesign.neutral,
                            border: Border.all(color: BauhausDesign.neutral, width: 2),
                          ),
                          child: Text(
                            'CANCEL',
                            style: GoogleFonts.inter(
                              fontSize: BauhausDesign.fontSm,
                              fontWeight: FontWeight.w700,
                              color: BauhausDesign.textDark,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      InkWell(
                        onTap: () {
                          widget.onSave({
                            'clientId': _clientIdController.text,
                            'clientSecret': _clientSecretController.text,
                            'useCustom': _useCustomCredentials,
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: BauhausDesign.space4,
                            vertical: BauhausDesign.space3,
                          ),
                          decoration: BoxDecoration(
                            color: BauhausDesign.success,
                            border: Border.all(color: BauhausDesign.neutral, width: 2),
                            boxShadow: [BauhausDesign.shadowHardSm],
                          ),
                          child: Text(
                            'SAVE',
                            style: GoogleFonts.inter(
                              fontSize: BauhausDesign.fontSm,
                              fontWeight: FontWeight.w700,
                              color: BauhausDesign.textDark,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

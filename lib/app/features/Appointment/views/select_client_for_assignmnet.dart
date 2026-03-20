import 'package:carenest/app/features/Appointment/views/schedule_assignment.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/confirmation_alert_dialog_widget.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/client/models/client_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

class SelectClientForAssignment extends ConsumerStatefulWidget {
  final String userName;
  final String userEmail;

  const SelectClientForAssignment(
      {super.key, required this.userName, required this.userEmail});

  @override
  ConsumerState<SelectClientForAssignment> createState() =>
      _DropdownMenuState();
}

class _DropdownMenuState extends ConsumerState<SelectClientForAssignment>
    with TickerProviderStateMixin {
  late Future<List<Patient>> futureClientsData;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  List<Patient> _filteredClients = [];
  List<Patient> _allClients = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    final apiMethod = ref.read(app_providers.apiMethodProvider);
    futureClientsData = apiMethod.fetchClientData();
    debugPrint('futureClientsData: $futureClientsData');
    futureClientsData.then((clients) {
      debugPrint('clients: $clients');
    });
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  /// Function to filter clients based on search query
  void _filterClients(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredClients = _allClients;
        _isSearching = false;
      } else {
        _isSearching = true;
        _filteredClients = _allClients
            .where((client) =>
                client.displayName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _returnToAdminDashboard() async {
    final sharedPrefs = SharedPreferencesUtils();
    await sharedPrefs.init();

    final userEmail =
        await sharedPrefs.getUserEmailFromSharedPreferences() ?? '';
    final role = sharedPrefs.getRole() ?? UserRole.admin;
    final organizationId = sharedPrefs.getOrganizationId() ?? '';
    final organizationName = sharedPrefs.getString('organizationName') ?? '';
    final organizationCode = sharedPrefs.getOrganizationCode() ?? '';

    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.bottomNavBar,
      (route) => false,
      arguments: {
        'email': userEmail,
        'role': role,
        'organizationId': organizationId,
        'organizationName': organizationName,
        'organizationCode': organizationCode,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _returnToAdminDashboard();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: BauhausDesign.backgroundLight,
        appBar: _buildAppBar(context),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              _buildSearchBar(),
              Expanded(
                child: FutureBuilder<List<Patient>>(
                  future: futureClientsData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildLoadingState();
                    } else if (snapshot.hasError) {
                      return _buildErrorState(snapshot.error.toString());
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return _buildEmptyState();
                    } else {
                      _allClients = snapshot.data!;
                      if (_filteredClients.isEmpty && !_isSearching) {
                        _filteredClients = _allClients;
                      }

                      List<Patient> clientsToShow =
                          _isSearching ? _filteredClients : _allClients;

                      if (clientsToShow.isEmpty && _isSearching) {
                        return _buildNoSearchResultsState();
                      }

                      return _buildClientsList(clientsToShow);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build modern app bar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: BauhausDesign.primary,
      foregroundColor: BauhausDesign.surfaceWhite,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Client',
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                  color: BauhausDesign.surfaceWhite,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            'for ${widget.userName}',
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.surfaceWhite.withOpacity(0.7),
                ),
          ),
        ],
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: BauhausDesign.surfaceWhite),
        onPressed: _returnToAdminDashboard,
      ),
    );
  }

  /// Build search bar
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(
          color: BauhausDesign.neutral,
          width: 1.5,
        ),
        boxShadow: const [BauhausDesign.shadowSoft],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _filterClients,
        decoration: InputDecoration(
          hintText: 'Search clients...',
          hintStyle: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                color: BauhausDesign.textMuted,
              ),
          filled: false,
          fillColor: Colors.transparent,
          prefixIcon: Icon(
            Icons.search,
            color: BauhausDesign.textMuted,
          ),
          suffixIcon: _isSearching
              ? IconButton(
                  icon: Icon(Icons.clear, color: BauhausDesign.textMuted),
                  onPressed: () {
                    _searchController.clear();
                    _filterClients('');
                  },
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space4,
            vertical: BauhausDesign.space4,
          ),
        ),
      ),
    );
  }

  /// Build clients list
  Widget _buildClientsList(List<Patient> clients) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
      itemCount: clients.length,
      itemBuilder: (context, index) {
        Patient client = clients[index];
        return _buildClientCard(client, index);
      },
    );
  }

  /// Build individual client card
  Widget _buildClientCard(Patient client, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.only(bottom: BauhausDesign.space3),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                boxShadow: const [BauhausDesign.shadowSoft],
                border: Border.all(
                  color: BauhausDesign.neutral,
                  width: 1,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  onTap: () => _showConfirmationDialog(client),
                  child: Padding(
                    padding: const EdgeInsets.all(BauhausDesign.space4),
                    child: Row(
                      children: [
                        // Avatar
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: BauhausDesign.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                color: BauhausDesign.primary, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              client.displayName.substring(0, 1).toUpperCase(),
                              style: BauhausDesign.getTextTheme(context)
                                  .headlineSmall
                                  ?.copyWith(
                                    color: BauhausDesign.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space4),
                        // Client info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                client.displayName,
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: BauhausDesign.textDark,
                                    ),
                              ),
                              const SizedBox(height: BauhausDesign.space1),
                              Text(
                                client.clientEmail,
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyMedium
                                    ?.copyWith(
                                      color: BauhausDesign.textMuted,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        // Arrow icon
                        Icon(
                          Icons.arrow_forward_ios,
                          color: BauhausDesign.neutral,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Show confirmation dialog
  void _showConfirmationDialog(Patient client) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return ConfirmationAlertDialog(
          title: 'Confirm Assignment',
          content:
              'Are you sure you want to assign ${client.displayName} to ${widget.userName}?',
          confirmAction: () {
            Navigator.of(dialogContext).pop();
            // Add a small delay to ensure dialog is fully closed before navigation
            Future.delayed(const Duration(milliseconds: 100), () {
              // if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ScheduleAssignment(
                    userEmail: widget.userEmail,
                    clientEmail: client.clientEmail,
                    clientId:
                        (client.id != null && client.id!.trim().isNotEmpty)
                            ? client.id
                            : client.clientEmail,
                  ),
                ),
              );
              // }
            });
          },
        );
      },
    );
  }

  /// Build loading state
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(BauhausDesign.primary),
          ),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            'Loading clients...',
            style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
        ],
      ),
    );
  }

  /// Build error state
  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: BauhausDesign.error,
          ),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            'Error loading clients',
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            error,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build empty state
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: BauhausDesign.neutral,
          ),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            'No clients found',
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            'There are no clients available to assign.',
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
        ],
      ),
    );
  }

  /// Build no search results state
  Widget _buildNoSearchResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: BauhausDesign.neutral,
          ),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            'No results found',
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            'Try adjusting your search terms.',
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
        ],
      ),
    );
  }
}

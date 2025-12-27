import 'package:carenest/app/features/Appointment/views/schedule_assignment.dart';
import 'package:carenest/app/shared/widgets/confirmation_alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/backend/api_method.dart';

class SelectClientForAssignment extends StatefulWidget {
  final String userName;
  final String userEmail;

  const SelectClientForAssignment(
      {super.key, required this.userName, required this.userEmail});

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<SelectClientForAssignment>
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
    ApiMethod apiMethod = ApiMethod();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
    );
  }

  /// Build modern app bar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      foregroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Client',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.white,
            ),
          ),
          Text(
            'for ${widget.userName}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ],
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios,
            color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// Build search bar
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isSearching
              ? const Color(0xFF007AFF)
              : const Color(0xFFEEEEEE),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _filterClients,
        decoration: InputDecoration(
          hintText: 'Search clients...',
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: const Color(0xFFBDBDBD),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: _isSearching
                ? const Color(0xFF007AFF)
                : const Color(0xFFBDBDBD),
          ),
          suffixIcon: _isSearching
              ? IconButton(
                  icon: Icon(Icons.clear,
                      color: const Color(0xFFBDBDBD)),
                  onPressed: () {
                    _searchController.clear();
                    _filterClients('');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  /// Build clients list
  Widget _buildClientsList(List<Patient> clients) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                border: Border.all(
                  color: const Color(0xFFEEEEEE),
                  width: 1,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _showConfirmationDialog(client),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Avatar
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF007AFF)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              client.displayName.substring(0, 1).toUpperCase(),
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: const Color(0xFF007AFF),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Client info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                client.displayName,
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF212121),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                client.clientEmail,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: const Color(0xFF757575),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Arrow icon
                        Icon(
                          Icons.arrow_forward_ios,
                          color: const Color(0xFFBDBDBD),
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
          const CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Color(0xFF007AFF)),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading clients...',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: const Color(0xFF757575),
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
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Color(0xFFFF3B30),
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading clients',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: const Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: const Color(0xFF757575),
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
            color: const Color(0xFFBDBDBD),
          ),
          const SizedBox(height: 16),
          Text(
            'No clients found',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: const Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'There are no clients available to assign.',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: const Color(0xFF757575),
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
            color: const Color(0xFFBDBDBD),
          ),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: const Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search terms.',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: const Color(0xFF757575),
            ),
          ),
        ],
      ),
    );
  }

  // ApiMethod apiMethod = new ApiMethod();
  // Future<dynamic> _AssignClientToUser(
  //     String userEmail, String clientEmail) async {
  //   var ins = await apiMethod.assignClientToUser(userEmail, clientEmail);
  //   debugPrint("Response: " + ins.toString());
  //   return ins;
  // }
}

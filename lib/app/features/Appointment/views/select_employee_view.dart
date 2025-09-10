import 'package:carenest/app/features/Appointment/views/select_client_for_assignmnet.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignC2E extends ConsumerStatefulWidget {
  const AssignC2E({super.key});

  @override
  ConsumerState<AssignC2E> createState() => _AssignC2EState();
}

class _AssignC2EState extends ConsumerState<AssignC2E>
    with TickerProviderStateMixin {
  final ApiMethod _apiMethod = ApiMethod();
  late Future<List<User>> futureUserData;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  List<User> _filteredUsers = [];
  List<User> _allUsers = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    futureUserData = _apiMethod.fetchUserData();
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

  /// Function to filter users based on search query
  void _filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredUsers = _allUsers;
        _isSearching = false;
      } else {
        _isSearching = true;
        _filteredUsers = _allUsers
            .where((user) =>
                user.name.toLowerCase().contains(query.toLowerCase()) ||
                user.email.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  /// Build modern employee card widget
  Widget _buildEmployeeCard(User user, int index) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _fadeAnimation.value)),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ModernInvoiceDesign.surface,
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusXl),
                boxShadow: ModernInvoiceDesign.shadowMd,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SelectClientForAssignment(
                          userName: user.name,
                          userEmail: user.email,
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        // Avatar
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: ModernInvoiceDesign.primaryGradient,
                            borderRadius: BorderRadius.circular(
                                ModernInvoiceDesign.radiusXl),
                          ),
                          child: Center(
                            child: Text(
                              user.name.isNotEmpty
                                  ? user.name[0].toUpperCase()
                                  : 'U',
                              style:
                                  ModernInvoiceDesign.headlineMedium.copyWith(
                                color: ModernInvoiceDesign.textOnPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // User Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ModernInvoiceDesign.textPrimary,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.email,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: ModernInvoiceDesign.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        // Arrow Icon
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ModernInvoiceDesign.neutral100,
                            borderRadius: BorderRadius.circular(
                                ModernInvoiceDesign.radiusMd),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: ModernInvoiceDesign.textSecondary,
                          ),
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

  /// Build search bar widget
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.surface,
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
        boxShadow: ModernInvoiceDesign.shadowSm,
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _filterUsers,
        decoration: InputDecoration(
          hintText: 'Search employees...',
          hintStyle: TextStyle(
            color: ModernInvoiceDesign.textSecondary.withValues(alpha: 0.7),
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: ModernInvoiceDesign.textSecondary,
          ),
          suffixIcon: _isSearching
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: ModernInvoiceDesign.textSecondary,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    _filterUsers('');
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

  /// Build empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _isSearching ? Icons.search_off : Icons.people_outline,
            size: 64,
            color: ModernInvoiceDesign.neutral400,
          ),
          const SizedBox(height: 16),
          Text(
            _isSearching ? 'No employees found' : 'No employees available',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ModernInvoiceDesign.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            _isSearching
                ? 'Try adjusting your search terms'
                : 'Add employees to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ModernInvoiceDesign.textTertiary,
                ),
          ),
        ],
      ),
    );
  }

  /// Build error state widget
  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: ModernInvoiceDesign.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ModernInvoiceDesign.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ModernInvoiceDesign.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                futureUserData = _apiMethod.fetchUserData();
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ModernInvoiceDesign.primary,
              foregroundColor: ModernInvoiceDesign.textOnPrimary,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusMd),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ModernInvoiceDesign.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ModernInvoiceDesign.surface,
        foregroundColor: ModernInvoiceDesign.textPrimary,
        title: Text(
          'Employee List',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: ModernInvoiceDesign.textPrimary,
              ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: FutureBuilder<List<User>>(
              future: futureUserData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ModernInvoiceDesign.primary,
                      ),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return _buildErrorState(snapshot.error.toString());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _buildEmptyState();
                }

                // Update the user lists when data is available
                if (_allUsers.isEmpty) {
                  _allUsers = snapshot.data!;
                  _filteredUsers = _allUsers;
                }

                final usersToShow = _filteredUsers.isEmpty && !_isSearching
                    ? _allUsers
                    : _filteredUsers;

                if (usersToShow.isEmpty && _isSearching) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: usersToShow.length,
                  itemBuilder: (context, index) {
                    return _buildEmployeeCard(usersToShow[index], index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

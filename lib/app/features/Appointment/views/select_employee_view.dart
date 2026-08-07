import 'package:carenest/app/features/Appointment/views/select_client_for_assignmnet.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

class AssignC2E extends ConsumerStatefulWidget {
  const AssignC2E({super.key});

  @override
  ConsumerState<AssignC2E> createState() => _AssignC2EState();
}

class _AssignC2EState extends ConsumerState<AssignC2E>
    with TickerProviderStateMixin {
  late final ApiMethod _apiMethod;
  late Future<List<User>> futureUserData;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  List<User> _filteredUsers = [];
  List<User> _allUsers = [];
  bool _isSearching = false;

  /// Keep assignable staff in picker; exclude only client accounts.
  List<User> _extractEmployeeUsers(List<User> users) {
    return users.where((user) {
      if (user.email.trim().isEmpty) return false;
      return user.role != UserRole.client;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _apiMethod = ref.read(app_providers.apiMethodProvider);
    futureUserData = _apiMethod.fetchUserData();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
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
            .where(
              (user) =>
                  user.name.toLowerCase().contains(query.toLowerCase()) ||
                  user.email.toLowerCase().contains(query.toLowerCase()),
            )
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
                color: BauhausDesign.surfaceWhite,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
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
                              var tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(BauhausDesign.space5),
                    child: Row(
                      children: [
                        // Avatar
                        ProfileImageWidget(
                          imageUrl: user.profilePic,
                          size: 56,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(
                            BauhausDesign.radiusMd,
                          ),
                          borderWidth: 1.5,
                          borderColor: BauhausDesign.neutral,
                          elevation: 0,
                          showLoading: true,
                        ),
                        const SizedBox(width: BauhausDesign.space4),
                        // User Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: BauhausDesign.getTextTheme(context)
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: BauhausDesign.textDark,
                                    ),
                              ),
                              const SizedBox(height: BauhausDesign.space1),
                              Text(
                                user.email,
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyMedium
                                    ?.copyWith(color: BauhausDesign.textMuted),
                              ),
                            ],
                          ),
                        ),
                        // Arrow Icon
                        Container(
                          padding: const EdgeInsets.all(BauhausDesign.space2),
                          decoration: BoxDecoration(
                            color: BauhausDesign.backgroundLight,
                            borderRadius: BorderRadius.circular(
                              BauhausDesign.radiusSm,
                            ),
                            border: Border.all(
                              color: BauhausDesign.neutral,
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: BauhausDesign.textMuted,
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
      margin: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
        boxShadow: const [BauhausDesign.shadowSoft],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _filterUsers,
        decoration: InputDecoration(
          hintText: 'Search employees...',
          hintStyle: TextStyle(color: BauhausDesign.textMuted.withOpacity(0.5)),
          filled: false,
          fillColor: Colors.transparent,
          prefixIcon: Icon(Icons.search, color: BauhausDesign.textMuted),
          suffixIcon: _isSearching
              ? IconButton(
                  icon: Icon(Icons.clear, color: BauhausDesign.textMuted),
                  onPressed: () {
                    _searchController.clear();
                    _filterUsers('');
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

  /// Build empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _isSearching ? Icons.search_off : Icons.people_outline,
            size: 64,
            color: BauhausDesign.neutral,
          ),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            _isSearching ? 'No employees found' : 'No employees available',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
              color: BauhausDesign.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            _isSearching
                ? 'Try adjusting your search terms'
                : 'Add employees to get started',
            style: BauhausDesign.getTextTheme(
              context,
            ).bodyMedium?.copyWith(color: BauhausDesign.neutral),
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
          Icon(Icons.error_outline, size: 64, color: BauhausDesign.error),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            'Something went wrong',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            error,
            style: BauhausDesign.getTextTheme(
              context,
            ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: BauhausDesign.space6),
          BauhausButton(
            text: 'Try Again',
            icon: Icons.refresh,
            onPressed: () {
              setState(() {
                futureUserData = _apiMethod.fetchUserData();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BauhausDesign.surfaceWhite,
        foregroundColor: BauhausDesign.textDark,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          'Employee List',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: BauhausDesign.textDark,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 1.5),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: FutureBuilder<List<User>>(
              future: futureUserData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        BauhausDesign.primary,
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
                  _allUsers = _extractEmployeeUsers(snapshot.data!);
                  _filteredUsers = _allUsers;
                }

                final usersToShow = _filteredUsers.isEmpty && !_isSearching
                    ? _allUsers
                    : _filteredUsers;

                if (usersToShow.isEmpty && _isSearching) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: BauhausDesign.space4),
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

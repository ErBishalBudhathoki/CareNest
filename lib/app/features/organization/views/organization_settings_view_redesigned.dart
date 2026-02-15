import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';
import 'package:carenest/app/features/organization/models/organization_model.dart';
import 'package:carenest/app/features/organization/viewmodels/organization_viewmodel.dart';
import 'package:carenest/app/features/organization/views/bauhaus_integrations_section.dart';
import 'package:carenest/app/features/organization/views/bauhaus_branding_section.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class OrganizationSettingsRedesigned extends ConsumerStatefulWidget {
  const OrganizationSettingsRedesigned({super.key});

  @override
  ConsumerState<OrganizationSettingsRedesigned> createState() => _OrganizationSettingsRedesignedState();
}

class _OrganizationSettingsRedesignedState extends ConsumerState<OrganizationSettingsRedesigned>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();
    
    // Load organization data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orgId = ref.read(organizationIdProvider);
      if (orgId != null) {
        ref.read(organizationViewModelProvider.notifier).loadOrganization(orgId);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onStepTapped(int index) {
    setState(() {
      _currentStep = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final orgId = ref.watch(organizationIdProvider);
    final theme = Theme.of(context);
    
    // Handle the case where no organization is selected
    if (orgId == null) {
      return Scaffold(
        backgroundColor: BauhausDesign.backgroundLight,
        appBar: AppBar(
          title: Text(
            'Organization Settings',
            style: GoogleFonts.inter(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w600,
              fontSize: BauhausDesign.fontLg,
            ),
          ),
          backgroundColor: BauhausDesign.surfaceWhite,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: BauhausDesign.neutral, height: 1.0),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: BauhausDesign.textDark),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(BauhausDesign.space8),
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: [BauhausDesign.shadowHard],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.business_outlined, size: 48, color: BauhausDesign.textMuted),
                const SizedBox(height: BauhausDesign.space4),
                Text(
                  'No Organization Selected',
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontLg,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  'Please select an organization from the dashboard to configure settings.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontSm,
                    color: BauhausDesign.textMuted,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space6),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: BauhausDesign.textDark,
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space6,
                      vertical: BauhausDesign.space3,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
                    'BACK TO DASHBOARD',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final organizationAsync = ref.watch(organizationViewModelProvider);
    
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: organizationAsync.when(
        loading: () => const _BauhausLoadingScreen(),
        error: (error, stackTrace) => _BauhausErrorScreen(
          error: error,
          onRetry: () {
            if (orgId != null) {
              ref.read(organizationViewModelProvider.notifier).loadOrganization(orgId);
            }
          },
        ),
        data: (organization) {
          if (organization == null) {
            return const _BauhausErrorScreen(error: 'Organization not found');
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 800;
              
              if (isDesktop) {
                return _buildDesktopLayout(organization);
              } else {
                return _buildMobileLayout(organization);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout(Organization organization) {
    return Row(
      children: [
        // Left Navigation Sidebar
        _BauhausSidebar(
          currentStep: _currentStep,
          onStepTapped: _onStepTapped,
        ),

        // Main Content Area
        Expanded(
          child: Column(
            children: [
              // Header
              _BauhausHeader(organization: organization),

              // Content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _buildPageContent(organization),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(Organization organization) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: CustomScrollView(
        slivers: [
          _buildEnhancedHeaderSliver(organization),
          SliverFillRemaining(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _buildPageContent(organization),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: BauhausDesign.neutral, width: 2)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentStep,
          onTap: _onStepTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: BauhausDesign.surfaceWhite,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: BauhausDesign.textMuted,
          selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 12),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.palette_outlined),
              label: 'Branding',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.extension),
              label: 'Integrations',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_system_daydream_outlined),
              label: 'System',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedHeaderSliver(Organization organization) {
    final theme = Theme.of(context);
    return SliverAppBar(
      expandedHeight: 120.0,
      pinned: true,
      floating: false,
      elevation: 0,
      backgroundColor: theme.primaryColor,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              boxShadow: const [BauhausDesign.shadowHardSm],
            ),
            child: const Icon(Icons.arrow_back, color: BauhausDesign.textDark, size: 20),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: theme.primaryColor,
            border: const Border(
              bottom: BorderSide(
                color: BauhausDesign.neutral,
                width: 2,
              ),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Organization Settings',
                            style: GoogleFonts.oswald(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: BauhausDesign.space1),
                          Text(
                            'Configure branding, integrations, and system preferences',
                            style: GoogleFonts.inter(
                              fontSize: BauhausDesign.fontSm,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageContent(Organization organization) {
    return [
      // 1. Branding
      SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BauhausBrandingSection(
              organization: organization,
              onSave: (id, updates) => ref
                  .read(organizationProvider.notifier)
                  .updateBranding(id, updates),
            ),
          ],
        ),
      ),

      // 2. Integrations
      SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BauhausIntegrationsSection(
              organization: organization,
              onSave: (id, updates) => ref
                  .read(organizationViewModelProvider.notifier)
                  .saveOrganization(id, updates),
            ),
          ],
        ),
      ),

      // 3. System (New Tab)
      SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSystemSettings(organization),
          ],
        ),
      ),
    ];
  }

  Widget _buildSystemSettings(Organization organization) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.settings_system_daydream_outlined, size: 24, color: BauhausDesign.textDark),
                const SizedBox(width: BauhausDesign.space3),
                Text(
                  'System Preferences',
                  style: GoogleFonts.oswald(
                    fontSize: BauhausDesign.fontLg,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              children: [
                _buildSystemOption(
                  title: 'Audit Logs',
                  description: 'Enable detailed logging for all user actions',
                  value: true,
                  onChanged: (val) {},
                ),
                const Divider(),
                _buildSystemOption(
                  title: 'Two-Factor Authentication',
                  description: 'Enforce 2FA for all organization members',
                  value: false,
                  onChanged: (val) {},
                ),
                const Divider(),
                _buildSystemOption(
                  title: 'Maintenance Mode',
                  description: 'Temporarily disable access for non-admin users',
                  value: false,
                  onChanged: (val) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemOption({
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: BauhausDesign.fontMd,
                  fontWeight: FontWeight.w600,
                  color: BauhausDesign.textDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: BauhausDesign.fontSm,
                  color: BauhausDesign.textMuted,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}

class _BauhausSidebar extends StatelessWidget {
  final int currentStep;
  final Function(int) onStepTapped;

  const _BauhausSidebar({
    required this.currentStep,
    required this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          right: BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: BauhausDesign.space6),
          _SidebarItem(
            index: 0,
            title: 'Branding',
            subtitle: 'Theme & Logo',
            icon: Icons.palette_outlined,
            isSelected: currentStep == 0,
            onTap: () => onStepTapped(0),
            activeColor: theme.primaryColor,
          ),
          _SidebarItem(
            index: 1,
            title: 'Integrations',
            subtitle: 'Xero, MYOB, etc.',
            icon: Icons.extension,
            isSelected: currentStep == 1,
            onTap: () => onStepTapped(1),
            activeColor: theme.primaryColor,
          ),
          _SidebarItem(
            index: 2,
            title: 'System',
            subtitle: 'Audit & Security',
            icon: Icons.settings_system_daydream_outlined,
            isSelected: currentStep == 2,
            onTap: () => onStepTapped(2),
            activeColor: theme.primaryColor,
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color activeColor;

  const _SidebarItem({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space4,
          vertical: BauhausDesign.space4,
        ),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withOpacity(0.1) : Colors.transparent,
          border: Border(
            right: BorderSide(
              color: isSelected ? activeColor : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? activeColor : BauhausDesign.textMuted,
              size: 24,
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: BauhausDesign.fontSm,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? BauhausDesign.textDark : BauhausDesign.textMuted,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: BauhausDesign.fontXs,
                      color: BauhausDesign.textMuted,
                    ),
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

class _BauhausHeader extends StatelessWidget {
  final Organization organization;

  const _BauhausHeader({required this.organization});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space6,
        vertical: BauhausDesign.space4,
      ),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceLight,
              border: Border.all(color: BauhausDesign.neutral),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            ),
            child: const Icon(Icons.tune, color: BauhausDesign.textDark),
          ),
          const SizedBox(width: BauhausDesign.space4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CONFIGURATION CONSOLE',
                style: GoogleFonts.inter(
                  fontSize: BauhausDesign.fontSm,
                  fontWeight: FontWeight.w700,
                  color: BauhausDesign.textMuted,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                organization.name,
                style: GoogleFonts.inter(
                  fontSize: BauhausDesign.fontXl,
                  fontWeight: FontWeight.w600,
                  color: BauhausDesign.textDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BauhausLoadingScreen extends StatelessWidget {
  const _BauhausLoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            'LOADING SETTINGS...',
            style: GoogleFonts.inter(
              fontSize: BauhausDesign.fontSm,
              fontWeight: FontWeight.w600,
              color: BauhausDesign.textMuted,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausErrorScreen extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;

  const _BauhausErrorScreen({required this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space8),
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          border: Border.all(color: BauhausDesign.error, width: 2),
          boxShadow: [BauhausDesign.shadowHard],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: BauhausDesign.error),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              'Configuration Error',
              style: GoogleFonts.inter(
                fontSize: BauhausDesign.fontLg,
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
              ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              'Unable to load organization settings.',
              style: GoogleFonts.inter(
                fontSize: BauhausDesign.fontMd,
                color: BauhausDesign.textDark,
              ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              'Please try again later or contact support if the issue persists.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: BauhausDesign.fontSm,
                color: BauhausDesign.textMuted,
                fontStyle: FontStyle.italic,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: BauhausDesign.space6),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.textDark,
                  foregroundColor: BauhausDesign.surfaceWhite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space6,
                    vertical: BauhausDesign.space3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  'RETRY',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

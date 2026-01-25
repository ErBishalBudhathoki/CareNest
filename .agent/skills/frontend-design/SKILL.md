---
name: flutter-mobile-design
description: Create distinctive, production-grade Flutter mobile interfaces with high design quality using Riverpod MVVM architecture and Bauhaus design system. Generates creative, polished, and accessible Flutter code that avoids generic mobile UI patterns.
license: Complete terms in LICENSE.txt
---

This skill guides creation of distinctive, production-grade Flutter mobile interfaces that avoid generic "AI slop" aesthetics. Implement real working code with exceptional attention to aesthetic details, responsive design, and architecture best practices.

The user provides mobile app requirements: a screen, component, feature, or application to build. They may include context about the purpose, audience, or technical constraints.

## Architecture Requirements

All Flutter code must follow these architectural patterns:

### Riverpod MVVM Structure
- **View**: Stateless/StatefulWidget that observes state via `ConsumerWidget` or `ConsumerStatefulWidget`
- **ViewModel**: Riverpod provider (StateNotifier, AsyncNotifier, or Notifier) managing business logic and state
- **Model**: Data classes using `freezed` for immutability and serialization
- **Separation**: Views only handle UI, ViewModels handle logic, Models represent data

Example structure:
```dart
// Model
@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String id,
    required String name,
  }) = _UserModel;
}

// ViewModel
class UserViewModel extends StateNotifier<AsyncValue<UserModel>> {
  UserViewModel() : super(const AsyncValue.loading());
  
  Future<void> loadUser() async {
    // Business logic here
  }
}

final userViewModelProvider = StateNotifierProvider<UserViewModel, AsyncValue<UserModel>>((ref) {
  return UserViewModel();
});

// View
class UserScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userViewModelProvider);
    // UI implementation
  }
}
```

### Bauhaus Design System Integration
- **Use existing design tokens**: Reference color schemes, typography scales, spacing units, and component styles from the Bauhaus system
- **Consistency**: Apply design system components and patterns throughout
- **Customization**: When creating new components, ensure they align with Bauhaus principles (geometric forms, primary colors, functional design, asymmetric balance)
- **Theme access**: Use `Theme.of(context)` to access design system values

### App Localization
- **Always use localization**: Never hardcode strings; use app localization files
- **Pattern**: `AppLocalizations.of(context)!.keyName` or shorthand like `context.l10n.keyName`
- **Comments**: Include localization keys in comments for reference
- **Fallbacks**: Handle null cases gracefully with fallback text

Example:
```dart
Text(
  AppLocalizations.of(context)!.welcomeMessage, // l10n: welcome_message
  style: Theme.of(context).textTheme.headlineMedium,
)
```

## Responsive Design Requirements

### Dynamic Sizing & Spacing
- **MediaQuery**: Use `MediaQuery.of(context).size` to get screen dimensions
- **Responsive scaling**: Implement proportional sizing based on screen width/height
- **Breakpoints**: Define and use breakpoints for phone, tablet, and large screens
- **Adaptive layouts**: Adjust column counts, grid spacing, and component sizes per screen size

Example:
```dart
final screenWidth = MediaQuery.of(context).size.width;
final isTablet = screenWidth > 600;
final spacing = screenWidth * 0.04; // 4% of screen width

Container(
  width: screenWidth * 0.9,
  padding: EdgeInsets.all(spacing),
  // ...
)
```

### Layout Patterns
- **Flexible/Expanded**: Use for proportional space distribution
- **LayoutBuilder**: For complex responsive logic based on constraints
- **AspectRatio**: Maintain proportions across screen sizes
- **FittedBox**: Scale widgets to fit available space
- **SafeArea**: Always wrap screens to handle notches and system UI

## Design Thinking

Before coding, understand the context and commit to a BOLD aesthetic direction:

- **Purpose**: What problem does this screen/feature solve? Who are the users?
- **Mobile-First Thinking**: Consider touch targets, thumb zones, one-handed use, gestures
- **Tone**: Pick a strong direction: brutally minimal, vibrant/energetic, sophisticated/luxury, playful/whimsical, editorial/content-focused, data-dense/dashboard, immersive/media-rich, etc.
- **Constraints**: Performance (60fps animations), battery efficiency, network conditions, accessibility
- **Differentiation**: What makes this UNFORGETTABLE in the mobile context?

**CRITICAL**: Choose a clear conceptual direction and execute it with precision. Mobile interfaces demand clarity - every pixel counts. Bold maximalism and refined minimalism both work; the key is intentionality and context-appropriate execution.

## Flutter Design Guidelines

### Typography
- **Distinctive fonts**: Use Google Fonts package for unique, beautiful typefaces beyond system defaults
- **Avoid generic**: Never settle for Roboto or default sans-serif without consideration
- **Hierarchy**: Clear visual hierarchy with size, weight, and color variations
- **Readability**: Minimum 14sp for body text, 44dp minimum touch targets
- **Contrast ratio**: WCAG AA minimum (4.5:1 for normal text, 3:1 for large text)
- **CRITICAL RULE**: Text color MUST NEVER match or blend with background color - always ensure sufficient contrast

Example:
```dart
import 'package:google_fonts/google_fonts.dart';

TextStyle(
  fontFamily: GoogleFonts.playfairDisplay().fontFamily, // Distinctive serif
  fontSize: 28,
  fontWeight: FontWeight.w700,
  color: Colors.black87, // High contrast with white background
  height: 1.2,
)
```

### Color & Theme
- **Bauhaus palette**: Leverage primary colors (red, blue, yellow) with black, white, and grays
- **Theme consistency**: Define custom ThemeData extending Bauhaus design system
- **Dynamic theming**: Support light/dark modes if applicable
- **Color contrast**: Ensure all text has minimum 4.5:1 contrast ratio with backgrounds
- **Semantic colors**: Use theme colors for success, error, warning states
- **ACCESSIBILITY**: Always validate text/background color combinations for WCAG compliance

Example:
```dart
// Good: High contrast
Container(
  color: Color(0xFF1A1A1A), // Dark background
  child: Text(
    'Readable text',
    style: TextStyle(color: Color(0xFFFFFFFF)), // White text
  ),
)

// Bad: Low contrast (NEVER DO THIS)
Container(
  color: Color(0xFFE0E0E0), // Light gray background
  child: Text(
    'Hard to read',
    style: TextStyle(color: Color(0xFFD0D0D0)), // Similar gray text
  ),
)
```

### Motion & Animation
- **Smooth 60fps**: Optimize animations for performance
- **Material motion**: Use Curves (easeInOut, fastOutSlowIn) for natural feel
- **Hero animations**: For screen transitions with shared elements
- **Implicit animations**: AnimatedContainer, AnimatedOpacity for simple cases
- **Explicit animations**: AnimationController for complex orchestrations
- **Stagger effects**: Use Interval and animation delays for sequential reveals
- **Gesture-driven**: SwipeablePageRoute, DismissibleList, custom gesture recognizers
- **Purposeful**: Every animation should enhance UX, not just decoration

### Spatial Composition & Layout
- **Geometric precision**: Align with Bauhaus grid-based principles
- **Asymmetric balance**: Create visual interest while maintaining harmony
- **Whitespace**: Generous padding and spacing for breathing room
- **Card elevation**: Use shadows sparingly and purposefully
- **Overlapping layers**: Stack widgets for depth and visual richness
- **Edge-to-edge**: Consider full-bleed images and backgrounds for impact

### Visual Details & Polish
- **Custom painting**: Use CustomPainter for unique geometric shapes and patterns
- **Gradients**: LinearGradient, RadialGradient for depth and atmosphere
- **Blur effects**: BackdropFilter with ImageFilter.blur for glassmorphism
- **Shadows**: BoxShadow with appropriate blur, spread, and offset
- **Border radius**: Consistent corner radii throughout design system
- **Icons**: Custom SVG icons or curated icon sets (not default Material icons)
- **Images**: Cached network images, proper loading states, error handling
- **Haptics**: HapticFeedback for tactile responses to interactions

### Accessibility (Non-Negotiable)
- **Semantics**: Wrap all interactive widgets with Semantics
- **Screen reader support**: Meaningful labels for all UI elements
- **Touch targets**: Minimum 44x44dp for all tappable elements
- **Color independence**: Never rely solely on color to convey information
- **Text contrast**: ALWAYS ensure text is readable against backgrounds (4.5:1 minimum)
- **Dynamic type**: Support user font size preferences with MediaQuery.textScaleFactor
- **Focus indicators**: Clear visual feedback for keyboard/switch navigation

## Code Quality Standards

### Performance
- **Const constructors**: Use `const` wherever possible to reduce rebuilds
- **Keys**: Proper key usage for list items and stateful widgets
- **Avoid rebuilds**: Memoization, selective watching in Riverpod (select, watch)
- **Image optimization**: Cached images, appropriate resolutions, lazy loading
- **List performance**: ListView.builder for long lists, never ListView with large data

### State Management
- **Riverpod best practices**: 
  - Use `ref.watch` for reactive dependencies
  - Use `ref.read` for one-time reads in callbacks
  - Use `ref.listen` for side effects
  - Family providers for parameterized state
  - KeepAlive for preserving state
- **Loading states**: Handle AsyncValue (loading, data, error) properly
- **Error boundaries**: Graceful error handling with user-friendly messages

### Code Organization
- **Feature-first structure**: Group by feature, not by layer
- **Barrel exports**: Clean imports with index.dart files
- **Constants**: Extract magic numbers, strings, and reusable values
- **Extensions**: Create extension methods for common operations
- **Documentation**: KDoc comments for public APIs

## Anti-Patterns to Avoid

**NEVER create generic Flutter "AI slop":**
- ❌ Default Material Design with no customization
- ❌ Purple/blue gradients on every screen
- ❌ Roboto font without consideration
- ❌ Predictable layouts (centered card with list)
- ❌ Generic AppBar/BottomNavigationBar without styling
- ❌ Hardcoded strings instead of localization
- ❌ Fixed sizes instead of responsive measurements
- ❌ Poor text contrast (light text on light backgrounds, dark on dark)
- ❌ Direct state manipulation in widgets
- ❌ Ignoring null safety
- ❌ Missing loading/error states

**ALWAYS prioritize:**
- ✅ Context-specific design that fits the app's purpose
- ✅ Bauhaus design system integration
- ✅ Full localization with AppLocalizations
- ✅ Responsive sizing with MediaQuery and LayoutBuilder
- ✅ WCAG-compliant color contrast (especially text on backgrounds)
- ✅ Clean Riverpod MVVM architecture
- ✅ Smooth animations and delightful interactions
- ✅ Accessibility and inclusive design
- ✅ Production-ready error handling

## Example: Complete Screen Implementation

```dart
// models/dashboard_model.dart
@freezed
class DashboardModel with _$DashboardModel {
  factory DashboardModel({
    required String userId,
    required int totalTasks,
    required int completedTasks,
  }) = _DashboardModel;
}

// viewmodels/dashboard_viewmodel.dart
class DashboardViewModel extends StateNotifier<AsyncValue<DashboardModel>> {
  DashboardViewModel() : super(const AsyncValue.loading()) {
    loadDashboard();
  }
  
  Future<void> loadDashboard() async {
    state = const AsyncValue.loading();
    try {
      // Fetch data
      final data = await _fetchData();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
  
  Future<DashboardModel> _fetchData() async {
    // API call or database query
    await Future.delayed(Duration(seconds: 1));
    return DashboardModel(
      userId: '123',
      totalTasks: 42,
      completedTasks: 28,
    );
  }
}

final dashboardViewModelProvider = 
    StateNotifierProvider<DashboardViewModel, AsyncValue<DashboardModel>>((ref) {
  return DashboardViewModel();
});

// views/dashboard_screen.dart
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardViewModelProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Color(0xFFFAF9F6), // Warm off-white
      body: SafeArea(
        child: dashboardState.when(
          data: (dashboard) => _buildContent(context, dashboard, screenWidth, spacing),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: Color(0xFFE63946), // Bauhaus red
            ),
          ),
          error: (error, _) => Center(
            child: Text(
              AppLocalizations.of(context)!.errorLoadingDashboard,
              style: GoogleFonts.archivo(
                fontSize: 16,
                color: Color(0xFF2A2A2A), // Dark gray, high contrast
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DashboardModel dashboard, 
                      double screenWidth, double spacing) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(spacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.dashboardTitle,
                  style: GoogleFonts.bebasNeue(
                    fontSize: screenWidth * 0.12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1D3557), // Navy blue, contrasts with background
                    height: 0.9,
                  ),
                ),
                SizedBox(height: spacing * 0.5),
                _buildStatsCard(context, dashboard, screenWidth, spacing),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard(BuildContext context, DashboardModel dashboard,
                        double screenWidth, double spacing) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spacing),
      decoration: BoxDecoration(
        color: Color(0xFFE63946), // Bold Bauhaus red background
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${dashboard.completedTasks}/${dashboard.totalTasks}',
            style: GoogleFonts.robotoMono(
              fontSize: screenWidth * 0.15,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFAF9F6), // Off-white text for contrast on red
              height: 0.9,
            ),
          ),
          SizedBox(height: spacing * 0.3),
          Text(
            AppLocalizations.of(context)!.tasksCompleted,
            style: GoogleFonts.archivo(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFAF9F6).withOpacity(0.9), // Slightly transparent white
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
```

## Final Reminders

- **Architecture first**: Always implement Riverpod MVVM pattern
- **Design system adherence**: Use Bauhaus principles and components
- **Localization always**: Never hardcode user-facing strings
- **Responsive by default**: Every dimension should adapt to screen size
- **Contrast is critical**: Text must always be readable against its background
- **Production quality**: Error handling, loading states, accessibility, performance
- **Creative boldness**: Make distinctive choices that serve the user and context

Remember: Flutter enables extraordinary mobile experiences. Combine technical excellence (clean architecture, responsive design, accessibility) with creative vision (distinctive aesthetics, delightful interactions) to build apps that users love and remember.
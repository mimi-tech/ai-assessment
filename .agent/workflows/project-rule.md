---
description: 
---

---
alwaysApply: true
---

This is a Flutter application using Clean Architecture with BLoC pattern for state management. The project consists of two main packages:
- `app/`: Main application package
- `app_ui/`: Shared UI component library

## Architecture & Structure

### Clean Architecture Layers
The project follows Clean Architecture with the following structure in `app/lib/src/`:

1. **Core** (`core/`): Shared utilities, configurations, and infrastructure
   - `configs/`: App configuration, routes, dependency injection
   - `const/`: Constants, assets paths, formatters
   - `enum/`: Shared enums (e.g., `UiState`)
   - `exceptions/`: Error handling and logging
   - `extensions/`: Extension methods
   - `network_setup/`: Dio configuration and interceptors
   - `utils/`: Utility functions

2. **Domain** (`domain/`): Business logic and entities
   - Organized by feature modules (e.g., `mcs/`, `mdt/`, `mmy/`)
   - - Contains data models and domain entities and should extend to Equatable
   - No dependencies on external packages (pure Dart)

3. **Presentation** (`presentation/`): UI layer with BLoC pattern
   - Organized by feature modules with subdirectories:
     - `bloc/`: BLoC, events, and states (using `part` files)
     - `view/`: Page widgets
     - `widget/`: Feature-specific widgets
     - `data/`: Presentation-level data models (if needed)
   - Common features in `presentation/common/`

4. **Repositories** (`repositories/`): Data layer abstraction
   - Abstract classes define contracts
   - Implementation classes (prefixed with `I`) handle data operations
   - Organized by feature modules

5. **Services** (`services/`): External service integrations
   - Abstract classes define contracts
   - Implementation classes (prefixed with `I`) handle service calls
   - Organized by feature modules

### Feature Module Naming
Features are organized with 3-letter prefixes:
- `mcs/`: Customer Service related features
- `mdt/`: Room/Product Detail features
- `mmy/`: My Page/User features
- `msc/`: Search features
- `mmn/`: Dashboard/Main features

## Code Style & Conventions

### Naming Conventions
- **Classes**: PascalCase (e.g., `MyInformationBloc`, `BrowserErrorPage`)
- **Files**: snake_case (e.g., `my_information_bloc.dart`, `browser_error_page.dart`)
- **Variables/Methods**: camelCase (e.g., `memberRepository`, `onLoadMyInformation`)
- **Constants**: camelCase for instance constants, UPPER_SNAKE_CASE for static constants
- **Enums**: PascalCase (e.g., `BrowserErrorType`, `UiState`)
- **Route names**: camelCase (e.g., `splashRoute`, `browserError`)
- **Route params classes**: PascalCase with `Params` suffix (e.g., `BrowserErrorPageParams`)

### BLoC Pattern
- BLoC files use `part` directives for events and states:
  ```dart
  part 'my_information_event.dart';
  part 'my_information_state.dart';
  ```
- Event handlers are private methods prefixed with `_on` (e.g., `_onLoadMyInformation`)
- Use `UiState` enum for loading states: `loading`, `loaded`, `error`
- State classes should extend `Equatable` for value comparison
- Use `copyWith` pattern for immutable state updates

### Widget Organization
- **Pages**: Full-screen widgets, placed in `view/` directory
- **Widgets**: Reusable components, placed in `widget/` or `widgets/` directory
- Use `StatelessWidget` when possible, `StatefulWidget` only when needed
- Extract complex UI logic into separate private methods (e.g., `_buildErrorContent`)
- Use `const` constructors whenever possible

### Routing
- Routes defined in `route_config.dart` using `go_router`
- Route names in `route_name.dart` as static const strings in `Routes` class
- Route parameters in `route_params.dart` as separate classes
- Use `NoTransitionPage` for route pages
- Always validate route parameters in `redirect` callback
- Route paths use camelCase (e.g., `/browserError`)

### Localization
- Use `context.l10n` for accessing localizations
- Localization keys follow camelCase (e.g., `browserErrorAssetConnectionDenied`)
- ARB files in `app/lib/l10n/arb/`
- Always use localization strings, never hardcode text

### UI Components
- **Always use components from `app_ui` package** for UI elements
- Import via: `import 'package:app_ui/app_theme.dart';`
- Use semantic colors: `AppSemanticColors.bgPrimary`, `AppSemanticColors.fontIconPrimary`
- Use text styles: `AppTextStyle.p4`, `AppTextStyle.p5` with extensions (e.g., `.fontIconPrimary`)
- Use padding constants: `AppPadding.xxl`, `AppPadding.m`
- Use buttons: `AppButton` with `ButtonColor` and `ButtonStyleVariant`
- Use app bars: `CustomAppBar.sub()` or `CustomAppBar.main()`

### Error Handling
- Use `ExceptionHandler.handleServiceException()` in repositories
- Create custom exception classes extending `BaseException` when needed
- Use `UiState.error` in BLoC states for error handling
- Error pages should be in `presentation/error/view/` or `presentation/common/`

### Dependency Injection
- Use `get_it` for dependency injection
- Configuration in `core/configs/locator.dart`
- Register dependencies in the locator setup

### Network Layer
- Use Dio for HTTP requests
- Configuration in `core/network_setup/dio/`
- Interceptors for request/response/error handling
- Use repositories to abstract network calls from BLoC

## File Organization Rules

### Feature Structure
When creating a new feature, follow this structure:
```
presentation/
  feature_name/
    bloc/
      feature_name_bloc.dart
      feature_name_event.dart
      feature_name_state.dart
    view/
      feature_name_page.dart
    widget/
      feature_specific_widget.dart
```

### Import Organization
1. Dart SDK imports
2. Flutter imports
3. Package imports (external packages)
4. Local imports (app package)
5. Relative imports (only when necessary)

Example:
```dart
import 'dart:async';

import 'package:app/src/core/enum/ui_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
```

### Page Widget Structure
```dart
class FeaturePage extends StatelessWidget {
  const FeaturePage({required this.param, super.key});

  final String param;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      // ... UI
    );
  }

  Widget _buildPrivateMethod(BuildContext context, AppLocalizations l10n) {
    // ... implementation
  }
}
```

## Firebase Analytics Requirement
- For every button, clickable widget, CTA, or user-triggered action:
  - ALWAYS add an analytics log event.
  - The analytics event must be triggered inside the onTap/onPressed callback and should be the last function to call.

  - Use this format:

      getIt<AnalyticBloc>().add(
        AnalyticsLogButtonTap(
          buttonName: AnalyticsConst.<button_name>,
        ),
      );

## Naming Rules for AnalyticsConst
- All AnalyticsConst keys MUST use snake_case or lowerCamelCase.
- All AnalyticsConst names MUST NOT exceed 21 characters.
- If a name would exceed 21 characters, shorten it while keeping meaning.
- Avoid generic names like "button_tap" or "click".
- Make names context-specific (example: login_button, submitFormBtn).

## Event Selection Logic
- Cursor must choose the correct AnalyticsConst value based on the context.
  - If inside a LoginPage → use login-related analytics.
  - If inside a SignupPage → use signup-related analytics.
  - If inside onboarding → use onboarding-related analytics.
  - If inside payment flow → use payment-related analytics.
  - If on a generic UI button → derive name from the button label.

## Deriving AnalyticsConst Automatically
- When generating a button:
  - Derive the analytics key from the button text or purpose.
  - Example:
      "Login" → AnalyticsConst.login
      "Register Now" → AnalyticsConst.registerNow
      "Confirm Payment" → AnalyticsConst.confirmPayment
- Keys must stay under 21 characters.
- Cursor must automatically shorten long names (e.g. "completeTheReservationProcess" → "reservProcess").

## Enforcement Rules
- Never generate button code without analytics tracking.
- If analytics is missing → Cursor must add it automatically.
- If an existing button doesn’t have analytics → Cursor must update the code to include it.
- Always import required analytics classes if missing.
- If AnalyticBloc or AnalyticsLogButtonTap is not available, remind the developer to define them.


## Testing
- Use `bloc_test` for BLoC testing
- Use `mocktail` for mocking
- Test files should be co-located with source files or in `test/` directory
- Follow naming: `feature_name_test.dart`

## Environment Configuration
- Environment configs in `app/config/` (development.json, staging.json, production.json)
- Use `EnvironmentConfig` for accessing environment-specific values
- Main entry points: `main_development.dart`, `main_staging.dart`, `main_production.dart`

## Assets
- Images: `app/assets/images/`
- Animations: `app/assets/animations/`
- Icons: `app_ui/lib/assets/icons/` (SVG format)
- Fonts: `app_ui/lib/assets/fonts/`
- Always reference assets through constants in `core/const/assets/`

## Code Quality
- Follow `very_good_analysis` rules (configured in `analysis_options.yaml`)
- Lines longer than 80 chars are allowed (configured to ignore)
- Public member API docs are optional
- Use `const` constructors and widgets whenever possible
- Prefer composition over inheritance
- Keep methods focused and single-purpose

## Best Practices
1. **Always use `app_ui` components** - Never create custom buttons, text styles, or colors
2. **Use BLoC for state management** - Avoid `setState` in complex widgets
3. **Keep pages simple** - Extract complex UI into separate widgets
4. **Use localization** - Never hardcode user-facing strings
5. **Validate route parameters** - Always check parameter types in route redirects
6. **Handle errors gracefully** - Use error states and error pages
7. **Use const constructors** - Improve performance and readability
8. **Follow feature module organization** - Keep related code together
9. **Abstract dependencies** - Use interfaces/abstract classes for repositories and services
10. **Use Equatable** - For value objects and state classes

## Common Patterns

### Creating a New Page with BLoC
1. Create feature directory in `presentation/`
2. Create `bloc/` with bloc, event, and state files
3. Create `view/` with page widget
4. Add route in `route_config.dart`
5. Add route name in `route_name.dart`
6. Add route params class in `route_params.dart` if needed
7. Register BLoC in dependency injection if needed

### Using UI Components
```dart
// AppButton
AppButton(
  label: l10n.buttonLabel,
  onPressed: () {},
  color: ButtonColor.secondary,
  style: ButtonStyleVariant.outline,
  radiusFull: false,
)

// Text with styling
Text(
  l10n.textLabel,
  style: AppTextStyle.p4.fontIconPrimary,
  textAlign: TextAlign.center,
)

// Custom AppBar
CustomAppBar.sub(showBackButton: false, centerTitle: true)
```

### BLoC State Pattern
```dart
class FeatureState extends Equatable {
  const FeatureState({
    this.uiState = UiState.initial,
    this.data,
  });

  final UiState uiState;
  final DataType? data;

  FeatureState copyWith({
    UiState? uiState,
    DataType? data,
  }) {
    return FeatureState(
      uiState: uiState ?? this.uiState,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [uiState, data];
}
```

## Notes
- The project uses Korean locale as default (`Locale('ko', 'KR')`)
- Firebase is integrated for analytics, auth, crashlytics, messaging, and remote config
- The app uses Material 3 design system
- Text scaling is disabled (`TextScaler.noScaling`)
- Loader overlay is used for loading states globally

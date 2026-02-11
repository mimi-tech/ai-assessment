# Project context for Gemini PR review (L2U Flutter app)

Use this context when reviewing pull requests for this repository. The action is configured with `REVIEW_MODE: strict`; this file documents project-specific expectations so reviewers (human or AI) can align feedback with our standards.

## Tech stack

- **Flutter / Dart** – mobile app
- **Clean Architecture** – core, domain, presentation, repositories, services
- **BLoC** (flutter_bloc) – state management; events/states use `part` files
- **go_router** – routing
- **Dio** – HTTP with interceptors
- **get_it** – DI
- **Equatable** – value equality for states/entities
- **app_ui** – shared UI package (required for all UI)

## Critical checks

- **BLoC**: State classes extend `Equatable`; use `copyWith`; event handlers named `_on*`.
- **UI**: Use only `app_ui` components (`AppButton`, `AppTextStyle`, `AppSemanticColors`, `AppPadding`, etc.); no custom buttons/colors.
- **Localization**: Use `context.l10n`; no hardcoded user-facing strings.
- **Null safety**: No unchecked nulls; handle API nulls explicitly.

## Conventions

- **Naming**: Classes PascalCase, files snake_case, variables/methods camelCase, routes camelCase, route params `*Params`.
- **Features**: 3-letter prefixes (`mcs/`, `mdt/`, `mmy/`, `msc/`, `mmn/`, `mrp/`).
- **Domain**: Pure Dart, no external packages; entities extend Equatable.
- **Repositories/Services**: Abstract contracts; implementations prefixed with `I`.

## Do not flag

- Line length (ignored in analysis_options).
- Missing public API docs (optional).
- Auto-generated files (`*.g.dart`, `*.freezed.dart`), ARB files, `firebase_options_*.dart`.

---

*This file is for documentation and for any future support for custom review instructions in the Gemini action.*

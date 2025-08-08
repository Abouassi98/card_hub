# Changelog

All notable changes to the Card Hub package will be documented in this file.

## Unreleased

### Added
-

### Changed
-

### Fixed
-
## 0.4.0 - 2025-08-09

### Changed
- Bumped package version to 0.4.0 in `pubspec.yaml`.
- README install snippet updated to `card_hub: ^0.4.0`.
- Minor documentation cleanups in `lib/card_hub.dart` public exports and header.

### Added
- None.

### Fixed
- None.

## 0.3.0 - 2025-08-09

### Added
- `LocalExceptionType` enum to standardize local error handling (`lib/src/utils/error/local_exception_type.dart`).
- Generated `AssetPaths` utility for image asset constants (`lib/src/utils/asset_paths.dart`).
- Registered card assets and custom font in `pubspec.yaml` under `flutter/assets` and `flutter/fonts`.

### Changed
- Clarified public library exports and inline docs in `lib/card_hub.dart`.
- Consolidated dependency declarations in `pubspec.yaml`.

## 0.2.0 - 2025-08-08

### Added
- Premium branding with Material 3 theming via `CardHubThemeProvider`
- Dynamic `ColorScheme` extraction from card logos using `MaterialColorExtractor`
- In-memory caching for extracted color schemes and palettes
- Performance guidance at `lib/src/docs/performance_best_practices.md`

### Changed
- README updated with premium branding usage example and notes
- Clarified persistence via `SharedPreferencesFacade` and `CardHubService`

### Fixed
- README example corrected to use `CardHubModel.onCardTap` instead of a non-existent `onCardSelected`

## 0.1.0 - 2025-08-01

### Added
- Initial release of the Card Hub package
- Animated card stack display with smooth transitions
- Default card selection with persistence using SharedPreferences
- Dynamic card styling with custom colors and gradients
- Automatic color extraction from card logos
- Support for various card types (Visa, Mastercard, etc.)
- Custom badges for default/non-default cards
- Customizable text styles and layouts
- Card removal functionality


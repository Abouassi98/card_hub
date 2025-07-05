part of 'styles.dart';

/// Provides static constants and helpers for sizing, padding, and spacing throughout the Card Hub UI.
/// Part of the global styles utility layer.
abstract class Sizes {
  /// The height of the device's status bar in logical pixels.
  static final double statusBarHeight = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.single,
  ).padding.top;

  /// The height of the device's home indicator area in logical pixels (iOS-specific).
  static final double homeIndicatorHeight = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.single,
  ).viewPadding.bottom;

  /// The height of the device window in logical pixels.
  static final double windowHeight = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.single,
  ).size.height;

  /// Returns the top padding for the given context, typically used for safe area calculations.
  static double topPadding(BuildContext context) => MediaQuery.paddingOf(context).top;

  /// Font Sizes
  /// You can use these directly if you need, but usually there should be a predefined style in TextStyles
  ///
  /// These font sizes are used throughout the app for various text elements.
  /// Font size 28, typically used for large headings.
  static const double font28 = 28;

  /// Font size 24, typically used for section titles.
  static const double font24 = 24;

  /// Font size 20, suitable for prominent text.
  static const double font20 = 20;

  /// Font size 18, used for subtitles or emphasized text.
  static const double font18 = 18;

  /// Font size 16, standard for body text.
  static const double font16 = 16;

  /// Font size 14, used for secondary text.
  static const double font14 = 14;

  /// Font size 12, used for captions or hints.
  static const double font12 = 12;

  /// Font size 10, used for footnotes or meta information.
  static const double font10 = 10;

  /// Icon Sizes
  ///
  /// These icon sizes are used throughout the app for various icon elements.
  /// Icon size 44, used for large icons.
  static const double icon44 = 44;

  /// Icon size 24, standard for toolbar icons.
  static const double icon24 = 24;

  /// Icon size 20, used for medium icons.
  static const double icon20 = 20;

  /// Icon size 16, used for small icons.
  static const double icon16 = 16;

  /// Icon size 8, used for tiny decorative icons.
  static const double icon8 = 8;

  /// Screen Padding
  ///
  /// These padding values are used to add space between the screen edges and content.
  /// Vertical screen padding of 72 logical pixels.
  static const double screenPaddingV72 = 72;

  /// Vertical screen padding of 64 logical pixels.
  static const double screenPaddingV64 = 64;

  /// Vertical screen padding of 36 logical pixels.
  static const double screenPaddingV36 = 36;

  /// Vertical screen padding of 20 logical pixels.
  static const double screenPaddingV20 = 20;

  /// Vertical screen padding of 16 logical pixels.
  static const double screenPaddingV16 = 16;

  /// Horizontal screen padding of 12 logical pixels.
  static const double screenPaddingH12 = 12;

  /// Horizontal screen padding of 16 logical pixels.
  static const double screenPaddingH16 = 16;

  /// Horizontal screen padding of 32 logical pixels.
  static const double screenPaddingH32 = 32;

  /// Horizontal screen padding of 36 logical pixels.
  static const double screenPaddingH36 = 36;

  /// Horizontal screen padding of 28 logical pixels.
  static const double screenPaddingH28 = 28;

  /// Horizontal screen padding of 42 logical pixels.
  static const double screenPaddingH42 = 42;

  /// Horizontal screen padding of 40 logical pixels.
  static const double screenPaddingH40 = 40;

  /// Widget Margin
  ///
  /// These margin values are used to add space between widgets.
  /// Vertical margin of 250 logical pixels, used for large vertical spacing.
  static const double marginV250 = 250;

  /// Vertical margin of 110 logical pixels.
  static const double marginV110 = 110;

  /// Vertical margin of 40 logical pixels.
  static const double marginV40 = 40;

  /// Horizontal margin of 36 logical pixels.
  static const double marginH36 = 36;

  /// Vertical margin of 36 logical pixels.
  static const double marginV36 = 36;

  /// Vertical margin of 32 logical pixels.
  static const double marginV32 = 32;

  /// Vertical margin of 28 logical pixels.
  static const double marginV28 = 28;

  /// Vertical margin of 24 logical pixels.
  static const double marginV24 = 24;

  /// Vertical margin of 20 logical pixels.
  static const double marginV20 = 20;

  /// Vertical margin of 16 logical pixels.
  static const double marginV16 = 16;

  /// Vertical margin of 12 logical pixels.
  static const double marginV12 = 12;

  /// Vertical margin of 10 logical pixels.
  static const double marginV10 = 10;

  /// Vertical margin of 8 logical pixels.
  static const double marginV8 = 8;

  /// Vertical margin of 6 logical pixels.
  static const double marginV6 = 6;

  /// Vertical margin of 2 logical pixels.
  static const double marginV2 = 2;

  /// Vertical margin of 4 logical pixels.
  static const double marginV4 = 4;

  /// Horizontal margin of 173 logical pixels.
  static const double marginH173 = 173;

  /// Horizontal margin of 135 logical pixels.
  static const double marginH135 = 135;

  /// Horizontal margin of 70 logical pixels.
  static const double marginH70 = 70;

  /// Horizontal margin of 32 logical pixels.
  static const double marginH32 = 32;

  /// Horizontal margin of 30 logical pixels.
  static const double marginH30 = 30;

  /// Horizontal margin of 28 logical pixels.
  static const double marginH28 = 28;

  /// Horizontal margin of 24 logical pixels.
  static const double marginH24 = 24;

  /// Horizontal margin of 20 logical pixels.
  static const double marginH20 = 20;

  /// Horizontal margin of 16 logical pixels.
  static const double marginH16 = 16;

  /// Horizontal margin of 12 logical pixels.
  static const double marginH12 = 12;

  /// Horizontal margin of 10 logical pixels.
  static const double marginH10 = 10;

  /// Horizontal margin of 8 logical pixels.
  static const double marginH8 = 8;

  /// Horizontal margin of 6 logical pixels.
  static const double marginH6 = 6;

  /// Horizontal margin of 4 logical pixels.
  static const double marginH4 = 4;

  /// Widget Padding
  ///
  /// These padding values are used to add space between the widget edges and content.
  /// Vertical padding of 130 logical pixels.
  static const double paddingV130 = 130;

  /// Horizontal padding of 115 logical pixels.
  static const double paddingH115 = 115;

  /// Vertical padding of 96 logical pixels.
  static const double paddingV96 = 96;

  /// Horizontal padding of 70 logical pixels.
  static const double paddingH70 = 70;

  /// Vertical padding of 40 logical pixels.
  static const double paddingV40 = 40;

  /// Vertical padding of 32 logical pixels.
  static const double paddingV32 = 32;

  /// Vertical padding of 30 logical pixels.
  static const double paddingV30 = 30;

  /// Vertical padding of 28 logical pixels.
  static const double paddingV28 = 28;

  /// Vertical padding of 24 logical pixels.
  static const double paddingV24 = 24;

  /// Vertical padding of 20 logical pixels.
  static const double paddingV20 = 20;

  /// Vertical padding of 16 logical pixels.
  static const double paddingV16 = 16;

  /// Vertical padding of 14 logical pixels.
  static const double paddingV14 = 14;

  /// Vertical padding of 12 logical pixels.
  static const double paddingV12 = 12;

  /// Vertical padding of 10 logical pixels.
  static const double paddingV10 = 10;

  /// Vertical padding of 8 logical pixels.
  static const double paddingV8 = 8;

  /// Vertical padding of 6 logical pixels.
  static const double paddingV6 = 6;

  /// Vertical padding of 4 logical pixels.
  static const double paddingV4 = 4;

  /// Vertical padding of 3 logical pixels.
  static const double paddingV3 = 3;

  /// Horizontal padding of 32 logical pixels.
  static const double paddingH32 = 32;

  /// Horizontal padding of 31 logical pixels.
  static const double paddingH31 = 31;

  /// Horizontal padding of 28 logical pixels.
  static const double paddingH28 = 28;

  /// Horizontal padding of 24 logical pixels.
  static const double paddingH24 = 24;

  /// Horizontal padding of 22 logical pixels.
  static const double paddingH22 = 22;

  /// Horizontal padding of 20 logical pixels.
  static const double paddingH20 = 20;

  /// Horizontal padding of 16 logical pixels.
  static const double paddingH16 = 16;

  /// Horizontal padding of 14 logical pixels.
  static const double paddingH14 = 14;

  /// Horizontal padding of 12 logical pixels.
  static const double paddingH12 = 12;

  /// Horizontal padding of 8 logical pixels.
  static const double paddingH8 = 8;

  /// Horizontal padding of 6 logical pixels.
  static const double paddingH6 = 6;

  /// Horizontal padding of 4 logical pixels.
  static const double paddingH4 = 4;

  /// Widget Constraints
  ///
  /// These constraint values are used to limit the size of widgets.
  /// Maximum width constraint of 360 logical pixels for widgets.
  static const double maxWidth360 = 360;

  /// Maximum height constraint of 800 logical pixels for widgets.
  static const double maxHeight800 = 800;

  /// Maximum height constraint of 60 logical pixels for buttons.
  static const double maxHeightButton60 = 60;

  /// Button
  ///
  /// These values are used to style buttons throughout the app.
  /// Vertical padding of 14 logical pixels for buttons.
  static const double buttonPaddingV14 = 14;

  /// Vertical padding of 12 logical pixels for buttons.
  static const double buttonPaddingV12 = 12;

  /// Horizontal padding of 80 logical pixels for buttons.
  static const double buttonPaddingH80 = 80;

  /// Horizontal padding of 24 logical pixels for buttons.
  static const double buttonPaddingH24 = 24;

  /// Horizontal padding of 34 logical pixels for buttons.
  static const double buttonPaddingH34 = 34;

  /// Border radius of 24 logical pixels for buttons.
  static const double buttonR24 = 24;

  /// Border radius of 32 logical pixels for buttons.
  static const double buttonR32 = 32;

  /// Border radius of 27 logical pixels for buttons.
  static const double buttonR27 = 27;

  /// Border radius of 40 logical pixels for buttons.
  static const double buttonR40 = 40;

  /// Border radius of 12 logical pixels for images.
  static const double imageR12 = 12;

  /// Border radius of 4 logical pixels for buttons.
  static const double buttonR4 = 4;

  /// Card
  ///
  /// These values are used to style cards throughout the app.
  /// Border radius of 4 logical pixels for cards.
  static const double cardR4 = 4;

  /// Border radius of 8 logical pixels for cards.
  static const double cardR8 = 8;

  /// Border radius of 12 logical pixels for cards.
  static const double cardR12 = 12;

  /// Border radius of 16 logical pixels for cards.
  static const double cardR16 = 16;

  /// Border radius of 19 logical pixels for cards.
  static const double cardR19 = 19;

  /// Border radius of 20 logical pixels for cards.
  static const double cardR20 = 20;

  /// Border radius of 24 logical pixels for cards.
  static const double cardR24 = 24;

  /// Border radius of 28 logical pixels for cards.
  static const double cardR28 = 28;

  /// Border radius of 32 logical pixels for cards.
  static const double cardR32 = 32;

  /// Border radius of 36 logical pixels for cards.
  static const double cardR36 = 36;

  /// Border radius of 27 logical pixels for cards.
  static const double cardR27 = 27;

  /// Vertical padding of 16 logical pixels for cards.
  static const double cardPaddingV16 = 16;

  /// Horizontal padding of 20 logical pixels for cards.
  static const double cardPaddingH20 = 20;

  /// Horizontal padding of 32 logical pixels for cards.
  static const double cardPaddingH32 = 32;

  /// Dialog
  ///
  /// These values are used to style dialogs throughout the app.
  /// Dialog width of 280 logical pixels.
  static const double dialogWidth280 = 280;

  /// Border radius of 20 logical pixels for dialogs.
  static const double dialogR20 = 20;

  /// Border radius of 48 logical pixels for dialogs.
  static const double dialogR48 = 48;

  /// Border radius of 4 logical pixels for dialogs.
  static const double dialogR6 = 4;

  /// Vertical padding of 28 logical pixels for dialogs.
  static const double dialogPaddingV28 = 28;

  /// Vertical padding of 20 logical pixels for dialogs.
  static const double dialogPaddingV20 = 20;

  /// Horizontal padding of 20 logical pixels for dialogs.
  static const double dialogPaddingH20 = 20;

  /// Image
  ///
  /// These values are used to style images throughout the app.
  /// Border radius of 23 logical pixels for images.
  static const double imageR23 = 23;

  /// Border radius of 24 logical pixels for images.
  static const double imageR24 = 24;

  /// Border radius of 27 logical pixels for images.
  static const double imageR27 = 27;

  /// Border radius of 28 logical pixels for images.
  static const double imageR28 = 28;

  /// Border radius of 20 logical pixels for images.
  static const double imageR20 = 20;

  /// Border radius of 35 logical pixels for images.
  static const double imageR35 = 35;

  /// Border radius of 57 logical pixels for images.
  static const double imageR57 = 57;

  /// Border radius of 70 logical pixels for images.
  static const double imageR70 = 70;

  /// Border radius of 60 logical pixels for images.
  static const double imageR60 = 60;

  /// HomeShell
  ///
  /// These values are used to style the HomeShell throughout the app.
  /// Height of the sliver app bar in the HomeShell, set to 80 logical pixels.
  static const double sliverAppBarHeight80 = 80;

  /// Height of the app bar in the HomeShell, set to 70 logical pixels.
  static const double appBarHeight70 = 70;

  /// Leading width of the app bar in the HomeShell, set to 68 logical pixels.
  static const double appBarLeadingWidth = 68;

  /// Elevation of the app bar in the HomeShell, set to 0 for a flat appearance.
  static const double appBarElevation = 0;

  /// Width of the navigation drawer in the HomeShell, set to 240 logical pixels.
  static const double drawerWidth240 = 240;

  /// Vertical padding of 88 logical pixels for the navigation drawer in the HomeShell.
  static const double drawerPaddingV88 = 88;

  /// Horizontal padding of 28 logical pixels for the navigation drawer in the HomeShell.
  static const double drawerPaddingH28 = 28;

  /// Height of the bottom navigation bar in the HomeShell, set to 60 logical pixels.
  static const double navBarHeight60 = 60;

  /// Border radius of 22 logical pixels for navigation bar icons in the HomeShell.
  static const double navBarIconR22 = 22;

  /// Elevation of the bottom navigation bar in the HomeShell, set to 4 for subtle shadow.
  static const double navBarElevation = 4;

  /// Home
  ///
  /// These values are used to style the Home screen throughout the app.
  /// Height of the album image on the Home screen, set to 56 logical pixels.
  static const double homeAlbumImageHight = 56;

  /// Width of the album image on the Home screen, set to 56 logical pixels.
  static const double homeAlbumImageWidth = 56;

  /// Border radius of the album image on the Home screen, set to 5 logical pixels.
  static const double homeAlbumImageRadius = 5;

  /// Map
  ///
  /// These values are used to style the Map screen throughout the app.
  /// Border radius of the map search bar, set to 8 logical pixels.
  static const double mapSearchBarRadius = 8;

  /// Top offset for the map directions info panel, set to 112 logical pixels.
  static const double mapDirectionsInfoTop = 112;

  /// Vertical margin of 64 logical pixels for map and other layouts.
  static const double marginV64 = 64;

  /// Horizontal margin of 64 logical pixels for map and other layouts.
  static const double marginH64 = 64;

  /// Border radius of 40 logical pixels for cards.
  static const double cardR40 = 40;
}

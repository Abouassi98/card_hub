part of 'styles.dart';

abstract class Sizes {
  static final double statusBarHeight = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.single,
  ).padding.top;

  static final double homeIndicatorHeight = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.single,
  ).viewPadding.bottom;

  static final double windowHeight = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.single,
  ).size.height;

  static double topPadding(BuildContext context) => MediaQuery.paddingOf(context).top;

  /// Font Sizes
  /// You can use these directly if you need, but usually there should be a predefined style in TextStyles
  static const double font28 = 28;
  static const double font24 = 24;
  static const double font20 = 20;
  static const double font18 = 18;
  static const double font16 = 16;
  static const double font14 = 14;
  static const double font12 = 12;
  static const double font10 = 10;

  // Icon Sizes
  static const double icon44 = 44;
  static const double icon24 = 24;
  static const double icon20 = 20;
  static const double icon16 = 16;
  static const double icon8 = 8;

  // Screen Padding
  static const double screenPaddingV72 = 72;
  static const double screenPaddingV64 = 64;
  static const double screenPaddingV36 = 36;
  static const double screenPaddingV20 = 20;
  static const double screenPaddingV16 = 16;
  static const double screenPaddingH12 = 12;
  static const double screenPaddingH16 = 16;
  static const double screenPaddingH32 = 32;
  static const double screenPaddingH36 = 36;
  static const double screenPaddingH28 = 28;
  static const double screenPaddingH42 = 42;
  static const double screenPaddingH40 = 40;

  // Widget Margin
  static const double marginV250 = 250;
  static const double marginV110 = 110;
  static const double marginV40 = 40;
  static const double marginH36 = 36;
  static const double marginV36 = 36;
  static const double marginV32 = 32;
  static const double marginV28 = 28;
  static const double marginV24 = 24;
  static const double marginV20 = 20;
  static const double marginV16 = 16;
  static const double marginV12 = 12;
  static const double marginV10 = 10;
  static const double marginV8 = 8;
  static const double marginV6 = 6;
  static const double marginV2 = 2;
  static const double marginV4 = 4;
  static const double marginH173 = 173;
  static const double marginH135 = 135;
  static const double marginH70 = 70;
  static const double marginH32 = 32;
  static const double marginH30 = 30;
  static const double marginH28 = 28;
  static const double marginH24 = 24;
  static const double marginH20 = 20;
  static const double marginH16 = 16;
  static const double marginH12 = 12;
  static const double marginH10 = 10;
  static const double marginH8 = 8;
  static const double marginH6 = 6;
  static const double marginH4 = 4;

  // Widget Padding
  static const double paddingV130 = 130;
  static const double paddingH115 = 115;
  static const double paddingV96 = 96;
  static const double paddingH70 = 70;
  static const double paddingV40 = 40;
  static const double paddingV32 = 32;
  static const double paddingV30 = 30;
  static const double paddingV28 = 28;
  static const double paddingV24 = 24;
  static const double paddingV20 = 20;
  static const double paddingV16 = 16;
  static const double paddingV14 = 14;
  static const double paddingV12 = 12;
  static const double paddingV10 = 10;
  static const double paddingV8 = 8;
  static const double paddingV6 = 6;
  static const double paddingV4 = 4;
  static const double paddingV3 = 3;
  static const double paddingH32 = 32;
  static const double paddingH31 = 31;
  static const double paddingH28 = 28;
  static const double paddingH24 = 24;
  static const double paddingH22 = 22;
  static const double paddingH20 = 20;
  static const double paddingH16 = 16;
  static const double paddingH14 = 14;
  static const double paddingH12 = 12;
  static const double paddingH8 = 8;
  static const double paddingH6 = 6;
  static const double paddingH4 = 4;

  // Widget Constraints
  static const double maxWidth360 = 360;
  static const double maxHeight800 = 800;
  static const double maxHeighButtont60 = 60;

  // Button
  static const double buttonPaddingV14 = 14;
  static const double buttonPaddingV12 = 12;
  static const double buttonPaddingH80 = 80;
  static const double buttonPaddingH24 = 24;
  static const double buttonPaddingH34 = 34;
  static const double buttonR24 = 24;
  static const double buttonR32 = 32;
  static const double buttonR27 = 27;
  static const double buttonR40 = 40;
  static const double imageR12 = 12;
  static const double buttonR4 = 4;

  // Card
  static const double cardR4 = 4;
  static const double cardR8 = 8;
  static const double cardR12 = 12;
  static const double cardR16 = 16;
  static const double cardR19 = 19;
  static const double cardR20 = 20;
  static const double cardR24 = 24;
  static const double cardR28 = 28;
  static const double cardR32 = 32;
  static const double cardR36 = 36;
  static const double cardR27 = 27;
  static const double cardPaddingV16 = 16;
  static const double cardPaddingH20 = 20;
  static const double cardPaddingH32 = 32;

  // Dialog
  static const double dialogWidth280 = 280;
  static const double dialogR20 = 20;
  static const double dialogR48 = 48;
  static const double dialogR6 = 4;
  static const double dialogPaddingV28 = 28;
  static const double dialogPaddingV20 = 20;
  static const double dialogPaddingH20 = 20;

  // Image
  static const double imageR23 = 23;
  static const double imageR24 = 24;
  static const double imageR27 = 27;
  static const double imageR28 = 28;
  static const double imageR20 = 20;
  static const double imageR35 = 35;
  static const double imageR57 = 57;
  static const double imageR70 = 70;
  static const double imageR60 = 60;

  // HomeShell
  static const double sliverAppBarHeight80 = 80;
  static const double appBarHeight70 = 70;
  static const double appBarLeadingWidth = 68;
  static const double appBarElevation = 0;
  static const double drawerWidth240 = 240;
  static const double drawerPaddingV88 = 88;
  static const double drawerPaddingH28 = 28;
  static const double navBarHeight60 = 60;
  static const double navBarIconR22 = 22;
  static const double navBarElevation = 4;
  //Home
  static const double homeAlbumImageHight = 56;
  static const double homeAlbumImageWidth = 56;
  static const double homeAlbumImageRadius = 5;
  // Map
  static const double mapSearchBarRadius = 8;
  static const double mapDirectionsInfoTop = 112;
  static const double marginV64 = 64;
  static const double marginH64 = 64;
  static const double cardR40 = 40;
}

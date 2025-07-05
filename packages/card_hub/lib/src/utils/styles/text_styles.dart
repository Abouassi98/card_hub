part of 'styles.dart';

/// A class containing static text styles for the application.
abstract class TextStyles {
  // This is necessary for smooth fontFamily changes when changing app language,
  // that's because the fontFamily change from the theme have a slight delay.
  static TextStyle _mainStyle(BuildContext context) =>
      const TextStyle(fontFamily: 'halter', package: AppConstants.packageName);

  /// Text style with font size 18.
  static TextStyle f18(BuildContext context) => _mainStyle(context).copyWith(
        color: Colors.white,
        fontSize: Sizes.font18,
      );

  /// Text style with font size 18 and semi-bold font weight.
  static TextStyle f18SemiBold(BuildContext context) =>
      f18(context).copyWith(fontWeight: FontStyles.fontWeightSemiBold);

  /// Text style with font size 14.
  static TextStyle f14(BuildContext context) => _mainStyle(context).copyWith(
        color: Colors.white,
        fontSize: Sizes.font14,
      );

  /// Text style with font size 10.
  static TextStyle f10(BuildContext context) => _mainStyle(context).copyWith(
      color: Colors.grey, fontSize: Sizes.font10, fontWeight: FontWeight.bold);

  static TextStyle defaultCreditCardStyle(BuildContext context) =>
      Theme.of(context)
          .textTheme
          .titleLarge!
          .merge(_mainStyle(context).copyWith(
            color: Colors.white,
            fontSize: Sizes.font14,
          ));
}

import 'package:flutter/material.dart';
import '../../card_hub_style_data.dart';
import '../../models/card_hub_model.dart';
import '../../utils/constants.dart';
import '../../utils/enumerations.dart';
import '../../utils/styles/styles.dart';
import '../widgets/card_hub_details_widget.dart';
import '../widgets/card_hub_logo_widget.dart';

/// A widget that displays a customizable credit card component.
///
/// This component can show card details like bank name, card number, cardholder
/// name, and expiration date. It supports custom styling, gradients, and a
/// branding color derived from a card's logo.
class CardHubComponent extends StatelessWidget {
  /// Creates a [CardHubComponent].
  const CardHubComponent({
    required this.card,
    required this.visaMasterCardType,
    required this.isSelected,
    required this.isDefault, // New: To show a "Default" badge
    this.defaultBadge,
    this.nonDefaultBadge,
    this.onRemoveCard,
    this.cardHubStyleData,
    this.brandingPalette,
    super.key,
  });
  // Cached color calculations to avoid recalculating on every build
  static final Map<List<Color>?, Color> _contentColorCache = {};
  static final Map<List<Color>?, Gradient?> _gradientCache = {};

  /// The data model representing the card to be displayed.
  final CardHubModel card;

  /// The type of the card (e.g., Visa, MasterCard), used to determine the
  /// default gradient if [brandingColor] is not provided.
  final CardType visaMasterCardType;

  /// Optional styling data to customize the appearance of the card.
  final CardHubStyleData? cardHubStyleData;

  /// An optional callback function that is triggered when the remove icon is tapped.
  ///
  /// The remove icon is only visible when [isSelected] is `true`.
  final void Function()? onRemoveCard;

  /// A boolean that indicates whether the card is currently selected.
  ///
  /// If `true`, a remove icon is displayed on the card.
  final bool isSelected;

  /// A boolean that indicates whether the card is the default card.
  ///
  /// If `true`, a "Default" badge is displayed on the card.
  final bool isDefault;

  /// A Material 3 ColorScheme generated from the card's logo.
  /// If provided, it overrides the default gradient.
  final List<Color>? brandingPalette;

  /// A widget that is displayed on the card when it is the default card.
  final Widget Function(CardHubModel)? defaultBadge;

  /// A widget that is displayed on the card when it is not the default card.
  final Widget Function(CardHubModel)? nonDefaultBadge;
  
  /// Returns the appropriate content color based on the branding palette
  /// Uses a static cache to avoid recalculating for the same palette
  Color _getContentColor() {
    // Default content color is white
    if (brandingPalette == null || brandingPalette!.isEmpty) {
      return Colors.white;
    }
    
    // Check if we have this color cached
    if (_contentColorCache.containsKey(brandingPalette)) {
      return _contentColorCache[brandingPalette]!;
    }
    
    // Calculate the content color based on brightness
    final brightness = ThemeData.estimateBrightnessForColor(brandingPalette![0]);
    final contentColor = brightness == Brightness.dark ? Colors.white : Colors.black87;
    
    // Cache the result
    _contentColorCache[brandingPalette] = contentColor;
    
    return contentColor;
  }
  
  /// Returns the appropriate background gradient based on the branding palette
  /// Uses a static cache to avoid recalculating for the same palette
  Gradient? _getBackgroundGradient() {
    // Check if we have this gradient cached
    if (_gradientCache.containsKey(brandingPalette)) {
      return _gradientCache[brandingPalette];
    }
    
    // Calculate the gradient
    Gradient? backgroundGradient;
    if (brandingPalette != null && brandingPalette!.length > 1) {
      backgroundGradient = LinearGradient(
        colors: brandingPalette!,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    
    // Cache the result
    _gradientCache[brandingPalette] = backgroundGradient;
    
    return backgroundGradient;
  }

  /// Builds the widget tree for this component.
  @override
  Widget build(BuildContext context) {
    // Memoize these calculations to avoid recalculating on every build
    // Determine the color of text and icons based on the background
    final Color contentColor = _getContentColor();
    final Gradient? backgroundGradient = _getBackgroundGradient();

    final TextStyle brandedTextStyle =
        TextStyles.defaultCreditCardStyle(context)
            .copyWith(color: contentColor);

    // Wrap with RepaintBoundary to optimize rendering performance
    return RepaintBoundary(
      child: Stack(
      children: [
        Container(
          decoration: card.logoAssetPath != null
              ? BoxDecoration(
                  // If a brandingScheme exists, use it. Otherwise, fall back to the gradient.
                  // Use solid color if only one color in palette, otherwise use the new gradient
                  color: (brandingPalette?.length == 1)
                      ? brandingPalette![0]
                      : null,
                  gradient: backgroundGradient ??
                      cardHubStyleData?.gradient ??
                      visaMasterCardType.gradient,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: AssetImage(card.logoAssetPath!),
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                    opacity: 0.2,
                  ))
              : BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: card.cardColor,
                ),
          width:
              cardHubStyleData?.width ?? MediaQuery.sizeOf(context).width * 0.8,
          margin: const EdgeInsets.symmetric(
            horizontal: Sizes.paddingH20,
          ).copyWith(top: Sizes.paddingV10),
          padding: cardHubStyleData?.padding ??
              const EdgeInsets.only(left: 16, right: 16, bottom: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CardHubLogo(
                image: cardHubStyleData?.logoImage ?? visaMasterCardType.image,
              ),
              const SizedBox(height: Sizes.marginV16),
              Text(card.bankName, style: brandedTextStyle),
              const SizedBox(height: Sizes.marginV16),
              Text(
                '${AppConstants.twelveX} ${card.lastFour}',
                textAlign: TextAlign.left,
                style: cardHubStyleData?.textStyle ?? brandedTextStyle,
              ),
              const SizedBox(height: Sizes.marginV10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CardHubDetails(
                    label: cardHubStyleData?.labelCardHolder ?? 'CARDHOLDER',
                    value: card.cardHolderName,
                    textStyle: cardHubStyleData?.textStyle,
                    overrideColor: contentColor, // Pass color down
                  ),
                  CardHubDetails(
                    label: cardHubStyleData?.labelValidThru ?? 'VALID THRU',
                    value: '${card.expirationMonth} / ${card.expirationYear}',
                    textStyle: cardHubStyleData?.textStyle,
                    overrideColor: contentColor, // Pass color down
                  ),
                ],
              ),
            ],
          ),
        ),
        // Show "Set as Default" button only when the card is selected
        // and it is NOT already the default card.
        if (isDefault && isSelected && defaultBadge != null) defaultBadge!(card),
        // Show "Default" chip if it's the default card
        if (!isDefault && !isSelected && nonDefaultBadge != null)
          nonDefaultBadge!(card),
      ],
    ),
    );
  }
}

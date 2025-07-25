import 'package:flutter/material.dart';
import '../../../card_hub.dart';
import '../../utils/constants.dart';
import '../../utils/styles/styles.dart';

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
    required this.onSetAsDefault, // New: Callback to set this card as default
    this.onRemoveCard,
    this.cardHubStyleData,
    this.brandingPalette,
    super.key,
  });

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

  /// A callback function that is triggered when the default icon is tapped.
  ///
  /// The default icon is only visible when [isDefault] is `true`.
  final void Function()? onSetAsDefault;

  /// A Material 3 ColorScheme generated from the card's logo.
  /// If provided, it overrides the default gradient.
  final List<Color>? brandingPalette; // 👈 Define property

  /// Builds the widget tree for this component.
  @override
  Widget build(BuildContext context) {
    // Determine the color of text and icons based on the background
    Color contentColor = Colors.white; // Default content color
    Gradient? backgroundGradient;
    // Determine background and content color from the palette
    if (brandingPalette != null && brandingPalette!.isNotEmpty) {
      // Use the first color in the palette to determine text/icon contrast
      final brightness = ThemeData.estimateBrightnessForColor(brandingPalette![0]);
      contentColor = brightness == Brightness.dark ? Colors.white : Colors.black87;

      if (brandingPalette!.length > 1) {
        // Create a gradient from the palette
        backgroundGradient = LinearGradient(
          colors: brandingPalette!,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      }
    }

    final TextStyle brandedTextStyle =
        TextStyles.defaultCreditCardStyle(context).copyWith(color: contentColor);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            // If a brandingScheme exists, use it. Otherwise, fall back to the gradient.
            // Use solid color if only one color in palette, otherwise use the new gradient
            color: (brandingPalette?.length == 1) ? brandingPalette![0] : null,
            gradient:
                backgroundGradient ?? cardHubStyleData?.gradient ?? visaMasterCardType.gradient,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
              image: AssetImage(card.logoAssetPath),
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
              opacity: 0.2,
            ),
          ),
          width: cardHubStyleData?.width ?? MediaQuery.sizeOf(context).width * 0.9,
          margin: const EdgeInsets.symmetric(
            horizontal: Sizes.paddingH20,
          ).copyWith(top: Sizes.paddingV10),
          padding:
              cardHubStyleData?.padding ?? const EdgeInsets.only(left: 16, right: 16, bottom: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CardHubLogo(
                image: cardHubStyleData?.logoImage ?? visaMasterCardType.image,
              ),
              const SizedBox(height: Sizes.marginV16),
              Text(card.bankName , style: brandedTextStyle),
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
        if (!isDefault && isSelected)
          Positioned(
            right: 10,
            child: InkWell(
              onTap: onSetAsDefault,
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                radius: Sizes.cardR16,
                child: Icon(Icons.done, color: Colors.white),
              ),
            ),
          ),
        // Show "Default" chip if it's the default card
        if (isDefault)
          const Positioned(
            right: 10,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: Sizes.cardR16,
              child: Icon(Icons.star, color: Colors.white),
            ),
          ),

    
      ],
    );
  }
}

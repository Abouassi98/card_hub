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
    this.onRemoveCard,
    this.cardHubStyleData,
     this.brandingColor, 
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
  
  /// A Material 3 ColorScheme generated from the card's logo.
  /// If provided, it overrides the default gradient.
  final Color? brandingColor; // 👈 Define property
    /// Builds the widget tree for this component.
  @override
  Widget build(BuildContext context) {   

  // Determine the color of text and icons based on the background
    Color contentColor = Colors.white; // Default for gradients
    if (brandingColor != null) {
      final brightness = ThemeData.estimateBrightnessForColor(brandingColor!);
      contentColor = brightness == Brightness.dark ? Colors.white : Colors.black87;
    }

    final TextStyle brandedTextStyle =
        TextStyles.defaultCreditCardStyle(context).copyWith(color: contentColor);

  
      return Stack(
      children: [
        Container(
           decoration: BoxDecoration(
            // If a brandingScheme exists, use it. Otherwise, fall back to the gradient.
                 color: brandingColor,
            gradient: brandingColor == null
                ? (cardHubStyleData?.gradient ?? visaMasterCardType.gradient)
                : null,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          width: cardHubStyleData?.width ?? MediaQuery.sizeOf(context).width * 0.9,
       margin: cardHubStyleData?.margin ??
              const EdgeInsets.symmetric(
                horizontal: Sizes.paddingH20,
              ).copyWith(top: Sizes.paddingV10),
          padding: cardHubStyleData?.padding ??
              const EdgeInsets.only(left: 16, right: 16, bottom: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Use the logo from the model if available
              CardHubLogo(
                image: card.logoAssetPath ,
              ),
       const SizedBox(height: Sizes.marginV16),
              Text(card.bankName ?? '', style: brandedTextStyle),
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
        if (isSelected)
          Positioned(
            right: 10,
            child: InkWell(
              onTap: onRemoveCard,
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                radius: Sizes.cardR16,
                child: Icon(Icons.remove, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}

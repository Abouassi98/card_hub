import 'package:flutter/material.dart';
import '../../../card_hub.dart';
import '../../utils/constants.dart';
import '../../utils/styles/styles.dart';

/// A widget representing a credit card component.
class CardHubComponent extends StatelessWidget {
  /// Constructs a [CardHubComponent].
  const CardHubComponent({
    required this.card,
    required this.visaMasterCardType,
    required this.isSelected,
    this.onRemoveCard,
    this.cardHubStyleData,
    super.key,
  });

  /// The credit card model.
  final CardHubModel card;

  /// The type of credit card (Visa or Mastercard).
  final CardType visaMasterCardType;

  /// The style data for the credit card.
  final CardHubStyleData? cardHubStyleData;

  /// The callback function to be called when the remove card button is pressed.
  final void Function()? onRemoveCard;

  /// Whether the credit card is selected.
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: cardHubStyleData?.gradient ?? visaMasterCardType.gradient,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          width: cardHubStyleData?.width ?? MediaQuery.sizeOf(context).width * 0.9,
          margin:
              cardHubStyleData?.margin ??
              const EdgeInsets.symmetric(
                horizontal: Sizes.paddingH20,
              ).copyWith(top: Sizes.paddingV10),
          padding:
              cardHubStyleData?.padding ?? const EdgeInsets.only(left: 16, right: 16, bottom: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CardHubLogo(image: cardHubStyleData?.logoImage ?? visaMasterCardType.image),
              const SizedBox(height: Sizes.marginV16),
              Text(card.bankName ?? '', style: TextStyles.defaultCreditCardStyle(context)),
              const SizedBox(height: Sizes.marginV16),
              Text(
                '${AppConstants.twelveX} ${card.lastFour}',
                textAlign: TextAlign.left,
                style: cardHubStyleData?.textStyle ?? TextStyles.defaultCreditCardStyle(context),
              ),
              const SizedBox(height: Sizes.marginV10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CardHubDetails(
                    label: cardHubStyleData?.labelCardHolder ?? 'CARDHOLDER',
                    value: card.cardHolderName,
                    textStyle: cardHubStyleData?.textStyle,
                  ),
                  CardHubDetails(
                    label: cardHubStyleData?.labelValidThru ?? 'VALID THRU',
                    value: '${card.expirationMonth} / ${card.expirationYear}',
                    textStyle: cardHubStyleData?.textStyle,
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

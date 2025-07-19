import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../card_hub.dart';
import '../../utils/constants.dart';
import '../../utils/styles/styles.dart';

/// A widget representing the logo of a credit card.
class CardHubLogo extends StatelessWidget {
  /// Constructs a [CardHubLogo].
  const CardHubLogo({super.key, required this.image});

  /// The image asset path for the card logo.
  final String image;

  @override
  Widget build(BuildContext context) {
    final isSvg = image.toLowerCase().endsWith('.svg');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          AssetPaths.ASSETS_IMAGES_CARDS_CONTACT_LESS_PNG,
          package: AppConstants.packageName,
          height: 20,
          width: 18,
        ),
        Padding(
          padding: const EdgeInsets.only(top: Sizes.paddingV8, right: Sizes.paddingH8),
          // 👈 Conditionally render based on image type
          child: isSvg
              ? SvgPicture.asset(image, height: 50, width: 50)
              : Image.asset(image, height: 50, width: 50),
        ),
      ],
    );
  }
}

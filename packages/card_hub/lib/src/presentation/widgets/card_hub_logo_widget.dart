
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/asset_paths.dart';
import '../../utils/constants.dart';
import '../../utils/styles/styles.dart';

/// A widget representing the logo of a credit card.
class CardHubLogo extends StatelessWidget {
  /// Constructs a [CardHubLogo].
  const CardHubLogo({
    super.key,
    required this.image,
  });

  /// The image asset path for the card logo.
  final String image;

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.only(
              top: Sizes.paddingV8, right: Sizes.paddingH8),
          child: SvgPicture.asset(
            image,
            package: AppConstants.packageName,
            height: 50,
            width: 50,
          ),
        ),
      ],
    );
  }
}

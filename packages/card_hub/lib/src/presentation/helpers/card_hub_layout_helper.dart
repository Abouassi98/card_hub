import '../../utils/card_configs.dart';

/// A utility class providing helper methods for card layout calculations.
abstract class CardHubLayoutHelper {
  /// Calculates the index of an unselected card based on the selected card index.
  static int unselectedCardIndex({required int index, int? selectedCardIndex}) {
    if (selectedCardIndex != null) {
      if (index < selectedCardIndex) {
        return index;
      } else {
        return index - 1;
      }
    } else {
      throw Exception('selected Card Index is null');
    }
  }

  /// Calculates the vertical position of a card based on its index and selection status.
  static double cardPositioned({
    required int index,
    required bool isSelected,
    int? selectedCardIndex,
  }) {
    if (selectedCardIndex != null) {
      if (isSelected) {
        return CardConfigs.kSpaceBetweenCard;
      } else {
        return CardConfigs.kSpaceUnselectedCardToTop +
            unselectedCardIndex(selectedCardIndex: selectedCardIndex, index: index) *
                CardConfigs.kSpaceBetweenUnselectCard;
      }
    } else {
      return CardConfigs.kSpaceBetweenCard +
          index * CardConfigs.kCardHeight +
          index * CardConfigs.kSpaceBetweenCard;
    }
  }

  /// Calculates the scale of unselected cards based on their index and selection status.
  static double unSelectedCardsScale({
    required bool isSelected,
    required int index,
    required int length,
    int? selectedCardIndex,
  }) {
    if (selectedCardIndex != null) {
      if (isSelected) {
        return 1;
      } else {
        final totalUnselectCard = length - 1;
        return 1.0 -
            (totalUnselectCard -
                    unselectedCardIndex(selectedCardIndex: selectedCardIndex, index: index) -
                    1) *
                0.05;
      }
    } else {
      return 1;
    }
  }

  /// Calculates the total height occupied by all cards.
  static double totalCardsHeight({required int totalCard, int? selectedCardIndex}) {
    if (selectedCardIndex == null) {
      return CardConfigs.kSpaceBetweenCard * (totalCard + 1) + CardConfigs.kCardHeight * totalCard;
    } else {
      return CardConfigs.kSpaceUnselectedCardToTop +
          CardConfigs.kCardHeight +
          (totalCard - 2) * CardConfigs.kSpaceBetweenUnselectCard +
          CardConfigs.kSpaceBetweenCard;
    }
  }
}

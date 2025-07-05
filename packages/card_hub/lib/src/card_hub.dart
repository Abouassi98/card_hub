import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../card_hub.dart';
import 'utils/styles/styles.dart';

part 'card_hub_style_data.dart';

/// A widget representing a motion kit for credit cards.
class CardHubMotionKitWidget extends HookWidget {
  /// Constructs a [CardHubMotionKitWidget].
  const CardHubMotionKitWidget({
    super.key,
    required this.items,
    this.cardHubStyleData,
    this.onRemoveCard,
  });

  /// The list of credit card models.
  final List<CardHubModel> items;

  /// The style configuration for the credit card widgets.
  /// Provides custom width, padding, margin, animation, and more.
  final CardHubStyleData? cardHubStyleData;

  /// Callback triggered when a card is removed from the UI.
  final void Function()? onRemoveCard;

  /// Builds the widget tree for the CardHub motion kit UI.
  ///
  /// Returns a [Scaffold] containing a stack of animated credit card widgets and selection logic.
  @override
  Widget build(BuildContext context) {
    final selectedCardIndexNotifier = useValueNotifier<int?>(null);
    final selectedCardIndex = useValueListenable(selectedCardIndexNotifier);

    void unSelectCard() {
      selectedCardIndexNotifier.value = null;
    }

    return Scaffold(
      appBar: AppBar(),
      body: items.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'No Cards',
                  textAlign: TextAlign.center,
                  style: TextStyles.f18SemiBold(context),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedContainer(
                    duration: CardConfigs.kAnimationDuration,
                    height: CardHubLayoutHelper.totalCardsHeight(
                      selectedCardIndex: selectedCardIndex,
                      totalCard: items.length,
                    ),
                    width: double.infinity,
                  ),
                  for (int i = 0; i < items.length; i++)
                    AnimatedPositioned(
                      top: CardHubLayoutHelper.cardPositioned(
                        selectedCardIndex: selectedCardIndex,
                        index: i,
                        isSelected: i == selectedCardIndex,
                      ),
                      duration: CardConfigs.kAnimationDuration,
                      child: AnimatedScale(
                        scale: CardHubLayoutHelper.unSelectedCardsScale(
                          selectedCardIndex: selectedCardIndex,
                          index: i,
                          length: items.length,
                          isSelected: i == selectedCardIndex,
                        ),
                        duration: CardConfigs.kAnimationDuration,
                        child: GestureDetector(
                          onTap: () {
                            selectedCardIndexNotifier.value = i;
                          },
                          child: CardHubComponent(
                            isSelected: i == selectedCardIndex,
                            onRemoveCard: onRemoveCard,
                            card: items[i],
                            visaMasterCardType: CardType.values.firstWhere(
                              (element) => element.name == items[i].type.name,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (selectedCardIndex != null)
                    Positioned.fill(
                      child: GestureDetector(
                        onVerticalDragEnd: (_) {
                          unSelectCard();
                        },
                        onVerticalDragStart: (_) {
                          unSelectCard();
                        },
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

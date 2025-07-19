import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../card_hub.dart';
import 'utils/color_extractor.dart';
import 'utils/shared_preferences_facade.dart';
import 'utils/styles/styles.dart';

part 'card_hub_style_data.dart';

/// A widget that displays a collection of cards with motion effects, offering a
/// visually engaging way to present a list of [CardHubModel] items.
///
/// This widget is designed to be highly customizable through [cardHubStyleData]
/// and supports interactive features like card selection and removal.
class CardHubMotionKitWidget extends HookWidget {
  /// Creates a [CardHubMotionKitWidget].
  ///
  /// The [items] parameter is required and provides the data for the cards.
  const CardHubMotionKitWidget({
    super.key,
    required this.items,
    this.cardHubStyleData,
    this.onRemoveCard,
  });

  /// The list of card models to be displayed.
  ///
  /// Each [CardHubModel] in the list represents a single card in the widget.
  final List<CardHubModel> items;

  /// Optional styling data to customize the appearance of the Card Hub widget.
  ///
  /// If null, default styles will be applied.
  final CardHubStyleData? cardHubStyleData;

  /// An optional callback function that is triggered when a card is removed.
  final void Function()? onRemoveCard;

  @override
  Widget build(BuildContext context) {
    final selectedCardIndexNotifier = useValueNotifier<int?>(null);
    final selectedCardIndex = useValueListenable(selectedCardIndexNotifier);
    // --- NEW STATE MANAGEMENT ---
    // Holds the reordered list of cards, with the default card at the top.
    final reorderedItems = useState<List<CardHubModel>>([]);
    // Holds the unique ID of the default card, loaded from local storage.
    final defaultCardId = useState<String?>(null);
    // State for color palettes remains the same.
    // State now holds a map of asset paths to a List<Color> palette.
    final brandingPalettes = useState<Map<String, List<Color>>>({});
    final isLoading = useState<bool>(true);

    useEffect(() {
      Future<void> initialize() async {
        isLoading.value = true;
        await SharedPreferencesFacade.init();
        // 1. Fetch the default card ID from local storage
        final savedDefaultId =
            SharedPreferencesFacade.instance.restoreData<String>(SharedPreferencesFacade.defaultCardIdKey);
        defaultCardId.value = savedDefaultId;

        // 2. Reorder the initial list based on the default card ID
        final List<CardHubModel> sortedList = List.from(items);
        if (savedDefaultId != null) {
          final int defaultIndex = sortedList.indexWhere((item) => item.id == savedDefaultId);
          if (defaultIndex != -1) {
            final defaultItem = sortedList.removeAt(defaultIndex);
            sortedList.insert(0, defaultItem);
          }
        }
        reorderedItems.value = sortedList;

        // 3. Generate color palettes (same as before, but uses the original items list)
        final uniqueLogoPaths = items.map((item) => item.logoAssetPath).toSet();
        final processingFutures = uniqueLogoPaths.map((path) async {
          try {
            final byteData = await rootBundle.load(path);
            final palette = await compute(decodeAndExtractCleanPalette, byteData);
            return MapEntry(path, palette);
          } catch (e) {
            debugPrint('Could not process logo $path: $e');
            return null;
          }
        }).toList();

        final results = await Future.wait(processingFutures);
        final newPalettes = Map.fromEntries(results.whereType<MapEntry<String, List<Color>>>());
        brandingPalettes.value = newPalettes;

        isLoading.value = false;
      }

      initialize();
      // The effect depends on the original list of items.
      // If a new list is passed to the widget, it will re-initialize.
      return null;
    }, [items]);

    void unSelectCard() {
      selectedCardIndexNotifier.value = null;
    }

    // --- NEW: Function to set a card as default ---
    Future<void> setDefaultCard(String cardId) async {
      // 1. Save to local storage
      await SharedPreferencesFacade.instance.saveData(
        key: SharedPreferencesFacade.defaultCardIdKey,
        value: cardId,
      );

      // 2. Update the state to reflect the change immediately
      defaultCardId.value = cardId;

      // 3. Reorder the list in the current state
      final currentList = List<CardHubModel>.from(reorderedItems.value);
      final int newDefaultIndex = currentList.indexWhere((item) => item.id == cardId);
      if (newDefaultIndex != -1) {
        final newDefaultItem = currentList.removeAt(newDefaultIndex);
        currentList.insert(0, newDefaultItem);
        reorderedItems.value = currentList;
      }

      // 4. Collapse the cards to show the new order
      unSelectCard();
    }

    if (isLoading.value) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: reorderedItems.value.isEmpty
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
                      totalCard: reorderedItems.value.length,
                    ),
                    width: double.infinity,
                  ),
                  for (int i = 0; i < reorderedItems.value.length; i++)
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
                          length: reorderedItems.value.length,
                          isSelected: i == selectedCardIndex,
                        ),
                        duration: CardConfigs.kAnimationDuration,
                        child: GestureDetector(
                          onTap: () {
                            selectedCardIndexNotifier.value = i;
                          },
                          child: CardHubComponent(
                            isSelected: i == selectedCardIndex,
                            // --- PASS UPDATED PROPS ---
                            isDefault: reorderedItems.value[i].id == defaultCardId.value,
                            onSetAsDefault: () => setDefaultCard(reorderedItems.value[i].id),
                            onRemoveCard: onRemoveCard,
                            card: reorderedItems.value[i],
                            brandingPalette:
                                brandingPalettes.value[reorderedItems.value[i].logoAssetPath],
                            visaMasterCardType: CardType.values.firstWhere(
                              (element) => element.name == reorderedItems.value[i].type.name,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (selectedCardIndex != null)
                    Positioned.fill(
                      child: GestureDetector(
                        onVerticalDragEnd: (_) => unSelectCard(),
                        onVerticalDragStart: (_) => unSelectCard(),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../card_hub.dart';
import 'utils/color_extractor.dart';
import 'utils/styles/styles.dart';

part 'card_hub_style_data.dart';

class CardHubMotionKitWidget extends HookWidget {
  const CardHubMotionKitWidget({
    super.key,
    required this.items,
    this.cardHubStyleData,
    this.onRemoveCard,
  });

  final List<CardHubModel> items;
  final CardHubStyleData? cardHubStyleData;
  final void Function()? onRemoveCard;

  @override
  Widget build(BuildContext context) {
    final selectedCardIndexNotifier = useValueNotifier<int?>(null);
    final selectedCardIndex = useValueListenable(selectedCardIndexNotifier);

    // State now holds a map of asset paths to a List<Color> palette.
    final brandingPalettes = useState<Map<String, List<Color>>>({});
    final isLoading = useState<bool>(true);

 useEffect(() {
      Future<void> generateBranding() async {
        isLoading.value = true;
        final uniqueLogoPaths = items.map((item) => item.logoAssetPath).toSet();

        final processingFutures = uniqueLogoPaths.map((path) async {
          try {
            final byteData = await rootBundle.load(path);
            // **KEY CHANGE**: Call the new 'decodeAndExtractCleanPalette' function
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

      generateBranding();
      return null;
    }, [items]);

    void unSelectCard() {
      selectedCardIndexNotifier.value = null;
    }

    if (isLoading.value) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
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
                            // Pass the extracted palette to the component.
                            brandingPalette: brandingPalettes.value[items[i].logoAssetPath],
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

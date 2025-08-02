import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'card_hub_style_data.dart';
import 'models/card_hub_model.dart';
import 'presentation/components/card_hub_component.dart';
import 'presentation/helpers/card_hub_layout_helper.dart';
import 'utils/card_configs.dart';
import 'utils/color_extractor.dart';
import 'utils/enumerations.dart';
import 'utils/shared_preferences_facade.dart';

/// A widget that displays a collection of cards with motion effects, offering a
/// visually engaging way to present a list of [CardHubModel] items.
///
/// This widget is designed to be highly customizable through [cardHubStyleData]
/// and supports interactive features like card selection and removal.
class CardHub extends StatefulWidget {
  /// Creates a [CardHub].
  ///
  /// The [items] parameter is required and provides the data for the cards.
  const CardHub({
    super.key,
    required this.items,
    this.cardHubStyleData,
    this.onRemoveCard,
    this.loadingWidget,
    this.defaultBadge,
    this.nonDefaultBadge,
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

  /// An optional widget to display while the cards are being loaded.
  final Widget? loadingWidget;

  /// An optional widget to display when a card is selected.
  final Widget Function(CardHubModel)? defaultBadge;

  /// An optional widget to display when a card is not selected.
  final Widget Function(CardHubModel)? nonDefaultBadge;

  @override
  State<CardHub> createState() => _CardHubState();
}

class _CardHubState extends State<CardHub> {
  // ValueNotifier for selected card index
  late final ValueNotifier<int?> selectedCardIndexNotifier;
  
  // State variables
  String? defaultCardId;
  Map<String, List<Color>> brandingPalettes = {};
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    selectedCardIndexNotifier = ValueNotifier<int?>(null);
    _initialize();
  }
  
  @override
  void dispose() {
    selectedCardIndexNotifier.dispose();
    super.dispose();
  }
  
  @override
  void didUpdateWidget(CardHub oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _initialize();
    }
  }
  
  void unSelectCard() {
    selectedCardIndexNotifier.value = null;
  }
  
  Future<void> _initialize() async {
    setState(() {
      isLoading = true;
    });

    // 1. Fetch the default card ID from local storage
    final savedDefaultId = (await SharedPreferencesFacade.instance)
        .restoreData<String>(SharedPreferencesFacade.defaultCardIdKey);
    
    // Update state with the default card ID
    setState(() {
      defaultCardId = savedDefaultId;
    });
    
    selectedCardIndexNotifier.value =
        widget.items.indexWhere((item) => item.id == savedDefaultId);
        
    // 2. Reorder the initial list based on the default card ID
    final List<CardHubModel> sortedList = List.from(widget.items);
    if (savedDefaultId != null) {
      final int defaultIndex =
          sortedList.indexWhere((item) => item.id == savedDefaultId);
      if (defaultIndex != -1) {
        final defaultItem = sortedList.removeAt(defaultIndex);
        sortedList.insert(0, defaultItem);
      }
    } else {
      unSelectCard();
    }
    
    if (sortedList.every(
        (item) => item.logoAssetPath != null && item.cardColor == null)) {
      assert(
          widget.items.every((item) =>
              item.logoAssetPath != null && item.cardColor == null),
          'if CardHub cardColor is null then logoAssetPath must not be null');
          
      // 3. Generate color palettes
      final uniqueLogoPaths =
          widget.items.map((item) => item.logoAssetPath).toSet();
      final processingFutures = uniqueLogoPaths.map((path) async {
        try {
          final byteData = await rootBundle.load(path!);
          final palette =
              await compute(decodeAndExtractCleanPalette, byteData);
          return MapEntry(path, palette);
        } catch (e) {
          debugPrint('Could not process logo $path: $e');
          return null;
        }
      }).toList();

      final results = await Future.wait(processingFutures);
      final newPalettes = Map.fromEntries(
          results.whereType<MapEntry<String, List<Color>>>());
          
      setState(() {
        brandingPalettes = newPalettes;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
  
  // Function to set a card as default
  Future<void> setDefaultCard(String cardId) async {
    // 1. Save to local storage
    await (await SharedPreferencesFacade.instance).saveData(
      key: SharedPreferencesFacade.defaultCardIdKey,
      value: cardId,
    );

    // 2. Update the state to reflect the change immediately
    setState(() {
      defaultCardId = cardId;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // Use a ValueListenableBuilder to listen for changes to the selected card index
    return ValueListenableBuilder<int?>(  
      valueListenable: selectedCardIndexNotifier,
      builder: (context, selectedCardIndex, _) {

        if (isLoading) {
          return widget.loadingWidget ?? const Center(child: CircularProgressIndicator());
    }

        return SingleChildScrollView(
          child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: CardConfigs.kAnimationDuration,
            height: CardHubLayoutHelper.totalCardsHeight(
              selectedCardIndex: selectedCardIndex,
              totalCard: widget.items.length,
            ),
            width: double.infinity,
          ),
          for (int i = 0; i < widget.items.length; i++)
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
                  length: widget.items.length,
                  isSelected: i == selectedCardIndex,
                ),
                duration: CardConfigs.kAnimationDuration,
                child: GestureDetector(
                  onTap: () {
                    setDefaultCard(widget.items[i].id);
                    selectedCardIndexNotifier.value = i;
                    widget.items[i].onCardTap?.call(widget.items[i]);
                  },
                  child: CardHubComponent(
                    defaultBadge: widget.defaultBadge,
                    nonDefaultBadge: widget.nonDefaultBadge,
                    isSelected: i == selectedCardIndex,
                    // --- PASS UPDATED PROPS ---
                    isDefault: widget.items[i].id == defaultCardId,
                    onRemoveCard: widget.onRemoveCard,

                    card: widget.items[i],
                    brandingPalette:
                        brandingPalettes[widget.items[i].logoAssetPath],
                    visaMasterCardType: CardType.values.firstWhere(
                      (element) => element.name == widget.items[i].type.name,
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
        );
      },
    );
  
  }
}

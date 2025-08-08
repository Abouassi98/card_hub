import 'package:flutter/material.dart';

import 'card_hub_style_data.dart';
import 'models/card_hub_model.dart';
import 'presentation/components/card_hub_component.dart';
import 'presentation/helpers/card_hub_layout_helper.dart';
import 'services/card_hub_service.dart';
import 'utils/card_configs.dart';
import 'utils/enumerations.dart';

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

class _CardHubState extends State<CardHub> with AutomaticKeepAliveClientMixin {
  // State variables - optimized for better performance
  late List<CardHubModel> _displayItems;
  String? _defaultCardId;
  late Map<String, List<Color>> _brandingPalettes;
  bool _isLoading = true;
  int? _selectedCardIndex;

  // Keep widget alive when it's not visible to preserve state and avoid rebuilds
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didUpdateWidget(CardHub oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _initialize();
    }
  }

  /// Clears the selected card
  void _unselectCard() {
    if (_selectedCardIndex != null) {
      setState(() {
        _selectedCardIndex = null;
      });
    }
  }

  /// Initializes the widget with data using optimized lazy loading approach
  Future<void> _initialize() async {
    // If any item is marked default, persist it first
    if (widget.items.any((item) => item.isDefault)) {
      _defaultCardId = widget.items.firstWhere((item) => item.isDefault).id;
      await CardHubService.saveDefaultCardId(_defaultCardId!);
    }

    // 1) Resolve default ID, 2) reorder items, 3) compute selected index
    final savedDefaultId = _defaultCardId ?? await CardHubService.getDefaultCardId();
    final reorderedItems = CardHubService.reorderCardsByDefaultId(widget.items, savedDefaultId);
    final selectedIndex = CardHubService.findDefaultCardIndex(reorderedItems, savedDefaultId);

    // Single, batched state update to avoid multiple rebuilds
    setState(() {
      _displayItems = reorderedItems;
      _defaultCardId = savedDefaultId;
      _selectedCardIndex = selectedIndex;
      _isLoading = false;
      // Reset palettes; they will be filled asynchronously
      _brandingPalettes = {};
    });

    // Lazily load palettes in background
    await _loadColorPalettes();
  }

  /// Lazily loads color palettes in the background
  /// This improves initial load time and reduces memory pressure
  Future<void> _loadColorPalettes() async {
    // Extract color palettes in parallel
    final palettes = await CardHubService.extractColorPalettes(widget.items);

    // Only update state if widget is still mounted
    if (mounted) {
      // Only trigger rebuild if palettes actually changed
      if (!CardHubService.palettesEqual(_brandingPalettes, palettes)) {
        setState(() {
          _brandingPalettes = palettes;
        });
      }
    }
  }

  /// Sets a card as the default
  Future<void> _setDefaultCard(String cardId, int index) async {
    // 1. Save to service
    await CardHubService.saveDefaultCardId(cardId);

    // 2. Update state
    setState(() {
      _defaultCardId = cardId;
      _selectedCardIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required by AutomaticKeepAliveClientMixin
    // Direct state-based rendering for better performance
    if (_isLoading) {
      return widget.loadingWidget ?? const Center(child: CircularProgressIndicator());
    }

    // Fast-path: render nothing for empty lists to avoid building animated stack
    if (_displayItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Container for proper height calculation
          AnimatedContainer(
            duration: CardConfigs.kAnimationDuration,
            height: CardHubLayoutHelper.totalCardsHeight(
              selectedCardIndex: _selectedCardIndex,
              totalCard: _displayItems.length,
            ),
            width: double.infinity,
          ),

          // Render each card with animations
          for (int i = 0; i < _displayItems.length; i++)
            AnimatedPositioned(
              top: CardHubLayoutHelper.cardPositioned(
                selectedCardIndex: _selectedCardIndex,
                index: i,
                isSelected: i == _selectedCardIndex,
              ),
              duration: CardConfigs.kAnimationDuration,
              child: AnimatedScale(
                scale: CardHubLayoutHelper.unSelectedCardsScale(
                  selectedCardIndex: _selectedCardIndex,
                  index: i,
                  length: _displayItems.length,
                  isSelected: i == _selectedCardIndex,
                ),
                duration: CardConfigs.kAnimationDuration,
                child: GestureDetector(
                  onTap: () {
                    _setDefaultCard(_displayItems[i].id, i);
                    _displayItems[i].onCardTap?.call(_displayItems[i]);
                  },
                  child: CardHubComponent(
                    key: ValueKey<String>(_displayItems[i].id),
                    defaultBadge: widget.defaultBadge,
                    nonDefaultBadge: widget.nonDefaultBadge,
                    isSelected: i == _selectedCardIndex,
                    isDefault: _displayItems[i].id == _defaultCardId,
                    onRemoveCard: widget.onRemoveCard,
                    card: _displayItems[i],
                    brandingPalette: _brandingPalettes[_displayItems[i].logoAssetPath],
                    visaMasterCardType: CardType.values.firstWhere(
                      (element) => element.name == _displayItems[i].type.name,
                      orElse: () => CardType.visa,
                    ),
                  ),
                ),
              ),
            ),

          // Gesture detector for unselecting cards
          if (_selectedCardIndex != null)
            Positioned.fill(
              child: GestureDetector(
                onVerticalDragEnd: (_) => _unselectCard(),
                onVerticalDragStart: (_) => _unselectCard(),
              ),
            ),
        ],
      ),
    );
  }
}

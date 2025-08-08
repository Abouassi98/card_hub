# CardHub Performance Best Practices

This document outlines the performance optimizations implemented in the CardHub package and provides best practices for maintaining optimal performance in your implementation.

## Implemented Optimizations

### 1. Color Palette Extraction Caching

The CardHub package now implements a static cache for color palettes extracted from logo assets. This significantly reduces CPU usage and memory allocations when the same logo is used multiple times.

```dart
// In CardHubService
static final Map<String, List<Color>> _colorPaletteCache = {};
```

### 2. RepaintBoundary for Efficient Rendering

Each CardHubComponent is now wrapped in a RepaintBoundary to prevent unnecessary repainting of the entire widget tree when only a single card changes.

```dart
// In CardHubComponent
return RepaintBoundary(
  child: Stack(
    // Card content
  ),
);
```

### 3. Memoized Color and Gradient Calculations

Color and gradient calculations are now memoized to avoid recalculating the same values on every build cycle:

```dart
// In CardHubComponent
static final Map<List<Color>?, Color> _contentColorCache = {};
static final Map<List<Color>?, Gradient?> _gradientCache = {};
```

### 4. Lazy Loading for Color Palettes

Color palettes are now loaded lazily in the background, allowing the UI to be interactive while heavy computations are performed:

```dart
// First update state with basic data
setState(() {
  _displayItems = reorderedItems;
  _defaultCardId = savedDefaultId;
  _selectedCardIndex = selectedIndex;
  _isLoading = false;
});

// Then lazily load color palettes
_loadColorPalettes();
```

### 5. Widget State Preservation

The CardHub widget now implements AutomaticKeepAliveClientMixin to preserve its state when it's not visible, reducing unnecessary rebuilds:

```dart
class _CardHubState extends State<CardHub> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  
  @override
  Widget build(BuildContext context) {
    super.build(context); // Required by AutomaticKeepAliveClientMixin
    // ...
  }
}
```

### 6. Provider-Based State Management

A dedicated CardHubNotifier class is now available for integration with provider-based state management solutions:

```dart
// Example usage with Provider
final cardHubProvider = ChangeNotifierProvider((ref) => 
  CardHubNotifier(items: yourCardItems)
);

// Example usage with Riverpod
final cardHubProvider = ChangeNotifierProvider.autoDispose((ref) => 
  CardHubNotifier(items: yourCardItems)
);
```

## Best Practices for Implementation

### 1. Minimize Card List Changes

Avoid frequently changing the entire list of cards. Instead, update individual cards when needed:

```dart
// Avoid this when only one card changes
cardHubNotifier = CardHubNotifier(items: entirelyNewList);

// Prefer this when possible
cardHubNotifier.updateSingleCard(updatedCard);
```

### 2. Provide Fallback Colors

Always provide fallback colors for cards that don't have logo assets to avoid processing errors:

```dart
CardHubModel(
  id: 'card-1',
  logoAssetPath: null, // No logo
  cardColor: Colors.blueGrey, // Fallback color
  // Other properties
)
```

### 3. Use Appropriate Image Sizes

Resize logo images to appropriate dimensions before adding them to your assets. Large images will consume more memory and take longer to process:

```
// Recommended logo dimensions: 64x64 to 128x128 pixels
```

### 4. Implement Pagination for Large Card Lists

If your application needs to display a large number of cards, consider implementing pagination:

```dart
// Example pagination implementation
CardHub(
  items: cards.sublist(currentPage * pageSize, (currentPage + 1) * pageSize),
  // Other properties
)
```

### 5. Test Performance Under Load

Regularly test your implementation with realistic data loads to ensure consistent performance:

```dart
// Example test with realistic data
testWidgets('CardHub performs well with 20 cards', (tester) async {
  // Create 20 test cards
  final cards = List.generate(20, (i) => createTestCard(i));
  
  // Render the CardHub
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(body: CardHub(items: cards)),
  ));
  
  // Measure performance
  final stopwatch = Stopwatch()..start();
  await tester.pump(const Duration(milliseconds: 16 * 30)); // 30 frames
  stopwatch.stop();
  
  // Log results
  print('Average frame time: ${stopwatch.elapsedMilliseconds / 30} ms');
});
```

## Memory Management

### 1. Dispose Resources

Ensure that any resources used by the CardHub are properly disposed when no longer needed:

```dart
@override
void dispose() {
  cardHubNotifier.dispose();
  super.dispose();
}
```

### 2. Use const Constructors

Use const constructors for widgets that don't change to reduce memory allocations:

```dart
const SizedBox(height: Sizes.marginV16)
```

### 3. Avoid Unnecessary Rebuilds

Structure your widget tree to minimize unnecessary rebuilds:

```dart
// Avoid rebuilding the entire CardHub when only one property changes
Consumer<CardHubNotifier>(
  builder: (context, notifier, _) => CardHub(
    items: notifier.displayItems,
    // Other properties
  ),
)
```

By following these best practices, you can ensure that your CardHub implementation maintains optimal performance and provides a smooth user experience.

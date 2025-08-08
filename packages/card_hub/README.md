# Card Hub

A Flutter package that provides a visually engaging and animated way to display credit/debit cards. Perfect for payment apps, digital wallets, or any application that needs to showcase payment cards in an elegant manner.

Card Hub allows users to select a default card that appears above other cards, with smooth animations during transitions. The package automatically stores the default card ID in local storage for persistence across sessions.


<!-- Use HTML for better control -->
<p align="center">
  <img src="https://github.com/Abouassi98/card_hub/blob/Dev/packages/card_hub/.github/gifs/card_hub.gif?raw=true" width="600" height="1000" alt="Card Hub Demo">
</p>




## Features

- **Animated Card Stack**: Display multiple cards in a visually appealing stack with smooth animations
- **Default Card Selection**: Allow users to select a default card that appears above others
- **Persistent Selection**: Store default card selection in local storage via `SharedPreferences` (see `SharedPreferencesFacade`)
- **Premium Branding (Material 3)**:
  - Dynamic app theming from card logo using `MaterialColorExtractor`
  - Automatic light/dark `ColorScheme` generation with in-memory caching
  - `CardHubThemeProvider` exposes `lightTheme`/`darkTheme` and `updateThemeFromCard()`
- **Dynamic Card Styling**:
  - Use custom colors or auto-extracted logo colors for branded designs
  - Support for custom images on cards
- **Card Types Support**: Built-in support for Visa, Mastercard, AmEx, Discover, etc.
- **Highly Customizable**:
  - Custom badges for default/non-default cards
  - Customizable text styles and layouts
  - Support for card removal functionality

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  card_hub: ^0.2.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Implementation

```dart
import 'package:card_hub/card_hub.dart';
import 'package:flutter/material.dart';

class CardHubDemo extends StatelessWidget {
  const CardHubDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a list of card models
    final List<CardHubModel> cards = [
      CardHubModel(
        id: '1',
        lastFour: 1234,
        expirationMonth: 12,
        expirationYear: 25,
        cardHolderName: 'JOHN DOE',
        type: CardType.visa,
        bankName: 'EXAMPLE BANK',
        // Option 1: Provide a logo asset path for automatic color extraction
        logoAssetPath: 'assets/logos/bank_logo.png',
        onCardTap: (card) {
          print('Card tapped: ${card.bankName}');
        },
      ),
      CardHubModel(
        id: '2',
        lastFour: 5678,
        expirationMonth: 10,
        expirationYear: 26,
        cardHolderName: 'JANE SMITH',
        type: CardType.mastercard,
        bankName: 'ANOTHER BANK',
        // Option 2: Provide a specific card color
        cardColor: Colors.purple,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Card Hub Demo')),
      body: CardHub(
        items: cards,
        // Optional: Provide custom styling
        cardHubStyleData: CardHubStyleData(
          width: 350,
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Optional: Handle card removal
        onRemoveCard: () {
          print('Card removed');
        },
        // Optional: Custom badge for default card
        defaultBadge: (card) => Positioned(
          top: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'DEFAULT',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
```

### Dynamic App Theming (Premium Branding)

Use `CardHubThemeProvider` to derive a full Material 3 theme from the selected card's logo and apply it across your app.

```dart
import 'package:card_hub/card_hub.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeProvider = CardHubThemeProvider(useMaterial3: true);

  // Example items; when selection changes, call updateThemeFromCard(selected)
  final items = <CardHubModel>[
    CardHubModel(
      id: '1',
      lastFour: 1234,
      expirationMonth: 12,
      expirationYear: 25,
      cardHolderName: 'JOHN DOE',
      type: CardType.visa,
      bankName: 'EXAMPLE BANK',
      logoAssetPath: 'assets/images/cards/visa_logo.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize theme from first card (optional)
    themeProvider.updateThemeFromCard(items.first);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeProvider,
      builder: (context, _) {
        return MaterialApp(
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          home: Scaffold(
            appBar: AppBar(title: const Text('Card Hub Theming')),
            body: CardHub(
              items: items
                  .map(
                    (e) => e.copyWith(
                      onCardTap: (card) => themeProvider.updateThemeFromCard(card),
                    ),
                  )
                  .toList(),
              onRemoveCard: () {},
            ),
          ),
        );
      },
    );
  }
}
```

### Customization Options

#### Card Hub Style Data

```dart
CardHubStyleData(
  width: 350, // Custom card width
  padding: EdgeInsets.all(20), // Custom padding
  gradient: LinearGradient(
    colors: [Colors.blue, Colors.purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  textStyle: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
  labelCardHolder: 'OWNER', // Custom label for cardholder
  labelValidThru: 'EXPIRES', // Custom label for expiration date
  logoImage: 'assets/custom_logo.png', // Custom logo image
)
```

#### Card Hub Model

```dart
CardHubModel(
  id: 'unique_id', // Required: Unique identifier for the card
  lastFour: 1234, // Required: Last four digits of the card
  expirationMonth: 12, // Required: Expiration month
  expirationYear: 25, // Required: Expiration year
  cardHolderName: 'JOHN DOE', // Required: Cardholder name
  type: CardType.visa, // Required: Card type
  bankName: 'EXAMPLE BANK', // Required: Bank name
  
  // Optional: Either provide logoAssetPath OR cardColor, not both
  logoAssetPath: 'assets/logos/bank_logo.png', // For automatic color extraction
  // OR
  cardColor: Colors.blue, // For solid color background
  
  // Optional: Callback when card is tapped
  onCardTap: (card) {
    print('Card tapped: ${card.bankName}');
  },
)
```

## Card Types

The package supports the following card types:
- `CardType.visa`
- `CardType.mastercard`
- `CardType.rupay`
- `CardType.americanExpress`
- `CardType.unionpay`
- `CardType.discover`
- `CardType.elo`
- `CardType.otherBrand`

## Notes and Best Practices

- **Assets**: If you use `logoAssetPath` in `CardHubModel`, ensure the asset is listed under `flutter/assets` in your app's `pubspec.yaml`.
- **Persistence**: Default card ID is stored via `SharedPreferences` using `CardHubService.saveDefaultCardId()` and restored by `CardHubService.getDefaultCardId()`.
- **Performance**: Color extraction uses in-memory caching. See `lib/src/docs/performance_best_practices.md` for guidance.
- **API Surface**: Public exports include `CardHub`, `CardHubStyleData`, `CardHubModel`, `CardHubThemeProvider`, and utilities under `src/utils/` via `card_hub.dart`.

## License

This package is available under the [MIT License](LICENSE)

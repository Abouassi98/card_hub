// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_hub_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CardHubModel {
  /// A unique identifier for the card.
  String get id => throw _privateConstructorUsedError;

  /// A string indicating number on the card.
  int get lastFour => throw _privateConstructorUsedError;

  /// The expiration month of the credit card.
  int get expirationMonth => throw _privateConstructorUsedError;

  /// The expiration year of the credit card.
  int get expirationYear => throw _privateConstructorUsedError;

  /// A string indicating name of the card holder.
  String get cardHolderName => throw _privateConstructorUsedError;

  /// Sets type of the card. An small image is shown based on selected type
  /// of the card at bottom right corner. If this is set to null then image
  /// shown automatically based on credit card number.
  CardType get type => throw _privateConstructorUsedError;

  /// A string indicating name of the bank.
  String get bankName => throw _privateConstructorUsedError;

  /// The local asset path for the card's brand logo (e.g., 'assets/logos/netflix.png').
  /// If provided, the card will be themed based on this logo.
  String? get logoAssetPath => throw _privateConstructorUsedError;

  /// The color of the card. If provided, the card will be themed based on this color.
  Color? get cardColor => throw _privateConstructorUsedError;

  /// Optional callback function that is triggered when a card is selected.
  void Function(CardHubModel)? get onCardTap =>
      throw _privateConstructorUsedError;

  /// Create a copy of CardHubModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CardHubModelCopyWith<CardHubModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardHubModelCopyWith<$Res> {
  factory $CardHubModelCopyWith(
          CardHubModel value, $Res Function(CardHubModel) then) =
      _$CardHubModelCopyWithImpl<$Res, CardHubModel>;
  @useResult
  $Res call(
      {String id,
      int lastFour,
      int expirationMonth,
      int expirationYear,
      String cardHolderName,
      CardType type,
      String bankName,
      String? logoAssetPath,
      Color? cardColor,
      void Function(CardHubModel)? onCardTap});
}

/// @nodoc
class _$CardHubModelCopyWithImpl<$Res, $Val extends CardHubModel>
    implements $CardHubModelCopyWith<$Res> {
  _$CardHubModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CardHubModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastFour = null,
    Object? expirationMonth = null,
    Object? expirationYear = null,
    Object? cardHolderName = null,
    Object? type = null,
    Object? bankName = null,
    Object? logoAssetPath = freezed,
    Object? cardColor = freezed,
    Object? onCardTap = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lastFour: null == lastFour
          ? _value.lastFour
          : lastFour // ignore: cast_nullable_to_non_nullable
              as int,
      expirationMonth: null == expirationMonth
          ? _value.expirationMonth
          : expirationMonth // ignore: cast_nullable_to_non_nullable
              as int,
      expirationYear: null == expirationYear
          ? _value.expirationYear
          : expirationYear // ignore: cast_nullable_to_non_nullable
              as int,
      cardHolderName: null == cardHolderName
          ? _value.cardHolderName
          : cardHolderName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CardType,
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      logoAssetPath: freezed == logoAssetPath
          ? _value.logoAssetPath
          : logoAssetPath // ignore: cast_nullable_to_non_nullable
              as String?,
      cardColor: freezed == cardColor
          ? _value.cardColor
          : cardColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      onCardTap: freezed == onCardTap
          ? _value.onCardTap
          : onCardTap // ignore: cast_nullable_to_non_nullable
              as void Function(CardHubModel)?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CardHubModelImplCopyWith<$Res>
    implements $CardHubModelCopyWith<$Res> {
  factory _$$CardHubModelImplCopyWith(
          _$CardHubModelImpl value, $Res Function(_$CardHubModelImpl) then) =
      __$$CardHubModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int lastFour,
      int expirationMonth,
      int expirationYear,
      String cardHolderName,
      CardType type,
      String bankName,
      String? logoAssetPath,
      Color? cardColor,
      void Function(CardHubModel)? onCardTap});
}

/// @nodoc
class __$$CardHubModelImplCopyWithImpl<$Res>
    extends _$CardHubModelCopyWithImpl<$Res, _$CardHubModelImpl>
    implements _$$CardHubModelImplCopyWith<$Res> {
  __$$CardHubModelImplCopyWithImpl(
      _$CardHubModelImpl _value, $Res Function(_$CardHubModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CardHubModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastFour = null,
    Object? expirationMonth = null,
    Object? expirationYear = null,
    Object? cardHolderName = null,
    Object? type = null,
    Object? bankName = null,
    Object? logoAssetPath = freezed,
    Object? cardColor = freezed,
    Object? onCardTap = freezed,
  }) {
    return _then(_$CardHubModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lastFour: null == lastFour
          ? _value.lastFour
          : lastFour // ignore: cast_nullable_to_non_nullable
              as int,
      expirationMonth: null == expirationMonth
          ? _value.expirationMonth
          : expirationMonth // ignore: cast_nullable_to_non_nullable
              as int,
      expirationYear: null == expirationYear
          ? _value.expirationYear
          : expirationYear // ignore: cast_nullable_to_non_nullable
              as int,
      cardHolderName: null == cardHolderName
          ? _value.cardHolderName
          : cardHolderName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CardType,
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      logoAssetPath: freezed == logoAssetPath
          ? _value.logoAssetPath
          : logoAssetPath // ignore: cast_nullable_to_non_nullable
              as String?,
      cardColor: freezed == cardColor
          ? _value.cardColor
          : cardColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      onCardTap: freezed == onCardTap
          ? _value.onCardTap
          : onCardTap // ignore: cast_nullable_to_non_nullable
              as void Function(CardHubModel)?,
    ));
  }
}

/// @nodoc

class _$CardHubModelImpl extends _CardHubModel {
  const _$CardHubModelImpl(
      {required this.id,
      required this.lastFour,
      required this.expirationMonth,
      required this.expirationYear,
      required this.cardHolderName,
      required this.type,
      required this.bankName,
      this.logoAssetPath,
      this.cardColor,
      this.onCardTap})
      : super._();

  /// A unique identifier for the card.
  @override
  final String id;

  /// A string indicating number on the card.
  @override
  final int lastFour;

  /// The expiration month of the credit card.
  @override
  final int expirationMonth;

  /// The expiration year of the credit card.
  @override
  final int expirationYear;

  /// A string indicating name of the card holder.
  @override
  final String cardHolderName;

  /// Sets type of the card. An small image is shown based on selected type
  /// of the card at bottom right corner. If this is set to null then image
  /// shown automatically based on credit card number.
  @override
  final CardType type;

  /// A string indicating name of the bank.
  @override
  final String bankName;

  /// The local asset path for the card's brand logo (e.g., 'assets/logos/netflix.png').
  /// If provided, the card will be themed based on this logo.
  @override
  final String? logoAssetPath;

  /// The color of the card. If provided, the card will be themed based on this color.
  @override
  final Color? cardColor;

  /// Optional callback function that is triggered when a card is selected.
  @override
  final void Function(CardHubModel)? onCardTap;

  @override
  String toString() {
    return 'CardHubModel(id: $id, lastFour: $lastFour, expirationMonth: $expirationMonth, expirationYear: $expirationYear, cardHolderName: $cardHolderName, type: $type, bankName: $bankName, logoAssetPath: $logoAssetPath, cardColor: $cardColor, onCardTap: $onCardTap)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardHubModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lastFour, lastFour) ||
                other.lastFour == lastFour) &&
            (identical(other.expirationMonth, expirationMonth) ||
                other.expirationMonth == expirationMonth) &&
            (identical(other.expirationYear, expirationYear) ||
                other.expirationYear == expirationYear) &&
            (identical(other.cardHolderName, cardHolderName) ||
                other.cardHolderName == cardHolderName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.logoAssetPath, logoAssetPath) ||
                other.logoAssetPath == logoAssetPath) &&
            (identical(other.cardColor, cardColor) ||
                other.cardColor == cardColor) &&
            (identical(other.onCardTap, onCardTap) ||
                other.onCardTap == onCardTap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      lastFour,
      expirationMonth,
      expirationYear,
      cardHolderName,
      type,
      bankName,
      logoAssetPath,
      cardColor,
      onCardTap);

  /// Create a copy of CardHubModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CardHubModelImplCopyWith<_$CardHubModelImpl> get copyWith =>
      __$$CardHubModelImplCopyWithImpl<_$CardHubModelImpl>(this, _$identity);
}

abstract class _CardHubModel extends CardHubModel {
  const factory _CardHubModel(
      {required final String id,
      required final int lastFour,
      required final int expirationMonth,
      required final int expirationYear,
      required final String cardHolderName,
      required final CardType type,
      required final String bankName,
      final String? logoAssetPath,
      final Color? cardColor,
      final void Function(CardHubModel)? onCardTap}) = _$CardHubModelImpl;
  const _CardHubModel._() : super._();

  /// A unique identifier for the card.
  @override
  String get id;

  /// A string indicating number on the card.
  @override
  int get lastFour;

  /// The expiration month of the credit card.
  @override
  int get expirationMonth;

  /// The expiration year of the credit card.
  @override
  int get expirationYear;

  /// A string indicating name of the card holder.
  @override
  String get cardHolderName;

  /// Sets type of the card. An small image is shown based on selected type
  /// of the card at bottom right corner. If this is set to null then image
  /// shown automatically based on credit card number.
  @override
  CardType get type;

  /// A string indicating name of the bank.
  @override
  String get bankName;

  /// The local asset path for the card's brand logo (e.g., 'assets/logos/netflix.png').
  /// If provided, the card will be themed based on this logo.
  @override
  String? get logoAssetPath;

  /// The color of the card. If provided, the card will be themed based on this color.
  @override
  Color? get cardColor;

  /// Optional callback function that is triggered when a card is selected.
  @override
  void Function(CardHubModel)? get onCardTap;

  /// Create a copy of CardHubModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CardHubModelImplCopyWith<_$CardHubModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

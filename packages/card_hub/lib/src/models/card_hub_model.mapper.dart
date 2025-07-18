// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'card_hub_model.dart';

class CardHubModelMapper extends ClassMapperBase<CardHubModel> {
  CardHubModelMapper._();

  static CardHubModelMapper? _instance;
  static CardHubModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CardHubModelMapper._());
      CardTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CardHubModel';

  static int _$lastFour(CardHubModel v) => v.lastFour;
  static const Field<CardHubModel, int> _f$lastFour =
      Field('lastFour', _$lastFour);
  static int _$expirationMonth(CardHubModel v) => v.expirationMonth;
  static const Field<CardHubModel, int> _f$expirationMonth =
      Field('expirationMonth', _$expirationMonth);
  static int _$expirationYear(CardHubModel v) => v.expirationYear;
  static const Field<CardHubModel, int> _f$expirationYear =
      Field('expirationYear', _$expirationYear);
  static String _$cardHolderName(CardHubModel v) => v.cardHolderName;
  static const Field<CardHubModel, String> _f$cardHolderName =
      Field('cardHolderName', _$cardHolderName);
  static CardType _$type(CardHubModel v) => v.type;
  static const Field<CardHubModel, CardType> _f$type = Field('type', _$type);
  static String? _$bankName(CardHubModel v) => v.bankName;
  static const Field<CardHubModel, String> _f$bankName =
      Field('bankName', _$bankName);

  @override
  final MappableFields<CardHubModel> fields = const {
    #lastFour: _f$lastFour,
    #expirationMonth: _f$expirationMonth,
    #expirationYear: _f$expirationYear,
    #cardHolderName: _f$cardHolderName,
    #type: _f$type,
    #bankName: _f$bankName,
  };

  static CardHubModel _instantiate(DecodingData data) {
    return CardHubModel(
        lastFour: data.dec(_f$lastFour),
        expirationMonth: data.dec(_f$expirationMonth),
        expirationYear: data.dec(_f$expirationYear),
        cardHolderName: data.dec(_f$cardHolderName),
        type: data.dec(_f$type),
        bankName: data.dec(_f$bankName));
  }

  @override
  final Function instantiate = _instantiate;

  static CardHubModel fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CardHubModel>(map);
  }

  static CardHubModel deserialize(String json) {
    return ensureInitialized().decodeJson<CardHubModel>(json);
  }
}

mixin CardHubModelMappable {
  String serialize() {
    return CardHubModelMapper.ensureInitialized()
        .encodeJson<CardHubModel>(this as CardHubModel);
  }

  Map<String, dynamic> toJson() {
    return CardHubModelMapper.ensureInitialized()
        .encodeMap<CardHubModel>(this as CardHubModel);
  }

  CardHubModelCopyWith<CardHubModel, CardHubModel, CardHubModel> get copyWith =>
      _CardHubModelCopyWithImpl<CardHubModel, CardHubModel>(
          this as CardHubModel, $identity, $identity);
  @override
  String toString() {
    return CardHubModelMapper.ensureInitialized()
        .stringifyValue(this as CardHubModel);
  }

  @override
  bool operator ==(Object other) {
    return CardHubModelMapper.ensureInitialized()
        .equalsValue(this as CardHubModel, other);
  }

  @override
  int get hashCode {
    return CardHubModelMapper.ensureInitialized()
        .hashValue(this as CardHubModel);
  }
}

extension CardHubModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CardHubModel, $Out> {
  CardHubModelCopyWith<$R, CardHubModel, $Out> get $asCardHubModel =>
      $base.as((v, t, t2) => _CardHubModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CardHubModelCopyWith<$R, $In extends CardHubModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? lastFour,
      int? expirationMonth,
      int? expirationYear,
      String? cardHolderName,
      CardType? type,
      String? bankName});
  CardHubModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CardHubModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CardHubModel, $Out>
    implements CardHubModelCopyWith<$R, CardHubModel, $Out> {
  _CardHubModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CardHubModel> $mapper =
      CardHubModelMapper.ensureInitialized();
  @override
  $R call(
          {int? lastFour,
          int? expirationMonth,
          int? expirationYear,
          String? cardHolderName,
          CardType? type,
          Object? bankName = $none}) =>
      $apply(FieldCopyWithData({
        if (lastFour != null) #lastFour: lastFour,
        if (expirationMonth != null) #expirationMonth: expirationMonth,
        if (expirationYear != null) #expirationYear: expirationYear,
        if (cardHolderName != null) #cardHolderName: cardHolderName,
        if (type != null) #type: type,
        if (bankName != $none) #bankName: bankName
      }));
  @override
  CardHubModel $make(CopyWithData data) => CardHubModel(
      lastFour: data.get(#lastFour, or: $value.lastFour),
      expirationMonth: data.get(#expirationMonth, or: $value.expirationMonth),
      expirationYear: data.get(#expirationYear, or: $value.expirationYear),
      cardHolderName: data.get(#cardHolderName, or: $value.cardHolderName),
      type: data.get(#type, or: $value.type),
      bankName: data.get(#bankName, or: $value.bankName));

  @override
  CardHubModelCopyWith<$R2, CardHubModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CardHubModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

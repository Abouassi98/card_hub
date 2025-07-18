// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'enumerations.dart';

class CardTypeMapper extends EnumMapper<CardType> {
  CardTypeMapper._();

  static CardTypeMapper? _instance;
  static CardTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CardTypeMapper._());
    }
    return _instance!;
  }

  static CardType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  CardType decode(dynamic value) {
    switch (value) {
      case r'otherBrand':
        return CardType.otherBrand;
      case r'visa':
        return CardType.visa;
      case r'mastercard':
        return CardType.mastercard;
      case r'rupay':
        return CardType.rupay;
      case r'americanExpress':
        return CardType.americanExpress;
      case r'unionpay':
        return CardType.unionpay;
      case r'discover':
        return CardType.discover;
      case r'elo':
        return CardType.elo;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(CardType self) {
    switch (self) {
      case CardType.otherBrand:
        return r'otherBrand';
      case CardType.visa:
        return r'visa';
      case CardType.mastercard:
        return r'mastercard';
      case CardType.rupay:
        return r'rupay';
      case CardType.americanExpress:
        return r'americanExpress';
      case CardType.unionpay:
        return r'unionpay';
      case CardType.discover:
        return r'discover';
      case CardType.elo:
        return r'elo';
    }
  }
}

extension CardTypeMapperExtension on CardType {
  String toValue() {
    CardTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<CardType>(this) as String;
  }
}

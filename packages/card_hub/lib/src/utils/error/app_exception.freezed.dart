// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppException {
  LocalExceptionType get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int? get code => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            LocalExceptionType type, String message, int? code)
        localException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LocalExceptionType type, String message, int? code)?
        localException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LocalExceptionType type, String message, int? code)?
        localException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocalException value) localException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocalException value)? localException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocalException value)? localException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppExceptionCopyWith<AppException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppExceptionCopyWith<$Res> {
  factory $AppExceptionCopyWith(
          AppException value, $Res Function(AppException) then) =
      _$AppExceptionCopyWithImpl<$Res, AppException>;
  @useResult
  $Res call({LocalExceptionType type, String message, int? code});
}

/// @nodoc
class _$AppExceptionCopyWithImpl<$Res, $Val extends AppException>
    implements $AppExceptionCopyWith<$Res> {
  _$AppExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LocalExceptionType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalExceptionImplCopyWith<$Res>
    implements $AppExceptionCopyWith<$Res> {
  factory _$$LocalExceptionImplCopyWith(_$LocalExceptionImpl value,
          $Res Function(_$LocalExceptionImpl) then) =
      __$$LocalExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LocalExceptionType type, String message, int? code});
}

/// @nodoc
class __$$LocalExceptionImplCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res, _$LocalExceptionImpl>
    implements _$$LocalExceptionImplCopyWith<$Res> {
  __$$LocalExceptionImplCopyWithImpl(
      _$LocalExceptionImpl _value, $Res Function(_$LocalExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? code = freezed,
  }) {
    return _then(_$LocalExceptionImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LocalExceptionType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$LocalExceptionImpl implements LocalException {
  const _$LocalExceptionImpl(
      {required this.type, required this.message, this.code});

  @override
  final LocalExceptionType type;
  @override
  final String message;
  @override
  final int? code;

  @override
  String toString() {
    return 'AppException.localException(type: $type, message: $message, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalExceptionImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, message, code);

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalExceptionImplCopyWith<_$LocalExceptionImpl> get copyWith =>
      __$$LocalExceptionImplCopyWithImpl<_$LocalExceptionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            LocalExceptionType type, String message, int? code)
        localException,
  }) {
    return localException(type, message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LocalExceptionType type, String message, int? code)?
        localException,
  }) {
    return localException?.call(type, message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LocalExceptionType type, String message, int? code)?
        localException,
    required TResult orElse(),
  }) {
    if (localException != null) {
      return localException(type, message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocalException value) localException,
  }) {
    return localException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocalException value)? localException,
  }) {
    return localException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocalException value)? localException,
    required TResult orElse(),
  }) {
    if (localException != null) {
      return localException(this);
    }
    return orElse();
  }
}

abstract class LocalException implements AppException {
  const factory LocalException(
      {required final LocalExceptionType type,
      required final String message,
      final int? code}) = _$LocalExceptionImpl;

  @override
  LocalExceptionType get type;
  @override
  String get message;
  @override
  int? get code;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalExceptionImplCopyWith<_$LocalExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

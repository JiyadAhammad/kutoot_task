// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FeedItemModel _$FeedItemModelFromJson(Map<String, dynamic> json) {
  return _FeedItemModel.fromJson(json);
}

/// @nodoc
mixin _$FeedItemModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get thumbnailUrl => throw _privateConstructorUsedError;
  List<double> get chartData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedItemModelCopyWith<FeedItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedItemModelCopyWith<$Res> {
  factory $FeedItemModelCopyWith(
          FeedItemModel value, $Res Function(FeedItemModel) then) =
      _$FeedItemModelCopyWithImpl<$Res, FeedItemModel>;
  @useResult
  $Res call(
      {int id,
      String title,
      String url,
      String thumbnailUrl,
      List<double> chartData});
}

/// @nodoc
class _$FeedItemModelCopyWithImpl<$Res, $Val extends FeedItemModel>
    implements $FeedItemModelCopyWith<$Res> {
  _$FeedItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? thumbnailUrl = null,
    Object? chartData = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      chartData: null == chartData
          ? _value.chartData
          : chartData // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedItemModelImplCopyWith<$Res>
    implements $FeedItemModelCopyWith<$Res> {
  factory _$$FeedItemModelImplCopyWith(
          _$FeedItemModelImpl value, $Res Function(_$FeedItemModelImpl) then) =
      __$$FeedItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String url,
      String thumbnailUrl,
      List<double> chartData});
}

/// @nodoc
class __$$FeedItemModelImplCopyWithImpl<$Res>
    extends _$FeedItemModelCopyWithImpl<$Res, _$FeedItemModelImpl>
    implements _$$FeedItemModelImplCopyWith<$Res> {
  __$$FeedItemModelImplCopyWithImpl(
      _$FeedItemModelImpl _value, $Res Function(_$FeedItemModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? thumbnailUrl = null,
    Object? chartData = null,
  }) {
    return _then(_$FeedItemModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      chartData: null == chartData
          ? _value._chartData
          : chartData // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedItemModelImpl implements _FeedItemModel {
  const _$FeedItemModelImpl(
      {required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl,
      final List<double> chartData = const []})
      : _chartData = chartData;

  factory _$FeedItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedItemModelImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String url;
  @override
  final String thumbnailUrl;
  final List<double> _chartData;
  @override
  @JsonKey()
  List<double> get chartData {
    if (_chartData is EqualUnmodifiableListView) return _chartData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chartData);
  }

  @override
  String toString() {
    return 'FeedItemModel(id: $id, title: $title, url: $url, thumbnailUrl: $thumbnailUrl, chartData: $chartData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            const DeepCollectionEquality()
                .equals(other._chartData, _chartData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, url, thumbnailUrl,
      const DeepCollectionEquality().hash(_chartData));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedItemModelImplCopyWith<_$FeedItemModelImpl> get copyWith =>
      __$$FeedItemModelImplCopyWithImpl<_$FeedItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedItemModelImplToJson(
      this,
    );
  }
}

abstract class _FeedItemModel implements FeedItemModel {
  const factory _FeedItemModel(
      {required final int id,
      required final String title,
      required final String url,
      required final String thumbnailUrl,
      final List<double> chartData}) = _$FeedItemModelImpl;

  factory _FeedItemModel.fromJson(Map<String, dynamic> json) =
      _$FeedItemModelImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get url;
  @override
  String get thumbnailUrl;
  @override
  List<double> get chartData;
  @override
  @JsonKey(ignore: true)
  _$$FeedItemModelImplCopyWith<_$FeedItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

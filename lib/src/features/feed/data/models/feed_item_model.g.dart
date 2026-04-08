// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedItemModelImpl _$$FeedItemModelImplFromJson(Map<String, dynamic> json) =>
    _$FeedItemModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      chartData: (json['chartData'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$FeedItemModelImplToJson(_$FeedItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
      'chartData': instance.chartData,
    };

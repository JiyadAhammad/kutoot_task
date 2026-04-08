import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_item_model.freezed.dart';
part 'feed_item_model.g.dart';

@freezed
abstract class FeedItemModel with _$FeedItemModel {
  const factory FeedItemModel({
    required int id,
    required String title,
    required String url,
    required String thumbnailUrl,
    @Default([]) List<double> chartData, // Used for heavy CustomPainter rendering
  }) = _FeedItemModel;

  factory FeedItemModel.fromJson(Map<String, dynamic> json) => _$FeedItemModelFromJson(json);
}

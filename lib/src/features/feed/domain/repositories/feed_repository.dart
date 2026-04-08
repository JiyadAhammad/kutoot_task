import 'package:dio/dio.dart';
import 'package:my_app/src/features/feed/data/models/feed_item_model.dart';

abstract interface class FeedRepository {
  Future<List<FeedItemModel>> getFeedItems(
    int page,
    int limit,
    CancelToken cancelToken,
  );
}

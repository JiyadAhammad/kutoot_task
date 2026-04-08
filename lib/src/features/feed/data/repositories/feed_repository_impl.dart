import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import 'package:my_app/src/features/feed/data/models/feed_item_model.dart';
import 'package:my_app/src/features/feed/domain/repositories/feed_repository.dart';

import '../../../../core/utils/json_parser.dart';

String getImageUrl(int id) {
  return "https://picsum.photos/seed/$id/600/400";
}

List<FeedItemModel> parseFeedItems(String responseBody) {
  return parseList<FeedItemModel>(responseBody, (json) {
    final baseModel = FeedItemModel.fromJson(json);

    return baseModel.copyWith(
      url: getImageUrl(json['id']),
      chartData: List.generate(
        50,
        (index) => ((json['id'] as int) + index * 2.5) % 100,
      ),
    );
  });
}

class FeedRepositoryImpl implements FeedRepository {
  final Dio _dio;

  FeedRepositoryImpl(this._dio);

  @override
  Future<List<FeedItemModel>> getFeedItems(
    int page,
    int limit,
    CancelToken cancelToken,
  ) async {
    try {
      final response = await _dio.get(
        '/photos',
        queryParameters: {'_page': page, '_limit': limit},
        cancelToken: cancelToken,
        options: Options(responseType: ResponseType.plain),
      );

      return compute(parseFeedItems, response.data.toString());
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        debugPrint('Request cancelled: ${e.message}');
        return [];
      }
      rethrow;
    }
  }
}

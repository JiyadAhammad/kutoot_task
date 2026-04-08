part of 'feed_bloc.dart';

@freezed
class FeedState with _$FeedState {
  const factory FeedState.initial() = _Initial;
  const factory FeedState.loading() = _Loading;
  const factory FeedState.loaded({
    required List<FeedItemModel> items,
    required bool hasReachedMax,
    required int currentPage,
  }) = _Loaded;
  const factory FeedState.error(String message) = _Error;
}

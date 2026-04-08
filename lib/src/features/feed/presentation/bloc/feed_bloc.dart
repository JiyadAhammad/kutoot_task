import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';
import 'package:my_app/src/features/feed/data/models/feed_item_model.dart';
import 'package:my_app/src/features/feed/domain/repositories/feed_repository.dart';

part 'feed_bloc.freezed.dart';
part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository _repository;
  CancelToken? _cancelToken;

  FeedBloc(this._repository) : super(const FeedState.initial()) {
    on<_Started>(_onStarted);
    on<_LoadMore>(_onLoadMore);
    on<_CancelRequests>(_onCancelRequests);
  }

  Future<void> _onStarted(_Started event, Emitter<FeedState> emit) async {
    emit(const FeedState.loading());
    try {
      _cancelToken = CancelToken();
      final items = await _repository.getFeedItems(1, 20, _cancelToken!);
      emit(
        FeedState.loaded(items: items, hasReachedMax: false, currentPage: 1),
      );
    } catch (e) {
      if (e is DioException && CancelToken.isCancel(e)) return;
      emit(FeedState.error(e.toString()));
    }
  }

  Future<void> _onLoadMore(_LoadMore event, Emitter<FeedState> emit) async {
    final currentState = state;
    if (currentState is _Loaded) {
      if (currentState.hasReachedMax) return;

      try {
        if (_cancelToken != null && !_cancelToken!.isCancelled) {
          _cancelToken!.cancel("New Load more");
        }
        _cancelToken = CancelToken();
        final nextPage = currentState.currentPage + 1;
        final newItems = await _repository.getFeedItems(
          nextPage,
          20,
          _cancelToken!,
        );

        if (newItems.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          emit(
            FeedState.loaded(
              items: List.of(currentState.items)..addAll(newItems),
              hasReachedMax: false,
              currentPage: nextPage,
            ),
          );
        }
      } catch (e) {
        if (e is DioException && CancelToken.isCancel(e)) return;
        debugPrint("Load more failed: $e");
      }
    }
  }

  void _onCancelRequests(_CancelRequests event, Emitter<FeedState> emit) {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel("Cancelled due to rapid scrolling");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../data/models/feed_item_model.dart';
import '../bloc/feed_bloc.dart';
import '../widgets/feed_shimmer.dart';
import '../widgets/market_chart.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<FeedBloc>().add(const FeedEvent.started());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<FeedBloc>().add(const FeedEvent.loadMore());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Infinite Canvas')),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => ListView.builder(
              itemCount: 6,
              itemBuilder: (_, int index) => const FeedItemShimmer(),
            ),
            error: (message) => Center(child: Text(message)),
            loaded: (items, hasReachedMax, _) {
              if (items.isEmpty) {
                return const Center(child: Text('No items found'));
              }

              return ListView.builder(
                controller: _scrollController,
                itemCount: items.length + (hasReachedMax ? 0 : 1),
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                itemBuilder: (context, index) {
                  if (index >= items.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  return _FeedItemWidget(item: items[index], index: index);
                },
              );
            },
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }
}

class _FeedItemWidget extends StatelessWidget {
  final FeedItemModel item;
  final int index;

  const _FeedItemWidget({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RepaintBoundary(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 200,
                  child: CachedNetworkImage(
                    imageUrl: item.url,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            RepaintBoundary(
              child: Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomPaint(
                  painter: MarketChartPainter(item.chartData, index),
                  size: const Size.fromHeight(100),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

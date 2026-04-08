import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeedItemShimmer extends StatelessWidget {
  const FeedItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image shimmer
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Container(height: 200, color: Colors.white),
              ),

              // Title shimmer
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      height: 14,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: MediaQuery.of(context).size.width * 0.6,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              // Chart shimmer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(height: 100, color: Colors.white),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

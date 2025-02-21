
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => _buildShimmerItem(),
    );
  }

  Widget _buildShimmerItem() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
        child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circle avatar placeholder
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            // Content placeholder
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title placeholder
                  Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  // Author placeholder
                  Container(
                    height: 12,
                    width: 150,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  // Date placeholder
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 12,
                      width: 80,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Chevron placeholder
            Container(
              width: 32,
              height: 32,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ));
  }
}
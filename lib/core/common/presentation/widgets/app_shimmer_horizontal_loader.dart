import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmerHorizontalLoader extends StatelessWidget {
  final double height;
  final double width;
  final int itemCount;
  final bool isCircular;
  final bool isRounded;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;

  const AppShimmerHorizontalLoader({
    super.key,
    required this.height,
    required this.width,
    this.itemCount = 5,
    this.isCircular = true,
    this.isRounded = false,
    this.borderRadius = 0.0,
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: height,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius:
                  isRounded ? BorderRadius.circular(borderRadius) : null,
            ),
            child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius:
                      isRounded ? BorderRadius.circular(borderRadius) : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

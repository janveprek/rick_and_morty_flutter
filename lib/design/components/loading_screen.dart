import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CharacterShimmerList extends StatelessWidget {
  static const int itemCount = 20;

  const CharacterShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: CharacterShimmerItem(),
        );
      },
    ));
  }
}

class CharacterShimmerItem extends StatelessWidget {
  const CharacterShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    const double iconSizeLarge = 60.0;
    const double cornerRadiusMedium = 10.0;
    const double paddingSmall = 8.0;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cornerRadiusMedium),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: iconSizeLarge,
            height: iconSizeLarge,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(cornerRadiusMedium),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingSmall),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ShimmerPlaceholder(height: 20.0, width: 100.0),
                  const SizedBox(height: 8.0),
                  ShimmerPlaceholder(height: 15.0, width: 50.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerPlaceholder extends StatelessWidget {
  final double width;
  final double height;

  ShimmerPlaceholder({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}

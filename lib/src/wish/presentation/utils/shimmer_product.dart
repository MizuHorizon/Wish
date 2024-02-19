import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wish/src/constants.dart';

class ShimmerProductItem extends StatefulWidget {
  @override
  State<ShimmerProductItem> createState() => _ShimmerProductItemState();
}

class _ShimmerProductItemState extends State<ShimmerProductItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.red,
        highlightColor: Colors.yellow,
        child: Text(
          'Shimmer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

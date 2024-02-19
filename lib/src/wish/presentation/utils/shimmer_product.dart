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
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.only(bottom: 5),
              height: 100,
              width: 200,
            ),
            Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: 25,
                    width: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: 25,
                    width: 40,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: 25,
                width: 200,
              ),
            ),
            const SizedBox(height: 5),
            Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: 25,
                    width: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: 25,
                    width: 40,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wish/src/constants.dart';

import 'package:wish/src/wish/presentation/utils/image_shimmer.dart';

class TrackedProduct extends StatefulWidget {
  String imageUrl;
  String name;
  final dynamic price;
  final List<String> tags;
  TrackedProduct({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.tags,
  }) : super(key: key);

  @override
  State<TrackedProduct> createState() => _TrackedProductState();
}

class _TrackedProductState extends State<TrackedProduct> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          width: size.width / 3,
          height: size.height / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              placeholder: (context, url) => const ImageShimmer(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            Text(
              widget.name,
              style: TextStyle(color: AppColors.appActiveColor),
            )
          ],
        )
      ],
    );
  }
}

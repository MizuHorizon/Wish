import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wish/src/constants.dart';

import 'package:wish/src/wish/presentation/utils/image_shimmer.dart';

class TrackedProductItem extends StatefulWidget {
  String imageUrl;
  String name;
  String productUrl;
  final dynamic price;
  final dynamic startPrice;
  final List<String> tags;
  TrackedProductItem(
      {Key? key,
      required this.productUrl,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.tags,
      required this.startPrice})
      : super(key: key);

  @override
  State<TrackedProductItem> createState() => _TrackedProductItemState();
}

class _TrackedProductItemState extends State<TrackedProductItem> {
  List<Widget> _genrateTags() {
    List<Widget> tags = [];

    for (var tag in widget.tags) {
      tags.add(
        Padding(
          padding: const EdgeInsets.only(right: 6, top: 3, bottom: 3),
          child: Container(
              height: 22,
              padding: const EdgeInsets.only(left: 4, right: 4, bottom: 2),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Text(
                tag,
                style: const TextStyle(color: Colors.grey),
              )),
        ),
      );
    }

    return tags;
  }

  Future<void> _launchUrl() async {
    print(widget.productUrl);
    final Uri _url = Uri.parse(widget.productUrl);
    if (!await launchUrl(_url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              width: size.width / 2.8,
              height: size.height / 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: widget.imageUrl,
                  placeholder: (context, url) => const ImageShimmer(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              top: 8, // Adjust the top position of the button
              right: 8, // Adjust the right position of the button
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.delete,
                  color: AppColors.appBackgroundColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: const TextStyle(
                  color: AppColors.appActiveColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Container(
                width: size.width / 1.7,
                child:
                    Wrap(runSpacing: 3, spacing: 3, children: _genrateTags())),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  "₹${widget.startPrice}",
                  style: const TextStyle(
                    color: AppColors.dividerColor,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.grey,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(width: 10),
                Text("₹${widget.price.toString()}",
                    style: const TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 17,
                        fontWeight: FontWeight.w500)),
                const SizedBox(width: 10),
                Text("(22:30)", style: TextStyle(color: Colors.grey)),
              ],
            ),
            Text(
              "Your product is being tracked",
              style: TextStyle(
                  fontWeight: FontWeight.w400, color: AppColors.appActiveColor),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    _launchUrl();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(255, 66, 63, 63),
                              Colors.black
                            ]),
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: Colors.grey)),
                    height: 25,
                    width: 70,
                    child: const Center(
                      child: Text(
                        "View",
                        style: TextStyle(color: AppColors.appActiveColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: Colors.grey)),
                    height: 25,
                    width: 70,
                    child: Center(
                      child: Text(
                        "Tracker",
                        style: TextStyle(color: AppColors.appActiveColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

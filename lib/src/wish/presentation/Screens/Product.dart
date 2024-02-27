import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/presentation/controllers/productController.dart';
import 'package:wish/src/wish/presentation/utils/custom_dialogueBox.dart';
import 'package:wish/src/wish/presentation/utils/delete_dialogueBox.dart';
import 'package:wish/src/wish/presentation/utils/image_shimmer.dart';

class ProductItem extends ConsumerStatefulWidget {
  final String name;
  final String imageUrl;
  final String productUrl;
  final dynamic price;
  final List<String> tags;
  final String productId;
  ProductItem(
      {super.key,
      required this.productId,
      required this.name,
      required this.imageUrl,
      required this.productUrl,
      required this.price,
      required this.tags});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductState();
}

class _ProductState extends ConsumerState<ProductItem> {
  Future<void> _launchUrl() async {
    print(widget.productUrl);
    final Uri _url = Uri.parse(widget.productUrl);
    if (!await launchUrl(_url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $_url');
    }
  }

  // void deleteProduct(WidgetRef ref, String productId) async {}

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

  @override
  Widget build(BuildContext context) {
    // final productController = ref.watch(productControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                placeholder: (context, url) => const ImageShimmer(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Positioned(
              top: 8, // Adjust the top position of the button
              right: 8, // Adjust the right position of the button
              child: InkWell(
                onTap: () {
                  showDeleteDialog(context, "Delete", "Are you sure?",
                      AppColors.appBackgroundColor, widget.productId);
                },
                child: Icon(Icons.delete),
              ),
            ),
          ],
        ),
        const SizedBox(height: 13),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              child: Text(widget.name,
                  style: const TextStyle(
                      color: AppColors.appActiveColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            Text(widget.price.toString(),
                style: const TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 20,
                    fontWeight: FontWeight.w500))
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
            spacing: 6, // Adjust as needed
            runSpacing: 3, // Adjust as needed
            alignment: WrapAlignment.start,
            children: _genrateTags()),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}

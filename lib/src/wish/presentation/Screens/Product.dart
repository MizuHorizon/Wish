import 'package:flutter/material.dart';
import 'package:wish/src/constants.dart';

class ProductItem extends StatefulWidget {
  final String name;
  final String imageUrl;
  final double price;
  final List<String> tags;

  ProductItem(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.tags});

  @override
  State<ProductItem> createState() => _ProductState();
}

class _ProductState extends State<ProductItem> {
  List<Widget> _genrateTags() {
    List<Widget> tags = [];

    for (var tag in widget.tags) {
      tags.add(
        Padding(
          padding: const EdgeInsets.only(right: 5, top: 3, bottom: 3),
          child: Container(
              height: 22,
              padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
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
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://m.media-amazon.com/images/W/MEDIAX_849526-T2/images/I/71jKYVUI6bL._SY695_.jpg', // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8, // Adjust the top position of the button
              right: 8, // Adjust the right position of the button
              child: InkWell(
                onTap: () {},
                child: Icon(Icons.delete),
              ),
            ),
          ],
        ),
        const SizedBox(height: 13),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Boots",
                style: TextStyle(
                    color: AppColors.appActiveColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
            Text("₹4542",
                style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 20,
                    fontWeight: FontWeight.w500))
          ],
        ),
        const SizedBox(height: 8),
        Wrap(runSpacing: 3, spacing: 3, children: _genrateTags()),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
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

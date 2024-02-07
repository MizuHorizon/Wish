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
        Wrap(
          spacing: 1, // Spacing between tags
          children: List.generate(
            widget.tags.length,
            (index) => Container(
              alignment: Alignment.center, // Center the content vertically
              child: Chip(
                label: Text(
                  widget.tags[index],
                  style: TextStyle(fontSize: 10), // Adjust font size as needed
                ),
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 8), // Adjust padding
                materialTapTargetSize: MaterialTapTargetSize
                    .shrinkWrap, // Make the tap target size smaller
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/presentation/Screens/Product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final List<String> items = List.generate(20, (index) => 'Item $index');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Container(
          child: RefreshIndicator(
            color: AppColors.appActiveColor,
            backgroundColor: AppColors.appBackgroundColor,
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));

              return null;
            },
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 30, // Spacing between columns
                mainAxisSpacing: 10, // Spacing between rows
                childAspectRatio: 0.5, // Adjust this ratio as needed
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  name: '',
                  imageUrl: '',
                  price: 78,
                  tags: ["tshirt", "myntra", "love"],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/product_model.dart';
import 'package:wish/src/wish/presentation/Screens/Product.dart';
import 'package:wish/src/wish/presentation/controllers/productController.dart';
import 'package:wish/src/wish/presentation/controllers/userController.dart';
import 'package:wish/src/wish/presentation/utils/shimmer_product.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  List<Product> items = [];

  void fetchProducts() async {
    setState(() {
      items = ref.read(productModelProvider.notifier).state ?? [];
      print("list is here $items");
    });
  }

  void refreshProducts() async {
    ref.read(productModelProvider.notifier).state =
        await ref.read(productControllerProvider.notifier).getAllProducts();
    setState(() {
      items = ref.watch(productModelProvider.notifier).state ?? [];
      print("refreshed list is here $items");
      isLoading = false;
    });
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productController = ref.watch(productControllerProvider);
    final refItems = ref.watch(productModelProvider.notifier).state ?? [];
    items = refItems;
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    //two sorting buttons
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(left: 4, right: 4),
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
                    height: 35,
                    child: const Center(
                      child: Text(
                        "+ Add Product",
                        style: TextStyle(color: AppColors.appActiveColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.34,
              child: RefreshIndicator(
                color: AppColors.appActiveColor,
                backgroundColor: AppColors.appBackgroundColor,
                onRefresh: () async {
                  setState(() {
                    isLoading = true;
                  });
                  //await Future.delayed(Duration(seconds: 3));
                  refreshProducts();
                },
                child: MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return productController.isLoading || isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(10),
                            child: ShimmerProductItem(),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProductItem(
                              name: '${items[index].name.substring(0, 12)}...',
                              imageUrl: items[index].photos[0],
                              price: "₹${items[index].startPrice}",
                              tags: items[index].tags,
                              productUrl: items[index].url,
                              productId: items[index].id,
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

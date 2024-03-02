import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/product_model.dart';
import 'package:wish/src/wish/presentation/Screens/Product.dart';
import 'package:wish/src/wish/presentation/controllers/productController.dart';
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

  String dropdownvalue = 'Platform';
  var dropitems = [
    'Platform',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    child: const Center(
                      child: Text(
                        "Recent",
                        style: TextStyle(
                            color: AppColors.appActiveColor, fontSize: 15),
                      ),
                    ),
                    width: 90,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 145, 148, 151),
                        border: Border.all(
                            color: AppColors.dividerColor, width: 1)),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 100,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.appBackgroundColor,
                        border: Border.all(
                            color: AppColors.dividerColor, width: 1)),
                    child: Center(
                      child: DropdownButton(
                        underline: Container(),
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: dropitems.map((String ditems) {
                          return DropdownMenuItem(
                            value: ditems,
                            child: Text(
                              ditems,
                              style: TextStyle(color: AppColors.appActiveColor),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
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

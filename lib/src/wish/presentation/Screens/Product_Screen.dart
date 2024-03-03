import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/product_model.dart';
import 'package:wish/src/wish/presentation/Screens/Product.dart';
import 'package:wish/src/wish/presentation/controllers/productController.dart';
import 'package:wish/src/wish/presentation/utils/dotted_line.dart';
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

  void sortProduct(String platform) {
    print(platform);
    platform = platform.toLowerCase();
    var products = ref.read(productModelProvider.notifier).state ?? [];
    print('products before $products');
    products.sort((a, b) {
      bool aHasTag = a.tags.contains(platform);
      bool bHasTag = b.tags.contains(platform);

      if (aHasTag && !bHasTag) {
        return -1;
      } else if (!aHasTag && bHasTag) {
        return 1;
      } else {
        return 0;
      }
    });

    ref.read(productModelProvider.notifier).state = products;
    print('products after $products');
  }

  void refreshProducts() async {
    ref.read(productModelProvider.notifier).state =
        await ref.read(productControllerProvider.notifier).getAllProducts();
    setState(() {
      items = ref.watch(productModelProvider.notifier).state ?? [];
      print("refreshed list is here $items");
      isLoading = false;
      dropdownvalue = "";
    });
  }

  String dropdownvalue = "";
  var dropitems = [
    'Ajio',
    'Amazon',
    'Flipkart',
    'Myntra',
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
            Row(
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
                      border:
                          Border.all(color: AppColors.dividerColor, width: 1)),
                ),
                const SizedBox(width: 10),
                Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: AppColors.appBackgroundColor,
                            border: Border.all(
                                color: AppColors.dividerColor, width: 1)),
                        offset: const Offset(-10, -1),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility: MaterialStateProperty.all(true),
                        ),
                      ),
                      buttonStyleData: ButtonStyleData(
                        height: 32,
                        width: 120,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.dividerColor,
                          ),
                        ),
                        elevation: 2,
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Platform',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.appActiveColor,
                        ),
                      ),
                      items: dropitems
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: dropdownvalue.isEmpty ? null : dropdownvalue,
                      onChanged: (String? value) {
                        setState(() {
                          dropdownvalue = value!;
                        });
                        sortProduct(dropdownvalue);
                      },
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
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

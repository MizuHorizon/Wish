import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/product_model.dart';
import 'package:wish/src/wish/presentation/controllers/productController.dart';
import 'package:wish/src/wish/presentation/utils/tracked_product.dart';

class TrackedProducts extends ConsumerStatefulWidget {
  const TrackedProducts({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TrackedProductsState();
}

class _TrackedProductsState extends ConsumerState<TrackedProducts> {
  List<Product> trackedPrroducts = [];
  void getTrackedProducts() {
    List<Product> allProducts =
        ref.read(productModelProvider.notifier).state ?? [];
    if (allProducts.isNotEmpty) {
      allProducts.forEach((product) {
        if (product.tracker == true) {
          trackedPrroducts.add(product);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Products (4/5)",
                        style: TextStyle(
                            color: AppColors.appActiveColor, fontSize: 20),
                      ),
                      Text(
                        "list of your current products",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColors.appActiveColor),
                      )
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      width: size.width / 2.5,
                      height: size.height / 18,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey.shade800,
                                Colors.black,
                                Colors.black,
                                Colors.black,
                                Colors.grey.shade800
                              ]),
                          border: Border.all(color: Colors.grey, width: 2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: SvgPicture.asset(
                              'assets/icons/f-icon.svg',
                              width: 30.0,
                              height: 30.0,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "Upgrade",
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.appActiveColor,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                width: size.width,
                height: size.height / 1.46,
                child: RefreshIndicator(
                  color: AppColors.appActiveColor,
                  backgroundColor: AppColors.appBackgroundColor,
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 3));
                    return null;
                  },
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return TrackedProduct(
                        name: "Watch...",
                        imageUrl:
                            'https://m.media-amazon.com/images/I/61ybeKQto8L._SY500_.jpg',
                        price: null,
                        tags: [
                          "tshirt",
                          "myntra",
                          "love",
                          "ok",
                          "shirt thsirt"
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/product_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static const String routeName = "profile-route";
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  int totalProducts = 0;
  int trackedProducts = 0;

  void getProductFromProviders() {
    List<Product> _allProducts =
        ref.read(productModelProvider.notifier).state ?? [];
    for (var i = 0; i < _allProducts.length; i++) {
      if (_allProducts[i].tracker == true) {
        trackedProducts += 1;
      }
    }
    setState(() {
      totalProducts = _allProducts.length;
    });
  }

  String toTitleCase(String text) {
    if (text == null || text.isEmpty) {
      return text;
    }

    return text.toLowerCase().split(' ').map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  List<Widget> generateProductCount(double width) {
    List<Product> _allProducts =
        ref.read(productModelProvider.notifier).state ?? [];
    Map<String, int> productCount = {};
    for (var i = 0; i < _allProducts.length; i++) {
      var company = _allProducts[i].company;
      productCount[company] = (productCount[company] ?? 0) + 1;
    }

    List<Widget> productRow = [];
    productCount.forEach((company, count) {
      print('Company: $company, Product Count: $count');

      productRow.add(Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${toTitleCase(company)} products",
                  style: const TextStyle(
                      color: AppColors.appActiveColor, fontSize: 17),
                ),
                const SizedBox(height: 8),
                Container(
                  width: width / 1.09,
                  height: 38,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          // stops: [0.0, 0.5, 1.0],
                          transform: GradientRotation(45 * (pi / 180)),
                          colors: [
                            Color(0xFF6D7178),
                            AppColors.appBackgroundColor,
                            AppColors.appBackgroundColor,
                            Color(0xFF6D7178),
                          ]),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.dividerColor,
                        width: 1,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      Center(
                        child: Text(
                          "$count",
                          style: const TextStyle(
                              fontSize: 18, color: AppColors.appActiveColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          )
        ],
      ));
    });

    return productRow;
  }

  @override
  void initState() {
    super.initState();
    getProductFromProviders();
    generateProductCount(0);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.appBackgroundColor,
          centerTitle: true,
          leading: SizedBox(
            height: 30,
            width: 30,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/send-square.svg',
                width: 30.0,
                height: 30.0,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ),
          title: const Text(
            "Profile",
            style: TextStyle(color: AppColors.appActiveColor),
          ),
        ),
        body: Column(
          children: [
            const Divider(
              thickness: 0.7,
              color: AppColors.dividerColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Products",
                        style: TextStyle(
                            color: AppColors.appActiveColor, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: size.width / 2.5,
                        height: 38,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                // stops: [0.0, 0.5, 1.0],
                                transform: GradientRotation(45 * (pi / 180)),
                                colors: [
                                  Color(0xFF6D7178),
                                  AppColors.appBackgroundColor,
                                  AppColors.appBackgroundColor,
                                  Color(0xFF6D7178),
                                ]),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.dividerColor,
                              width: 1,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20),
                            Center(
                              child: Text(
                                "$totalProducts",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: AppColors.appActiveColor),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tracked Products",
                        style: TextStyle(
                            color: AppColors.appActiveColor, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Container(
                          width: size.width / 2.5,
                          height: 38,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  // stops: [0.0, 0.5, 1.0],
                                  transform: GradientRotation(45 * (pi / 180)),
                                  colors: [
                                    Color(0xFF6D7178),
                                    AppColors.appBackgroundColor,
                                    AppColors.appBackgroundColor,
                                    Color(0xFF6D7178),
                                  ]),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.dividerColor,
                                width: 1,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 20),
                              Center(
                                child: Text(
                                  "$trackedProducts",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: AppColors.appActiveColor),
                                ),
                              ),
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Products from different platforms",
              style: TextStyle(
                  fontSize: 22,
                  color: AppColors.appActiveColor,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            ...generateProductCount(size.width),
          ],
        ));
  }
}

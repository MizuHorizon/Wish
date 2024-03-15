import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish/src/constants.dart';

import 'package:wish/src/wish/models/product_model.dart';
import 'package:wish/src/wish/presentation/Screens/NoProduct_Screen.dart';
import 'package:wish/src/wish/presentation/Screens/search_product.dart';
import 'package:wish/src/wish/presentation/Screens/track_graph_screen.dart';
import 'package:wish/src/wish/presentation/utils/components/custom_dialogueBox.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.black, fontSize: 20),
      ),
      primaryColor: AppColors.appActiveColor,
      indicatorColor: Colors.white,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: AppColors.appActiveColor),
      scaffoldBackgroundColor: AppColors.appBackgroundColor,
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: AppColors.dividerColor),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.appActiveColor),
        ),
      ),
      appBarTheme: const AppBarTheme(
          color: Colors.black, surfaceTintColor: AppColors.appActiveColor),
    );
  }

  final List<Product> products;
  List<Product> suggestions = [];

  DataSearch({
    required this.products,
  }) {
    print(products);
    int productSize = products.length;
    if (products.length >= 3) {
      suggestions = products.sublist(productSize - 3, productSize);
    } else {
      suggestions = List.from(
          products); // If there are less than 3 products, just copy the whole list.
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(
            Icons.clear,
            color: AppColors.appActiveColor,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: AnimatedIcon(
          color: AppColors.appActiveColor,
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? suggestions
        : products.where((element) {
            final lowerCaseQuery = query.toLowerCase();
            final nameMatch =
                element.name.toLowerCase().startsWith(lowerCaseQuery);
            final tagMatch = element.tags.contains(lowerCaseQuery);
            final priceMatch = element.prices
                .any((price) => price.toString().startsWith(lowerCaseQuery));
            return nameMatch || tagMatch || priceMatch;
          }).toList();

    return suggestionList.isEmpty
        ? NoProductScreen()
        : Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                const Divider(
                  thickness: 0.7,
                  color: AppColors.dividerColor,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: suggestionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 5, left: 5, right: 5),
                        child: Consumer(builder: (context, ref, child) {
                          return SearchProductItem(
                            tracker: () {
                              FocusScope.of(context).unfocus();
                              var clickedProduct = suggestionList[index];
                              if (clickedProduct.tracker == true) {
                                Navigator.pushNamed(
                                    context, TrackProductScreen.routeName,
                                    arguments: {
                                      'name': clickedProduct.name,
                                      "desiredPrice":
                                          clickedProduct.desiredPrice,
                                      'prices': clickedProduct.prices,
                                      'productUrl': clickedProduct.url,
                                      'productId': clickedProduct.id
                                    });
                              } else {
                                showGradientDialog(
                                    context,
                                    "Tracker",
                                    "This product is not being Tracked. \n please turn of the tracker...",
                                    AppColors.appActiveColor);
                              }
                            },
                            view: () {
                              FocusScope.of(context).unfocus();
                              var clickedProduct = suggestionList[index];
                              products.removeWhere(
                                  (element) => element.id == clickedProduct.id);
                              products.insert(0, clickedProduct);

                              ref
                                  .watch(productModelProvider.notifier)
                                  .update((state) => products);
                              Navigator.of(context).pop();
                            },
                            name:
                                '${suggestionList[index].name.substring(0, 20)}...' ??
                                    "",
                            imageUrl: suggestionList[index].photos[0] ?? "",
                            price: "${suggestionList[index].prices.last}" ?? "",
                            tags: suggestionList[index].tags ?? [],
                            productUrl: suggestionList[index].url ?? " ",
                          );
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}

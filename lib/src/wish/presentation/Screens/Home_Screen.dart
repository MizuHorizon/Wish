import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/product_model.dart';
import 'package:wish/src/wish/presentation/Screens/Product_Screen.dart';
import 'package:wish/src/wish/presentation/Screens/Tracker_Product_Screen.dart';
import 'package:wish/src/wish/presentation/controllers/productController.dart';
import 'package:wish/src/wish/presentation/controllers/userController.dart';
import 'package:wish/src/wish/presentation/utils/homepage_drawer.dart';
import 'package:wish/src/wish/presentation/utils/input_textfield.dart';
import 'package:wish/src/wish/presentation/utils/rectangular_indicator.dart';
import 'package:wish/src/wish/presentation/utils/search_delegate.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = "/home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  bool get wantKeepAlive => true;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  bool isValidUrl(String url) {
    // Regular expression pattern to match URLs
    // This pattern is quite simple and may not cover all edge cases, you might need to adjust it based on your requirements
    // This pattern checks for URLs starting with http:// or https:// followed by domain and optional path
    RegExp urlRegExp = RegExp(
      r"^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$",
      caseSensitive: false,
      multiLine: false,
    );

    return urlRegExp.hasMatch(url);
  }

  TextEditingController urlController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  List<Widget> tags = [];
  List<String> productTags = [];
  bool trackable = false;
  bool showDesiredPrice = false;
  bool emptyUrl = false;
  bool emptyDesiredPrice = false;
  bool notValidUrl = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      drawer: HomePageDrawer(context, _selectedIndex, _onItemTapped),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              final List<Product> products =
                  ref.watch(productModelProvider.notifier).state ?? [];
              showSearch(
                context: context,
                delegate: DataSearch(products: products),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          const Divider(
            thickness: 0.7,
            color: AppColors.dividerColor,
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              width: 234,
              height: 35,
              decoration: BoxDecoration(
                color: AppColors.appActiveColor,
                border: Border.all(color: AppColors.dividerColor, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                labelColor: AppColors.appActiveColor,
                indicatorColor: const Color.fromRGBO(4, 2, 46, 1),
                indicator: RectangularIndicator(
                  topRightRadius: 20,
                  topLeftRadius: 20,
                  bottomRightRadius: 20,
                  bottomLeftRadius: 20,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.grey,
                controller: tabController,
                tabs: const [
                  Text('All Products'),
                  Text('Tracked'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                ProductScreen(),
                TrackedProducts(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Positioned(
          top: MediaQuery.of(context).size.height / 2 - 30,
          left: 10,
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter mystate) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          height: size.height / 1.5,
                          decoration: const BoxDecoration(
                            color: Colors.black87,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                const Center(
                                  child: Text(
                                    "Add Product",
                                    style: TextStyle(
                                        color: AppColors.appActiveColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                const Divider(
                                  thickness: 2,
                                  indent: 80,
                                  endIndent: 80,
                                  color: AppColors.appActiveColor,
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Enter the Url",
                                      style: TextStyle(
                                          color: AppColors.appActiveColor,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    InputWishTextField(
                                        controller: urlController,
                                        hintText: "Url",
                                        isNumerInput: false,
                                        isPassword: false),
                                    if (emptyUrl) ...[
                                      Text("Url cant be empty",
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                    if (notValidUrl) ...[
                                      Text(
                                          "Not Valid Url!!!, Please check the url",
                                          style: TextStyle(color: Colors.red)),
                                    ]
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Description",
                                      style: TextStyle(
                                          color: AppColors.appActiveColor,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    InputWishTextField(
                                        controller: descController,
                                        hintText: "description",
                                        isNumerInput: false,
                                        isPassword: false),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Trackable",
                                      style: TextStyle(
                                          color: AppColors.appActiveColor,
                                          fontSize: 15),
                                    ),
                                    Switch(
                                      // thumb color (round icon)
                                      activeColor: AppColors.appBackgroundColor,
                                      activeTrackColor: Colors.grey,
                                      inactiveThumbColor:
                                          Colors.blueGrey.shade600,
                                      inactiveTrackColor: Colors.grey.shade400,
                                      splashRadius: 50.0,
                                      // boolean variable value
                                      value: trackable,
                                      // changes the state of the switch
                                      onChanged: (value) => mystate(() {
                                        trackable = value;
                                        showDesiredPrice = !showDesiredPrice;
                                        emptyDesiredPrice = false;
                                      }),
                                    )
                                  ],
                                ),
                                if (showDesiredPrice) ...[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Desired Price at which you want to get notified",
                                        style: TextStyle(
                                            color: AppColors.appActiveColor,
                                            fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InputWishTextField(
                                        controller: priceController,
                                        hintText: "price",
                                        isNumerInput: true,
                                        isPassword: false,
                                      ),
                                    ],
                                  ),
                                ],
                                const SizedBox(height: 8),
                                Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Tags",
                                            style: TextStyle(
                                                color: AppColors.appActiveColor,
                                                fontSize: 15),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            height: 50,
                                            width: 100,
                                            child: TextField(
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration: const InputDecoration(
                                                hintText: "tags...",

                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w300),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 20.0),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .appActiveColor,
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .appActiveColor,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                ),
                                                filled: true,
                                                fillColor: AppColors
                                                    .appBackgroundColor,
                                                // Set text color of entered text
                                              ),
                                              controller: tagController,
                                              onChanged: (value) {
                                                if (value.endsWith(" ")) {
                                                  final tag = value.trim();
                                                  if (tag.isNotEmpty) {
                                                    mystate(() {
                                                      productTags.add(tag);
                                                      tags.add(
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 6,
                                                                  top: 3,
                                                                  bottom: 3),
                                                          child: Container(
                                                              height: 30,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                      bottom:
                                                                          2),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white)),
                                                              child: Center(
                                                                child: Text(
                                                                  tag,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              )),
                                                        ),
                                                      );
                                                    });
                                                  }
                                                  tagController.clear();
                                                }
                                              },
                                            ),
                                          )
                                        ]),
                                    if (emptyDesiredPrice) ...[
                                      Text("Desired Price Cant be empty!!!",
                                          style: TextStyle(color: Colors.red)),
                                    ]
                                  ],
                                ),
                                const SizedBox(height: 10),
                                if (tags.isNotEmpty) ...[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: tags),
                                ],
                                const SizedBox(height: 0),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (urlController.text.trim().isEmpty) {
                                        mystate(() {
                                          emptyUrl = true;
                                          notValidUrl = false;
                                        });
                                      } else if (!isValidUrl(
                                          urlController.text.trim())) {
                                        mystate(() {
                                          notValidUrl = true;
                                          emptyUrl = false;
                                        });
                                      } else if (showDesiredPrice == true &&
                                          priceController.text.trim().isEmpty) {
                                        mystate(() {
                                          emptyDesiredPrice = true;
                                        });
                                      } else {
                                        print(
                                            "${urlController.text.trim()}, ${trackable} ,${descController.text.trim()},${productTags} ,${priceController.text.trim()}");
                                        double price;

                                        if (priceController.text
                                            .trim()
                                            .isEmpty) {
                                          // Handle the case where no price is entered
                                          // For example, you can assign a default value of 0 or display a message to the user
                                          price = 0;
                                        } else {
                                          try {
                                            price = double.parse(
                                                priceController.text.trim());
                                          } catch (e) {
                                            // Handle the parsing error gracefully
                                            print("Error parsing price: $e");
                                            // You can choose to assign a default value or handle the error in any other appropriate way
                                            price = 0;
                                          }
                                        }
                                        print(productTags);
                                        ref
                                            .read(productControllerProvider
                                                .notifier)
                                            .addProduct(
                                                urlController.text.trim(),
                                                trackable,
                                                descController.text.trim(),
                                                productTags,
                                                price)
                                            .then((value) =>
                                                {productTags.clear()});
                                        mystate(() {
                                          emptyUrl = false;
                                          notValidUrl = false;
                                          emptyDesiredPrice = false;
                                          tags.clear();
                                          descController.clear();
                                          urlController.clear();
                                          priceController.clear();
                                        });
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: Container(
                                      height: 65,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.appBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color: AppColors.dividerColor,
                                            width: 1.5),
                                      ),
                                      child: const Center(
                                        child: Center(
                                          child: Text(
                                            "Add",
                                            style: TextStyle(
                                                color: AppColors.appActiveColor,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  });
            },
            elevation: 2.0, // Adjust elevation if needed
            shape: CircleBorder(), // Make the button round
            child: Container(
              width: 58.0,
              height: 58.0,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.dividerColor),
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.centerRight,
                    colors: [Color.fromARGB(255, 66, 63, 63), Colors.black]),
              ),
              child: Icon(Icons.add, color: Colors.white), // Add your icon here
            ),
          )),
    );
  }
}

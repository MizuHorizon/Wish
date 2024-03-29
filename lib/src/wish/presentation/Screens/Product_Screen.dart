import "package:wish/src/exports.dart";

class ProductScreen extends ConsumerStatefulWidget {
  TabController tabController;
  ProductScreen({super.key, required this.tabController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  List<Product> items = [];
  var dropitems = [
    'ajio',
  ];
  void fetchProducts() async {
    setState(() {
      items = ref.read(productModelProvider.notifier).state ?? [];
      for (int i = 0; i < items.length; i++) {
        if (!dropitems.contains(items[i].tags.last)) {
          dropitems.add(items[i].tags.last);
        }
      }

      print("list is here $items");
    });
  }

  bool extractCompany(String url) {
    List<String> supportedCompany = [
      "ajio",
      "snitch",
      "bewakoof",
      "bonkerscorner"
    ];

    RegExp domainRegExp =
        RegExp(r"(?:https?:\/\/)?(?:www\.)?([a-zA-Z0-9-]+)\.");

    // Extract domain name from URL using RegExp
    Match? match = domainRegExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      String host = match.group(1)!;

      String company = host.toLowerCase();
      print(company);

      if (supportedCompany.contains(company)) return true;
      return false;
    }
    return false;
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

  String dropdownvalue = "";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // print("fetched product");
    fetchProducts();
    print("fetched product2");
  }

  @override
  Widget build(BuildContext context) {
    final productController = ref.watch(productControllerProvider);
    final refItems = ref.watch(productModelProvider.notifier).state ?? [];
    items = refItems;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            try {
              showAddProductBottomSheet(context, size);
            } catch (e) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ErrorScreen(
                  error: "$e",
                ),
              ));
            }
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
        ),
        body: RefreshIndicator(
          color: AppColors.appActiveColor,
          backgroundColor: AppColors.appBackgroundColor,
          onRefresh: () async {
            setState(() {
              isLoading = true;
            });
            //await Future.delayed(Duration(seconds: 3));
            refreshProducts();
          },
          child: items.isEmpty
              ? EmptyProductScreen()
              : Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 90,
                            height: 32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 145, 148, 151),
                                border: Border.all(
                                    color: AppColors.dividerColor, width: 1)),
                            child: const Center(
                              child: Text(
                                "Recent",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: AppColors.appActiveColor,
                                    fontSize: 15),
                              ),
                            ),
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
                                          color: AppColors.dividerColor,
                                          width: 1)),
                                  offset: const Offset(-10, -1),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness: MaterialStateProperty.all(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all(true),
                                  ),
                                ),
                                buttonStyleData: ButtonStyleData(
                                  height: 32,
                                  width: 120,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
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
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: dropdownvalue.isEmpty
                                    ? null
                                    : dropdownvalue,
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
                        padding: const EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.34,
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
                                      tabController: widget.tabController,
                                      trackable: items[index].tracker ?? false,
                                      name: (items[index].name.length > 9)
                                          ? '${items[index].name.substring(0, 9)}...'
                                          : '${items[index].name}...',
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
                    ],
                  ),
                ),
        ));
  }

  Future<dynamic> showAddProductBottomSheet(BuildContext context, Size size) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return StatefulBuilder(
              builder: (BuildContext ctx2, StateSetter mystate) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(ctx2).viewInsets.bottom),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  height: size.height / 1.4,
                  decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 65, 67, 70), // Top color
                          Color.fromARGB(255, 12, 14, 12),
                          Colors.black, // Bottom color
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Add Product",
                          style: TextStyle(
                              color: AppColors.appActiveColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Paste your product url. Copy the product URL by \nselecting the share option on the product and paste it \nhere",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.appActiveColor,
                                  fontSize: 13),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            InputWishTextField(
                                fillColour: Colors.transparent,
                                borderColour: AppColors.dividerColor,
                                controller: urlController,
                                hintText: "Paste URL",
                                isNumerInput: false,
                                isPassword: false),
                            if (emptyUrl) ...[
                              Text("Url cant be empty",
                                  style: TextStyle(color: Colors.red)),
                            ],
                            if (notValidUrl) ...[
                              Text("Not Valid Url!!!, Please check the url",
                                  style: TextStyle(color: Colors.red)),
                            ]
                          ],
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            InputWishTextField(
                                fillColour: Colors.transparent,
                                borderColour: AppColors.dividerColor,
                                controller: descController,
                                hintText: "description",
                                isNumerInput: false,
                                isPassword: false),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Trackable",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 132, 125, 125),
                                  fontSize: 15),
                            ),
                            Switch(
                              // thumb color (round icon)
                              activeColor: Colors.green.shade100,
                              activeTrackColor: Colors.green,
                              inactiveThumbColor: Colors.blueGrey.shade600,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Desired Price at which you want to get notified",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.appActiveColor,
                                    fontSize: 13),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              InputWishTextField(
                                fillColour: Colors.transparent,
                                borderColour: AppColors.dividerColor,
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
                            Container(
                              height: 50,
                              width: size.width,
                              child: TextField(
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    hintText: "Enter tags...",
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.dividerColor,
                                          width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.appActiveColor,
                                          width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    filled: true,
                                    fillColor: Colors.transparent
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
                                            padding: const EdgeInsets.only(
                                                right: 6, top: 3, bottom: 3),
                                            child: Container(
                                                height: 25,
                                                padding: const EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    bottom: 2),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white)),
                                                child: Center(
                                                  child: Text(
                                                    tag,
                                                    style: const TextStyle(
                                                        color: Colors.grey),
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
                            ),
                            if (emptyDesiredPrice) ...[
                              Text("Desired Price Cant be empty!!!",
                                  style: TextStyle(color: Colors.red)),
                            ]
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (tags.isNotEmpty) ...[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: tags),
                        ],
                        const SizedBox(height: 0),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: MaterialButton(
                            onPressed: () async {
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
                              } else if (!extractCompany(
                                  urlController.text.trim())) {
                                showGradientDialog(
                                    context,
                                    "Not Supported",
                                    "Sorry! Currently we dont support this company!!",
                                    Colors.red);
                                mystate(() {
                                  emptyUrl = false;
                                  notValidUrl = false;
                                  emptyDesiredPrice = false;
                                  tags.clear();
                                  descController.clear();
                                  urlController.clear();
                                  priceController.clear();
                                });
                              } else {
                                // print(
                                //     "${urlController.text.trim()}, ${trackable} ,${descController.text.trim()},${productTags} ,${priceController.text.trim()}");
                                double price;

                                if (priceController.text.trim().isEmpty) {
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

                                ref
                                    .read(productControllerProvider.notifier)
                                    .addProduct(
                                        urlController.text.trim(),
                                        trackable,
                                        descController.text.trim(),
                                        productTags,
                                        price)
                                    .then((value) {
                                  showConfirmationDialog(
                                      context, "", "", Colors.black);
                                  productTags.clear();
                                });
                                mystate(() {
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
                                gradient: const RadialGradient(
                                    center: Alignment(-0, 2),
                                    radius: 2.3,
                                    colors: [
                                      Color.fromARGB(255, 66, 61, 61),
                                      Colors.black,
                                    ]),
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: AppColors.dividerColor, width: 1.5),
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
              ),
            );
          });
        });
  }
}

import "package:wish/src/exports.dart";
import "package:wish/src/wish/presentation/Screens/comingSoon_screen.dart";

class TrackedProducts extends ConsumerStatefulWidget {
  TabController tabController;
  TrackedProducts({super.key, required this.tabController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TrackedProductsState();
}

class _TrackedProductsState extends ConsumerState<TrackedProducts> {
  List<Product> trackedPrroducts = [];
  bool isLoading = false;
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

    print("this is the tracked product $trackedPrroducts");
  }

  void refreshProducts() async {
    ref.read(productModelProvider.notifier).state =
        await ref.read(productControllerProvider.notifier).getAllProducts();
    List<Product> allProducts =
        ref.read(productModelProvider.notifier).state ?? [];
    List<Product> refreshedTrackedProducts = [];
    if (allProducts.isNotEmpty) {
      allProducts.forEach((product) {
        if (product.tracker == true) {
          refreshedTrackedProducts.add(product);
        }
      });
    }
    setState(() {
      trackedPrroducts = refreshedTrackedProducts;
      print("refreshed list is here $trackedPrroducts");
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrackedProducts();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final productController = ref.watch(productControllerProvider);

    if (productController.isLoading ||
        productController.isReloading ||
        productController.isRefreshing) {
      refreshProducts();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        body: trackedPrroducts.isEmpty
            ? EmptyTrackedProductScreen(
                tabController: widget.tabController,
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 3, bottom: 3),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Products (${trackedPrroducts.length}/5)",
                                style: const TextStyle(
                                    color: AppColors.appActiveColor,
                                    fontSize: 20),
                              ),
                              const Text(
                                "list of your current products",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.appActiveColor),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ComingSoonScreen.routeName);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              height: 42,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      transform:
                                          GradientRotation(45 * (pi / 180)),
                                      colors: [
                                        Color(0xFF6D7178),
                                        AppColors.appBackgroundColor,
                                        Color(0xFF6D7178),
                                      ]),
                                  border:
                                      Border.all(color: Colors.grey, width: 2)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 32,
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
                                      fontSize: 18,
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
                      const SizedBox(height: 10),
                      Container(
                        width: size.width,
                        height: size.height / 1.38,
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
                          child: ListView.builder(
                            itemCount: trackedPrroducts.length,
                            itemBuilder: (BuildContext context, int index) {
                              var kprice = jsonDecode(
                                  trackedPrroducts[index].prices.last)['price'];
                              var startPrice = jsonDecode(
                                  trackedPrroducts[index].prices[0])['price'];
                              print(kprice);
                              return productController.isLoading || isLoading
                                  ? const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: ShimmerTrackProduct(),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: TrackedProductItem(
                                          productId: trackedPrroducts[index].id,
                                          desiredPrice: trackedPrroducts[index]
                                                  .desiredPrice ??
                                              '0',
                                          name:
                                              '${trackedPrroducts[index].name}',
                                          imageUrl:
                                              trackedPrroducts[index].photos[0],
                                          price: "$kprice",
                                          startPrice: "$startPrice",
                                          tags: trackedPrroducts[index].tags,
                                          productUrl:
                                              trackedPrroducts[index].url,
                                          priceList:
                                              trackedPrroducts[index].prices),
                                    );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

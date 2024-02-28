import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/product_model.dart';
import 'package:wish/src/wish/presentation/Screens/Product_Screen.dart';
import 'package:wish/src/wish/presentation/Screens/Tracker_Product_Screen.dart';
import 'package:wish/src/wish/presentation/controllers/productController.dart';
import 'package:wish/src/wish/presentation/controllers/userController.dart';
import 'package:wish/src/wish/presentation/utils/homepage_drawer.dart';
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
              height: 38,
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
                  context: context,
                  builder: (context) {
                    return Container(
                      height: size.height / 2.3,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                      ),
                    );
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

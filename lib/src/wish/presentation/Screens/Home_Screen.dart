import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/presentation/Screens/Product_Screen.dart';
import 'package:wish/src/wish/presentation/Screens/Tracker_Product_Screen.dart';
import 'package:wish/src/wish/presentation/controllers/userController.dart';
import 'package:wish/src/wish/presentation/utils/homepage_drawer.dart';
import 'package:wish/src/wish/presentation/utils/rectangular_indicator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = "/home-screen";
  const HomeScreen({super.key});

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
  late TabController tabController = TabController(length: 2, vsync: this);
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      drawer: HomePageDrawer(context, _selectedIndex, _onItemTapped),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Home"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
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
                    bottomLeftRadius: 20),
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
    );
  }
}

import "package:wish/src/exports.dart";

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
        elevation: 0,
        backgroundColor: AppColors.appBackgroundColor,
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
      body: PopScope(
        canPop: false, // Disable predictive back for now
        onPopInvoked: (didPop) async {
          if (!didPop) {
            exit(0);
          }
        },
        child: Column(
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
                  dividerColor: Colors.transparent,
                  labelColor: AppColors.appActiveColor,
                  indicatorColor: Color.fromARGB(255, 0, 0, 0),
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
                  ProductScreen(tabController: tabController),
                  TrackedProducts(tabController: tabController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

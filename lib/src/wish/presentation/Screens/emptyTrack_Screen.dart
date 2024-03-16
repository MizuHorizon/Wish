import "package:wish/src/exports.dart";

class EmptyTrackedProductScreen extends StatefulWidget {
  TabController tabController;
  EmptyTrackedProductScreen({super.key, required this.tabController});

  @override
  State<EmptyTrackedProductScreen> createState() =>
      _EmptyTrackedProductScreenState();
}

class _EmptyTrackedProductScreenState extends State<EmptyTrackedProductScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
              Colors.black,
              Colors.black,
            ])),
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 200),
                child: SvgPicture.asset(
                  'assets/images/emptyTrack.svg',
                )),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                "Start tracking your products. Get detailed prices\n                 tracking for your products.",
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.appActiveColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
            InkWell(
              onTap: () {
                widget.tabController.animateTo(0);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  height: 55,
                  width: size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.dividerColor),
                    gradient: const RadialGradient(
                      center: Alignment(-0, 2),
                      radius: 2.3,
                      colors: [
                        Color(0xFF6D7178),
                        Color.fromARGB(255, 14, 13, 13),
                        Color(0xFF000000),
                      ],
                      tileMode: TileMode.mirror,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Center(
                    child: Text(
                      "Start Tracking",
                      style: TextStyle(
                          color: AppColors.appActiveColor, fontSize: 18),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

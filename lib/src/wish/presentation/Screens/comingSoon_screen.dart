import "package:wish/src/exports.dart";

class ComingSoonScreen extends StatelessWidget {
  static const String routeName = "coming-soon";
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          const Text(
            "The Pro Plan will be launching soon.",
            style: TextStyle(
                fontSize: 20,
                color: AppColors.appActiveColor,
                fontWeight: FontWeight.w600),
          ),
          Container(
              child: const Image(
            image: AssetImage("assets/images/comingsoon.png"),
            fit: BoxFit.contain,
          )),
          Expanded(child: Container())
        ],
      ),
    );
  }
}

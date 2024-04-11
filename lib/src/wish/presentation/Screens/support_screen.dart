import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:wish/src/exports.dart';

class SupportScreen extends StatelessWidget {
  static const String routeName = "support-route";
  const SupportScreen({super.key});
  static const List<String> platforms = [
    "Ajio",
    "Bewakoof",
    "Snitch",
    "Bonkers"
  ];

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
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const Text(
          "Platforms",
          style: TextStyle(color: AppColors.appActiveColor),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            thickness: 0.7,
            color: AppColors.dividerColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Trackable Platforms",
                  style: TextStyle(
                      color: AppColors.appActiveColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Card(
                              margin:
                                  const EdgeInsets.only(left: 10.0, bottom: 10),
                              child: Container(
                                height: 40.0,
                                color: AppColors.appBackgroundColor,
                                child: Text(
                                  platforms[index],
                                  style: TextStyle(
                                      color: AppColors.appActiveColor,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0.0,
                            bottom: 0.0,
                            left: 21.0,
                            child: Container(
                              width: 1.5,
                              color: AppColors.dividerColor,
                            ),
                          ),
                          Positioned(
                            top: 5.0,
                            left: 16.0,
                            child: Container(
                              height: 10.0,
                              width: 10.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: platforms.length,
                  ),
                ),
                const Text(
                  "For more detail, check out the wish website which i updated frequently.",
                  style: TextStyle(
                      color: AppColors.appActiveColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 20),
                CglassButton(
                  onTap: () async {
                    final Uri _url = Uri.parse("https://wish.mizuhorizon.com/");
                    if (!await launchUrl(_url,
                        mode: LaunchMode.inAppBrowserView)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  widget: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Know more",
                          style: TextStyle(
                              color: AppColors.appActiveColor, fontSize: 20),
                        ),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

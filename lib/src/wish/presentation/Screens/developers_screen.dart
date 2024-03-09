import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wish/src/constants.dart';

class DevelopersScreen extends StatelessWidget {
  static const String routename = "developer-screen";
  const DevelopersScreen({super.key});
  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                // Implement your custom back button functionality here
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ),
          title: const Text(
            "Developers",
            style: TextStyle(color: AppColors.appActiveColor),
          ),
        ),
        body: Column(
          children: [
            const Divider(
              thickness: 0.7,
              color: AppColors.dividerColor,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                      child:
                          Image(image: AssetImage("assets/images/anshyy.png")),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Anshuman Sharma",
                        style: TextStyle(
                            color: AppColors.appActiveColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Container(
                        child: const Text(
                          "Flutter and Backend Developer",
                          style: TextStyle(
                              color: Color.fromARGB(255, 123, 119, 119),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                _launchUrl("https://twitter.com/_anshyyy");
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                child: const Image(
                                    color: AppColors.appActiveColor,
                                    image:
                                        AssetImage("assets/icons/twitter.png")),
                              ),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                _launchUrl(
                                    "https://www.linkedin.com/in/anshyyy/");
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                child: const Image(
                                    color: AppColors.appActiveColor,
                                    image: AssetImage("assets/icons/link.png")),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 150,
                    child: ClipRRect(
                      child:
                          Image(image: AssetImage("assets/images/saksham.png")),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Saksham Singh",
                        style: TextStyle(
                            color: AppColors.appActiveColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Container(
                        child: const Text(
                          "UX/UI Designer and Frontend Developer\nwith 1 year of Experience",
                          style: TextStyle(
                              color: Color.fromARGB(255, 123, 119, 119),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                _launchUrl(
                                    "https://twitter.com/SakchamSingh07");
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                child: const Image(
                                    color: AppColors.appActiveColor,
                                    image:
                                        AssetImage("assets/icons/twitter.png")),
                              ),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                _launchUrl(
                                    "https://www.linkedin.com/in/sakcham-singh-b45a7721a/");
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                child: const Image(
                                    color: AppColors.appActiveColor,
                                    image: AssetImage("assets/icons/link.png")),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

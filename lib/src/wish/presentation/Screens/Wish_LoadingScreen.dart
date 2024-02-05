import 'package:flutter/material.dart';
import 'package:wish/src/constants.dart';

class WishLoadingScreen extends StatefulWidget {
  const WishLoadingScreen({super.key});

  @override
  State<WishLoadingScreen> createState() => _WishLoadingScreenState();
}

class _WishLoadingScreenState extends State<WishLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(image: AssetImage("assets/images/wish_logo.png")),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.appActiveColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

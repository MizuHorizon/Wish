import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/presentation/Screens/Home_Screen.dart';
import 'package:wish/src/wish/presentation/Screens/Signin_screen.dart';

class WishLoadingScreen extends StatefulWidget {
  const WishLoadingScreen({super.key});

  @override
  State<WishLoadingScreen> createState() => _WishLoadingScreenState();
}

class _WishLoadingScreenState extends State<WishLoadingScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final jwtToken = prefs.getString('jwtToken');
    await Future.delayed(const Duration(seconds: 2));
    // If JWT token is saved, navigate to home screen
    if (jwtToken != null && jwtToken.isNotEmpty) {
      Navigator.pushNamed(context, HomeScreen.routeName);
    } else {
      Navigator.pushNamed(context, SignInScreen.routeName);
    }
  }

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

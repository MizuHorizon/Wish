import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/product_model.dart';
import 'package:wish/src/wish/presentation/Screens/Error_Screen.dart';
import 'package:wish/src/wish/presentation/Screens/Home_Screen.dart';
import 'package:wish/src/wish/presentation/Screens/Signin_screen.dart';
import 'package:wish/src/wish/presentation/controllers/productController.dart';
import 'package:wish/src/wish/services/firebase_notification_service.dart';

class WishLoadingScreen extends ConsumerStatefulWidget {
  const WishLoadingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WishLoadingScreenState();
}

class _WishLoadingScreenState extends ConsumerState<WishLoadingScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _fetchUserProducts() async {
    try {
      var products =
          await ref.read(productControllerProvider.notifier).getAllProducts();
      ref.read(productModelProvider.notifier).update((state) => products);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _checkTokenAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final jwtToken = prefs.getString('jwtToken');
    print("JWT TOKEN : $jwtToken");
    // If JWT token is saved, navigate to home screen
    if (jwtToken != null && jwtToken.isNotEmpty) {
      try {
        print("fetching products in loading screen");
        await _fetchUserProducts();
        await ref.watch(firebaseMessagingProvider).then((value) {
          value.getToken();
        }).onError(
            (error, stackTrace) => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ErrorScreen(
                    error: 'An error occurred: $error',
                  ),
                )));

        Navigator.pushNamed(context, HomeScreen.routeName);
      } catch (err) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ErrorScreen(
            error: 'An error occurred: $err',
          ),
        ));
      }
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

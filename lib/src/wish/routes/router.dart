import 'package:flutter/material.dart';
import 'package:wish/src/wish/presentation/Screens/Error_Screen.dart';
import 'package:wish/src/wish/presentation/Screens/Home_Screen.dart';
import 'package:wish/src/wish/presentation/Screens/SignIn_Screen.dart';
import 'package:wish/src/wish/presentation/Screens/Signup_Screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wish/src/wish/presentation/Screens/track_graph_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignInScreen.routeName:
      return PageTransition(
        child: SignInScreen(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    case SignUpScreen.routeName:
      return PageTransition(
        child: const SignUpScreen(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );

    case HomeScreen.routeName:
      return PageTransition(
        child: HomeScreen(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    case TrackProductScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final String name = arguments['name'];
      final int desiredPrice = arguments['desiredPrice'];
      final List prices = arguments['prices'];
      final String productUrl = arguments['productUrl'];
      return PageTransition(
        child: TrackProductScreen(
          prices: prices,
          name: name,
          desiredPrice: desiredPrice,
          productUrl: productUrl,
        ),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    default:
      return PageTransition(
        child: Scaffold(
          body: ErrorScreen(error: "Something went wrong"),
        ),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
  }
}

import "package:page_transition/page_transition.dart";
import "package:wish/src/exports.dart";
import "package:wish/src/wish/presentation/Screens/comingSoon_screen.dart";

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
    case DevelopersScreen.routename:
      return PageTransition(
          child: DevelopersScreen(), type: PageTransitionType.rightToLeft);
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
      final String productId = arguments['productId'];
      return PageTransition(
        child: TrackProductScreen(
          prices: prices,
          name: name,
          productId: productId,
          desiredPrice: desiredPrice,
          productUrl: productUrl,
        ),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    case ProfileScreen.routeName:
      return PageTransition(
          child: const ProfileScreen(),
          type: PageTransitionType.leftToRight,
          settings: settings);
    case ErrorScreen.routeName:
      return PageTransition(
        child: const ErrorScreen(
          error: '',
        ),
        type: PageTransitionType.leftToRight,
        settings: settings,
      );

    case ComingSoonScreen.routeName:
      return PageTransition(
          child: const ComingSoonScreen(),
          type: PageTransitionType.bottomToTop);
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish/src/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:wish/src/wish/presentation/Screens/Wish_LoadingScreen.dart';
import 'package:wish/src/wish/routes/router.dart';
import 'package:wish/src/wish/services/firebase_notification_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseNotificationService fs =
      FirebaseNotificationService(userDataProvider: null);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
        colorSchemeSeed: AppColors.appBackgroundColor,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        fontFamily: "Inter",
        colorSchemeSeed: AppColors.appBackgroundColor,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const WishLoadingScreen(),
    );
  }
}

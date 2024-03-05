import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish/src/wish/models/user_model.dart';
import 'package:wish/src/wish/presentation/controllers/userController.dart';

final firebaseMessagingProvider = Provider((ref) async {
  return FirebaseNotificationService(
      userDataProvider: ref.read(userControllerProvider.notifier));
});

class FirebaseNotificationService {
  final userDataProvider;
  final _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseNotificationService({required this.userDataProvider}) {
    getNotificationsWhenAppIsOPenend();
    getNotificationsWhenAppIsClosedOrTerminated();
    getNotificationsWhenAppisInBackground();
  }

  void getToken() async {
    //take permission
    await _firebaseMessaging.requestPermission();

    //first check that if the user has the fcm_token
    MyAppUser userData = await userDataProvider.currentUser();
    String? userFCMtoken = userData.fcmToken;
    // print("user data okokokok $v");

    var firebaseFCM = await FirebaseMessaging.instance.getToken();
    print("userFcm : ${userFCMtoken} firebaseFcmToken: $firebaseFCM");
    if (userFCMtoken == null || firebaseFCM != userFCMtoken) {
      var us = await userDataProvider.updateFCM(firebaseFCM);
      print("user Data updated ${us}");
    }
  }

  void getNotificationsWhenAppIsOPenend() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("received notifications when app is open: $message");

      //navigate to the desired screen
    });
  }

  void getNotificationsWhenAppIsClosedOrTerminated() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print("received initial notifications when app is closed: $message");
    });
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("background notifcation $message");
  }

  void getNotificationsWhenAppisInBackground() {
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}

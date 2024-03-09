import 'package:flutter/material.dart';
import 'package:wish/src/constants.dart';

class ErrorScreen extends StatelessWidget {
  static const String routeName = "error-screen";
  final String error;
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: const Text(
                    "Looks like an error occured. Sit tight\n        we are on the way to fix it !!",
                    style: TextStyle(
                        color: AppColors.appActiveColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: ClipRRect(
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/error.png",
                      fit: BoxFit
                          .cover, // Use BoxFit.cover to fit the image within the container
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error);
                      },
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

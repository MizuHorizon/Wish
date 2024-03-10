import 'package:flutter/material.dart';
import 'package:wish/src/constants.dart';

class NoProductScreen extends StatelessWidget {
  const NoProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Expanded(child: Container()),
            const Text(
              "We don't have the product, that\n you are looking for :(",
              style: TextStyle(
                  fontSize: 20,
                  color: AppColors.appActiveColor,
                  fontWeight: FontWeight.w600),
            ),
            Container(
                child: Image(
              image: AssetImage("assets/images/cross.png"),
              fit: BoxFit.contain,
            )),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/product_model.dart';
import 'package:wish/src/wish/presentation/controllers/productController.dart';

class EmptyProductScreen extends ConsumerStatefulWidget {
  const EmptyProductScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmptyProductScreenState();
}

class _EmptyProductScreenState extends ConsumerState<EmptyProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(), // Enable scrolling
        child: Column(
          children: [
            Container(
              child: const Image(
                image: AssetImage("assets/images/emptyProduct.png"),
              ),
            ),
            const Text(
              "Add Products and track their prices.",
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.appActiveColor,
                  fontWeight: FontWeight.w400),
            ),
            Container(
              height: 300,
              margin: const EdgeInsets.only(left: 150),
              child: const Image(
                image: AssetImage("assets/images/whitearrow.gif"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:wish/src/constants.dart';

class CompanyContainer extends StatefulWidget {
  String brandName;
  CompanyContainer({super.key, required this.brandName});

  @override
  State<CompanyContainer> createState() => _CompanyContainerState();
}

class _CompanyContainerState extends State<CompanyContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 1),
    );
    _animation = Tween<double>(begin: 0.0, end: 100.0).animate(_controller)
      ..addListener(() {
        setState(() {
          print(_animation.value);
        });
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GlassContainer(
        width: 200,
        height: 200,
        borderRadius: BorderRadius.circular(10),
        border: 0,
        blur: 200,
        linearGradient: LinearGradient(
            transform: GradientRotation(100 * (_animation.value / 360)),
            colors: const [
              Colors.transparent,
              const Color.fromARGB(255, 52, 49, 49)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              widget.brandName.toUpperCase(),
              style: const TextStyle(
                  fontSize: 25,
                  color: AppColors.appActiveColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

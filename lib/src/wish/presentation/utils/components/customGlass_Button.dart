import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

class GlassButton extends StatefulWidget {
  final void Function()? onTap;
  final Widget widget;
  final double border;
  const GlassButton(
      {super.key, required this.onTap, required this.widget, this.border = 0});
  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: InkWell(
        onTap: widget.onTap,
        child: GlassContainer(
          // linearGradient: const LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: [
          //       Colors.black,
          //       Color.fromARGB(255, 41, 40, 40),
          //       Colors.black
          //     ]),
          borderRadius: BorderRadius.circular(10),
          border: widget.border,
          blur: 100,
          height: 55,
          width: size.width,
          child: widget.widget,
        ),
      ),
    );
  }
}

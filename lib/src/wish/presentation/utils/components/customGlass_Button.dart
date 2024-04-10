import "package:wish/src/exports.dart";

class CglassButton extends StatefulWidget {
  final void Function()? onTap;
  final Widget widget;
  final double border;
  const CglassButton(
      {super.key, required this.onTap, required this.widget, this.border = 0});

  @override
  State<CglassButton> createState() => _CglassButtonState();
}

class _CglassButtonState extends State<CglassButton> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: InkWell(
        onTap: widget.onTap,
        child: GlassContainer(
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

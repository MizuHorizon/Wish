import "package:wish/src/exports.dart";

class ImageShimmer extends StatefulWidget {
  const ImageShimmer({super.key});

  @override
  State<ImageShimmer> createState() => _ImageShimmerState();
}

class _ImageShimmerState extends State<ImageShimmer> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(bottom: 5),
        height: size.height / 3.4,
        width: size.width / 2.3,
      ),
    );
  }
}

import "package:wish/src/exports.dart";

class ShimmerTrackProduct extends StatefulWidget {
  const ShimmerTrackProduct({super.key});

  @override
  State<ShimmerTrackProduct> createState() => _ShimmerTrackProductState();
}

class _ShimmerTrackProductState extends State<ShimmerTrackProduct> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.only(bottom: 5),
              width: size.width / 2.8,
              height: size.height / 5,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(bottom: 5),
                  height: 20,
                  width: size.width / 2.8,
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(bottom: 5),
                  height: 25,
                  width: size.width / 2.6,
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(bottom: 5),
                  height: 17,
                  width: size.width / 2,
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(bottom: 5),
                  height: 10,
                  width: size.width / 2.5,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(bottom: 5),
                      height: 17,
                      width: 70,
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(bottom: 5),
                      height: 17,
                      width: 70,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            )
          ],
        ));
  }
}

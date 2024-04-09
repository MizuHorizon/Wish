import "dart:ui";

import "package:wish/src/exports.dart";

class GradientDialogDelete extends ConsumerWidget {
  final String title;
  final String message;
  final Color color;
  final String productId;

  const GradientDialogDelete(
      {Key? key,
      required this.title,
      required this.message,
      required this.color,
      required this.productId})
      : super(key: key);

  void deleteProduct(WidgetRef ref) async {
    await ref.read(productControllerProvider.notifier).deleteProduct(productId);
    ref.read(productModelProvider.notifier).state =
        await ref.read(productControllerProvider.notifier).getAllProducts();

    print(
        "new state after delete ${ref.read(productModelProvider.notifier).state}");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 350,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.dividerColor,
            width: 1.5,
          ),
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 0.5,
            colors: [
              Colors.grey[800]!,
              Colors.black,
            ],
            stops: [0.0, 1.0],
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Delete Product",
                style: TextStyle(
                  color: AppColors.appActiveColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const Text(
                  "Did you buy the product? We can help you track and give the best price for it.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      print(productId);
                      await ref
                          .read(productControllerProvider.notifier)
                          .deleteProduct(productId);
                      ref.watch(productModelProvider.notifier).state = await ref
                          .watch(productControllerProvider.notifier)
                          .getAllProducts();

                      // print(
                      //     "new state after delete ${ref.read(productModelProvider.notifier).state}");
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Container(
                      height: size.height / 13.3,
                      width: size.width / 1.2 / 2.06,
                      decoration: const BoxDecoration(
                          border: Border(
                        top:
                            BorderSide(width: 2, color: AppColors.dividerColor),
                        right:
                            BorderSide(width: 2, color: AppColors.dividerColor),
                      )),
                      child: const Center(
                          child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Container(
                      height: size.height / 13.3,
                      width: size.width / 1.2 / 2.2,
                      decoration: const BoxDecoration(
                          border: Border(
                        top:
                            BorderSide(width: 2, color: AppColors.dividerColor),
                      )),
                      child: const Center(
                          child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: AppColors.appActiveColor, fontSize: 20),
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showDeleteDialog(BuildContext context, String title, String message,
    Color color, String productId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: GradientDialogDelete(
          title: title,
          message: message,
          color: color,
          productId: productId,
        ),
      );
    },
  );
}

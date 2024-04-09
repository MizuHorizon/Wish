import "dart:ui";

import "package:wish/src/exports.dart";

class ConfirmationDialog extends ConsumerWidget {
  final String title;
  final String message;
  final Color color;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pop();
    });

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.dividerColor,
            width: 1.5,
          ),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF37393B),
              Color(0xFF000000),
            ],
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Successfull",
                style: TextStyle(
                  color: AppColors.greenDark,
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8),
                child: Text(
                  "Product is sucessfully added to the queue and soon it will be shown in your cart. Now lets move for its tracking option.",
                  style: TextStyle(
                      color: AppColors.appActiveColor,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Container(
                  height: 40,
                  width: 300,
                  decoration: const BoxDecoration(
                      border: Border(
                    top: BorderSide(width: 2, color: AppColors.dividerColor),
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      const Spacer(),
                      Center(
                          child: Text(
                        "Okay",
                        style: TextStyle(
                            color: AppColors.appActiveColor, fontSize: 20),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showConfirmationDialog(
    BuildContext context, String title, String message, Color color) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: ConfirmationDialog(
          title: title,
          message: message,
          color: color,
        ),
      );
    },
  );
}

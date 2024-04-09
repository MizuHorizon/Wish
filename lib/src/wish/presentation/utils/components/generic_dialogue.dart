import "dart:ui";

import "package:wish/src/exports.dart";

class GenericGradientDialog extends ConsumerWidget {
  final String title;
  final String message;
  final Color color;
  final String leftMessage;
  final void Function()? onTap;

  const GenericGradientDialog(
      {Key? key,
      required this.title,
      required this.message,
      required this.color,
      required this.leftMessage,
      this.onTap})
      : super(key: key);

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
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  message,
                  // "After disabling the tracker we can't send notifications to you!!\n Are you Sure?",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: onTap,
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
                      child: Center(
                          child: Text(
                        leftMessage,
                        style: TextStyle(color: color, fontSize: 20),
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

void showDialogeForTracker(BuildContext context, String leftMessage,
    String title, String message, Color color, void Function()? onTap) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: GenericGradientDialog(
          title: title,
          message: message,
          color: color,
          onTap: onTap,
          leftMessage: leftMessage,
        ),
      );
    },
  );
}

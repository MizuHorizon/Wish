import 'package:flutter/material.dart';
import 'package:wish/src/constants.dart';

class GradientDialog extends StatelessWidget {
  final String title;
  final String message;
  final Color color;

  const GradientDialog(
      {Key? key,
      required this.title,
      required this.message,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.dividerColor,
            width: 1.5,
          ),
          gradient: LinearGradient(
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
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Did you buy the product? We can help you track and give the best price for it.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 25,
                    width: 100,
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(width: 2, color: AppColors.dividerColor),
                    )),
                    child: Text("OK"),
                  ),
                  Container()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showDeleteDialog(
    BuildContext context, String title, String message, Color color) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GradientDialog(
        title: title,
        message: message,
        color: color,
      );
    },
  );
}

import 'package:flutter/material.dart';

class SuccessGradientDialog extends StatelessWidget {
  final String title;
  final String message;
  final Color color;

  const SuccessGradientDialog(
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                message,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Container(
                height: 200, // Adjust the height as needed
                child: const ClipRect(
                  child: OverflowBox(
                    maxHeight: double.infinity,
                    alignment: Alignment.center,
                    child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/mail.gif")),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
                child: Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showMailGradientDialog(
    BuildContext context, String title, String message, Color color) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SuccessGradientDialog(
        title: title,
        message: message,
        color: color,
      );
    },
  );
}

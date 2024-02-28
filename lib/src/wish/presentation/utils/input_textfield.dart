import 'package:flutter/material.dart';
import 'package:wish/src/constants.dart';

class InputWishTextField extends StatefulWidget {
  const InputWishTextField(
      {super.key,
      required TextEditingController controller,
      required this.hintText,
      required this.isNumerInput,
      required this.isPassword})
      : _controller = controller;

  final TextEditingController _controller;
  final String hintText;
  final bool isPassword;
  final bool isNumerInput;

  @override
  State<InputWishTextField> createState() => _InputWishTextFieldState();
}

class _InputWishTextFieldState extends State<InputWishTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.isNumerInput ? TextInputType.phone : null,
      obscureText: widget.isPassword && !_isPasswordVisible,
      cursorColor: AppColors.appActiveColor,
      onChanged: (value) {
        //Do something with the user input.
      },
      decoration: InputDecoration(
        hintText: widget.hintText,

        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.appActiveColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.appActiveColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        filled: true,
        fillColor: AppColors.appBackgroundColor,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              )
            : null,
        // Set text color of entered text
      ),
      style: TextStyle(color: Colors.white),
      controller: widget._controller,
    );
  }
}

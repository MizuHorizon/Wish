import 'package:flutter/material.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/presentation/utils/input_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        title: const Text(
          "Log In",
          style: TextStyle(color: AppColors.appActiveColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: AppColors.appActiveColor),
            ),
            const SizedBox(
              height: 15,
            ),
            InputWishTextField(controller: _emailController),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Password",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: AppColors.appActiveColor),
            ),
            const SizedBox(
              height: 15,
            ),
            InputWishTextField(controller: _passwordController),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: MaterialButton(
                onPressed: () {},
                child: Container(
                  height: 65,
                  width: width,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(19, 19, 21, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Center(
                    child: Text(
                      "Log In",
                      style: TextStyle(
                          color: AppColors.appActiveColor, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: MaterialButton(
                onPressed: () {},
                child: Container(
                  height: 65,
                  width: width,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(19, 19, 21, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: 25,
                            width: 25,
                            child: Image(
                                image: AssetImage("assets/images/google.png"))),
                        Text(
                          "Log In With Google",
                          style: TextStyle(
                              color: AppColors.appActiveColor, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}

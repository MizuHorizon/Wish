import 'package:flutter/material.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/presentation/Screens/Signup_Screen.dart';
import 'package:wish/src/wish/presentation/utils/custom_dialogueBox.dart';
import 'package:wish/src/wish/presentation/utils/dotted_line.dart';
import 'package:wish/src/wish/presentation/utils/input_textfield.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "/signin-screen";
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

  bool _isValidEmail(String email) {
    // Add your email validation logic here
    // You can use a regular expression or any other method
    // Here's a simple example using a regular expression
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
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
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 5),
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
              InputWishTextField(
                controller: _emailController,
                hintText: "Enter Your Email",
                isPassword: false,
                isNumerInput: false,
              ),
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
              InputWishTextField(
                controller: _passwordController,
                hintText: "Enter Your Password",
                isPassword: true,
                isNumerInput: false,
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: MaterialButton(
                  onPressed: () {
                    if (!_isValidEmail(_emailController.text)) {
                      // Show a warning or error message
                      showGradientDialog(context, "Check Email",
                          "Malformed Email Address", AppColors.appActiveColor);
                    } else if (_emailController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      // Show warning dialog for empty email or password
                      showGradientDialog(
                        context,
                        "Fields Required",
                        "Email and password can't be empty.",
                        Colors.red, // Red neon color for warning
                      );
                    }
                  },
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
                                  image:
                                      AssetImage("assets/images/google.png"))),
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
              const SizedBox(
                height: 25,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: 130,
                      child: Divider(
                        color: AppColors.dividerColor,
                      )),
                  Text(
                    "or",
                    style: TextStyle(color: AppColors.dividerColor),
                  ),
                  SizedBox(
                      width: 130,
                      child: Divider(
                        color: AppColors.dividerColor,
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Don't have an account ?",
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.appActiveColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreen.routeName);
                  },
                  child: Container(
                    height: 65,
                    width: width,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.dividerColor),
                      gradient: const RadialGradient(
                        center: Alignment(-0, 2),

                        radius: 2.3,
                        // begin: Alignment(1, -0.00),
                        // end: Alignment(0, -1),
                        colors: [
                          Color(0xFF6D7178),
                          Color(0xFF000000),
                        ],
                        tileMode: TileMode.mirror,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                            color: AppColors.appActiveColor, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {},
                child: const Center(
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                        color: AppColors.appActiveColor, fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

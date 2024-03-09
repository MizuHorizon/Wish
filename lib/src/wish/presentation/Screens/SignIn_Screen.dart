import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/product_model.dart';
import 'package:wish/src/wish/models/user_model.dart';
import 'package:wish/src/wish/presentation/Screens/Error_Screen.dart';
import 'package:wish/src/wish/presentation/Screens/Home_Screen.dart';
import 'package:wish/src/wish/presentation/Screens/Signup_Screen.dart';
import 'package:wish/src/wish/presentation/controllers/productController.dart';
import 'package:wish/src/wish/presentation/controllers/userController.dart';
import 'package:wish/src/wish/presentation/utils/components/custom_dialogueBox.dart';
import 'package:wish/src/wish/presentation/utils/input_textfield.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const routeName = "/signin-screen";
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loginWithGoogle = true;
  bool _normalLogin = true;
  bool validEmail = true;
  bool validPassword = true;
  bool wrongPassword = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void doSignIn(String email, String password) async {
    try {
      MyAppUser? user = await ref
          .read(userControllerProvider.notifier)
          .signIn(email, password);
      ref.read(userModelProvider.notifier).update((state) => user);
      Navigator.pushNamed(context, HomeScreen.routeName);
    } catch (e) {
      print("funking $e");
      setState(() {
        wrongPassword = true;
      });
    }
  }

  void doGoogleSignIn() async {
    try {
      await ref
          .read(userControllerProvider.notifier)
          .googleSigin()
          .then((value) async {
        print("this is the value $value");

        ref
            .read(userModelProvider.notifier)
            .update((state) => value as MyAppUser);

        //fetching products
        ref.read(productModelProvider.notifier).state =
            await ref.read(productControllerProvider.notifier).getAllProducts();

        Navigator.pushNamed(context, HomeScreen.routeName);
      });
    } catch (e) {
      print(e);
      //  Navigator.pushNamed(context, ErrorScreen.routeName);
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final userController = ref.watch(userControllerProvider);
    var width = MediaQuery.of(context).size.width;
    ref.listen(userControllerProvider, (previous, next) {
      if (next.hasError) {
        setState(() {
          _loginWithGoogle = true;
        });
      }
      if (!next.isLoading && next.hasError) {
        // if (next.error.toString() == "Account with Email Doesn't Exists!") {
        //   print("error 1");
        //   showGradientDialog(
        //       context, "Error", next.error.toString(), Colors.red);
        // } else if (next.error.toString() !=
        //     "Account with Email Exists already!") {
        //   print("error 2");
        //   showGradientDialog(
        //       context, "Error", next.error.toString(), Colors.red);
        // }
        setState(() {
          _normalLogin = true;
        });
      }
    });
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                onChanged: (value) {
                  setState(() {
                    validEmail = true;
                    wrongPassword = false;
                  });
                },
              ),
              if (!validEmail) ...[
                const Text(
                  "Please! Check this email...",
                  style: TextStyle(color: Colors.red, fontSize: 15),
                )
              ],
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
                onChanged: (value) {
                  setState(() {
                    validPassword = true;
                    wrongPassword = false;
                  });
                },
              ),
              if (!validPassword) ...[
                const Text(
                  "Please! Fill this field...",
                  style: TextStyle(color: Colors.red, fontSize: 15),
                )
              ],
              if (wrongPassword) ...[
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      "Wrong password!!!",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                )
              ],
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: InkWell(
                  onTap: !_normalLogin
                      ? null
                      : () {
                          if (!_isValidEmail(_emailController.text)) {
                            // Show a warning or error message
                            setState(() {
                              validEmail = false;
                            });
                          } else if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            // Show warning dialog for empty email or password
                            setState(() {
                              validPassword = false;
                            });
                          } else {
                            print("signIn");
                            _normalLogin = false;
                            setState(() {
                              _normalLogin = userController.isLoading;
                            });

                            doSignIn(_emailController.text.trim(),
                                _passwordController.text.trim());
                          }
                        },
                  child: Container(
                    height: 55,
                    width: width,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(19, 19, 21, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: !_normalLogin
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: AppColors.appActiveColor,
                          ))
                        : const Center(
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                  color: AppColors.appActiveColor,
                                  fontSize: 20),
                            ),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: InkWell(
                  onTap: !_loginWithGoogle
                      ? null
                      : () {
                          _loginWithGoogle = false;
                          setState(() {
                            _loginWithGoogle = userController.isLoading;
                          });

                          doGoogleSignIn();
                        },
                  child: Container(
                    height: 55,
                    width: width,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(19, 19, 21, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: !_loginWithGoogle
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.appActiveColor,
                            ),
                          )
                        : const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: Image(
                                        image: AssetImage(
                                            "assets/images/google.png"))),
                                Text(
                                  "Log In With Google",
                                  style: TextStyle(
                                      color: AppColors.appActiveColor,
                                      fontSize: 20),
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
                child: InkWell(
                  onTap: () {
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
              Center(
                child: Container(
                  child: InkWell(
                    onTap: () {},
                    child: const Center(
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                            color: AppColors.appActiveColor, fontSize: 15),
                      ),
                    ),
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

import "package:flutter/gestures.dart";
import "package:wish/src/exports.dart";

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeName = "/signup-screen";
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController fname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  //final UserController _userController = UserController();
  Country _selectedCountry = Country.worldWide;

  bool _isGoogleLoading = true;
  bool _isSignUpLoading = true;
  bool _emptyFirstName = false;
  bool _emptyLastName = false;
  bool _emptyEmail = false;
  bool _emptyPassword = false;
  bool _emptyMobile = false;
  bool validEmail = true;
  bool validPhone = true;
  bool validCountryCode = true;

  bool validateFields() {
    return fname.text.isNotEmpty &&
        lname.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        mobile.text.isNotEmpty;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  bool validatePhoneNumber(String phoneNumber) {
    RegExp phoneNumberRegExp =
        RegExp(r'^\(?[0-9]{3}\)?[- ]?[0-9]{3}[- ]?[0-9]{4}$');
    return phoneNumberRegExp.hasMatch(phoneNumber);
  }

  Future<void> doGoogleSignUp() async {
    MyAppUser? user =
        await ref.read(userControllerProvider.notifier).googleSigin();
    ref.read(userModelProvider.notifier).update((state) => user);
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, HomeScreen.routeName);
  }

  Future<void> doSignUp() async {
    String name = fname.text.trim() + " " + lname.text.trim();
    String emailInput = email.text.trim();
    String pass = password.text.trim();
    String phone = "(${_selectedCountry.phoneCode})${mobile.text.trim()}";
    print("$name,$emailInput,$pass,$phone");

    try {
      MyAppUser? user = await ref
          .read(userControllerProvider.notifier)
          .doSignUp(name, emailInput, phone, pass);
      ref.read(userModelProvider.notifier).update((state) => user);
      showMailGradientDialog(
          context,
          "Verification Email Sent",
          "We have sent you an email. Please verify your email to use our services and get updates about new products.",
          Colors.white70);
    } catch (error) {
      print("error in signup $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final userController = ref.watch(userControllerProvider);
    ref.listen(userControllerProvider, (previous, next) {
      if (!next.isLoading && next.hasError) {
        if (next.error.toString() == "Account with Email Exists already!") {
          showGradientDialog(
              context, "Error", next.error.toString(), Colors.red);
        }
        setState(() {
          _isSignUpLoading = true;
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: SizedBox(
          height: 30,
          width: 30,
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/send-square.svg',
              width: 30.0,
              height: 30.0,
              color: Colors.white,
            ),
            onPressed: () {
              // Implement your custom back button functionality here
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const Text(
          "Sign Up",
          style: TextStyle(color: AppColors.appActiveColor),
        ),
        backgroundColor: AppColors.appBackgroundColor,
      ),
      backgroundColor: AppColors.appBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "First Name",
                        style: TextStyle(
                            color: AppColors.appActiveColor, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 150,
                        height: 40,
                        child: InputWishTextField(
                          isNumerInput: false,
                          controller: fname,
                          hintText: "Jane",
                          isPassword: false,
                          onChanged: (value) {
                            setState(() {
                              _emptyFirstName = false;
                            });
                          },
                        ),
                      ),
                      if (_emptyFirstName) ...[
                        const Text(
                          "Required*...",
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      ]
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Last Name",
                        style: TextStyle(
                            color: AppColors.appActiveColor, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 150,
                        height: 40,
                        child: InputWishTextField(
                          isNumerInput: false,
                          controller: lname,
                          hintText: "Smith",
                          isPassword: false,
                          onChanged: (value) {
                            setState(() {
                              _emptyLastName = false;
                            });
                          },
                        ),
                      ),
                      if (_emptyLastName) ...[
                        const Text(
                          "Required*...",
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      ]
                    ],
                  )
                ],
              ),
              const SizedBox(height: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(
                        color: AppColors.appActiveColor, fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: width,
                    height: 40,
                    child: InputWishTextField(
                      isNumerInput: false,
                      controller: email,
                      hintText: "jsmith.aex3@gmail.com",
                      isPassword: false,
                      onChanged: (value) {
                        setState(() {
                          _emptyEmail = false;
                          validEmail = true;
                        });
                      },
                    ),
                  ),
                  if (_emptyEmail) ...[
                    const Text(
                      "Required*...",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    )
                  ],
                  if (!validEmail) ...[
                    const Center(
                      child: Text(
                        "Invalid Email",
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                    )
                  ]
                ],
              ),
              const SizedBox(height: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Password",
                    style: TextStyle(
                        color: AppColors.appActiveColor, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: width,
                    height: 40,
                    child: InputWishTextField(
                      isNumerInput: false,
                      controller: password,
                      hintText: "Password",
                      isPassword: true,
                      onChanged: (value) {
                        setState(() {
                          _emptyPassword = false;
                        });
                      },
                    ),
                  ),
                  if (_emptyPassword) ...[
                    const Text(
                      "Required*...",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    )
                  ]
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Country",
                          style: TextStyle(
                              color: AppColors.appActiveColor, fontSize: 18)),
                      // here that drop down
                      const SizedBox(height: 8),
                      Container(
                        width: width / 2.6,
                        child: ElevatedButton(
                          onPressed: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode:
                                  true, // optional. Shows phone code before the country name.
                              onSelect: (Country country) {
                                print('Select country: ${country.displayName}');
                                setState(() {
                                  _selectedCountry = country;
                                  validCountryCode = true;
                                });
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(19, 19, 21, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '+${_selectedCountry.phoneCode}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.appActiveColor,
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppColors.appActiveColor,
                              )
                            ],
                          ),
                        ),
                      ),
                      if (!validCountryCode) ...[
                        const Text(
                          "Required*...",
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      ]
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Mobile Number",
                        style: TextStyle(
                            color: AppColors.appActiveColor, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: width / 2.4,
                        height: 40,
                        child: InputWishTextField(
                          isNumerInput: true,
                          controller: mobile,
                          hintText: "1234-123-123",
                          isPassword: false,
                          onChanged: (value) {
                            setState(() {
                              _emptyMobile = false;
                              validPhone = true;
                            });
                          },
                        ),
                      ),
                      if (_emptyMobile) ...[
                        const Text(
                          "Required*...",
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      ],
                      if (!validPhone) ...[
                        const Text(
                          "Invalid Phone",
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      ]
                    ],
                  )
                ],
              ),
              const SizedBox(height: 18),
              RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          color: AppColors.appActiveColor,
                          fontWeight: FontWeight.w300),
                      children: [
                    const TextSpan(
                        text:
                            "By clicking on Sign Up, you agree to our, You agree to Our Terms of Service and that you have read our "),
                    TextSpan(
                      text: "Privacy And Policy.",
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Action to perform when the button is clicked
                          print('Button clicked!');
                        },
                    )
                  ])),
              // Container(
              //   padding: const EdgeInsets.only(left: 20, right: 20),
              //   child: Column(
              //     children: [
              //       const Center(
              //         child: Text(
              //           "By clicking on Sign Up, you agree to our, You agree to Our Terms of Service and that you have read our",
              //           style: TextStyle(
              //               color: AppColors.appActiveColor,
              //               fontWeight: FontWeight.w300),
              //         ),
              //       ),
              //       const Center(
              //         child: Text(
              //           "Privacy and Policy",
              //           style: TextStyle(
              //               color: AppColors.appActiveColor,
              //               fontWeight: FontWeight.w300),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              CglassButton(
                onTap: !_isSignUpLoading
                    ? null
                    : () {
                        if (!validateFields()) {
                          // Show warning dialog for empty fields
                          if (fname.text.isEmpty) {
                            setState(() {
                              _emptyFirstName = true;
                            });
                          }
                          if (lname.text.isEmpty) {
                            setState(() {
                              _emptyLastName = true;
                            });
                          }

                          if (email.text.isEmpty) {
                            setState(() {
                              _emptyEmail = true;
                            });
                          }
                          if (password.text.isEmpty) {
                            setState(() {
                              _emptyPassword = true;
                            });
                          }

                          if (mobile.text.isEmpty) {
                            setState(() {
                              _emptyMobile = true;
                            });
                          }
                        } else if (!isValidEmail(email.text)) {
                          // Show warning dialog for invalid email
                          setState(() {
                            validEmail = false;
                          });
                        } else if (_selectedCountry.phoneCode.isEmpty) {
                          setState(() {
                            validCountryCode = false;
                          });
                        } else if (!validatePhoneNumber(mobile.text.trim())) {
                          // Show warning dialog for invalid mobile number
                          setState(() {
                            validPhone = false;
                          });
                        } else {
                          _isSignUpLoading = false;
                          setState(() {
                            _isSignUpLoading = userController.isLoading;
                          });
                          doSignUp();
                        }
                      },
                widget: !_isSignUpLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.appActiveColor),
                      )
                    : const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: AppColors.appActiveColor, fontSize: 20),
                        ),
                      ),
              ),
              const SizedBox(
                height: 20,
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
              CglassButton(
                border: 0.7,
                onTap: !_isGoogleLoading
                    ? null
                    : () {
                        _isGoogleLoading = false;
                        setState(() {
                          _isGoogleLoading = userController.isLoading;
                        });
                        doGoogleSignUp();
                      },
                widget: !_isGoogleLoading
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
                              "Continue With Google",
                              style: TextStyle(
                                  color: AppColors.appActiveColor,
                                  fontSize: 20),
                            ),
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

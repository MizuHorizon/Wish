import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/presentation/controllers/userController.dart';
import 'package:wish/src/wish/presentation/utils/custom_dialogueBox.dart';
import 'package:wish/src/wish/presentation/utils/input_textfield.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/signup-screen";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final UserController _userController = UserController();
  Country _selectedCountry = Country.worldWide;
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

  bool isValidMobile(String mobile) {
    final mobileRegex = RegExp(r'^[0-9]+$');
    return mobileRegex.hasMatch(mobile);
  }

  Future<void> doSignUp() async {
    String name = fname.text.trim() + " " + lname.text.trim();
    String emailInput = email.text.trim();
    String pass = password.text.trim();
    String phone = "(${_selectedCountry.phoneCode})${mobile.text.trim()}";
    print("$name,$emailInput,$pass,$phone");

    await _userController.doSignUp(name, emailInput, phone, pass);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
                        ),
                      )
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
                        ),
                      )
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
                    ),
                  )
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
                    ),
                  )
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
                                });
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(19, 19, 21, 1),
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
                      )
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
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: const Center(
                  child: Text(
                    "By tapping sign Up, you consent to receiving a verification link via email on the provided email.",
                    style: TextStyle(
                        color: AppColors.appActiveColor,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: MaterialButton(
                  onPressed: () {
                    if (!validateFields()) {
                      // Show warning dialog for empty fields
                      String errorMessage =
                          "Please fill in all required fields:\n";
                      if (fname.text.isEmpty) errorMessage += "- First Name\n";
                      if (lname.text.isEmpty) errorMessage += "- Last Name\n";
                      if (email.text.isEmpty) errorMessage += "- Email\n";
                      if (password.text.isEmpty) errorMessage += "- Password\n";
                      if (mobile.text.isEmpty)
                        errorMessage += "- Mobile Number\n";

                      showGradientDialog(
                        context,
                        "Fields Required",
                        errorMessage,
                        Colors.red, // Red neon color for warning
                      );
                    } else if (!isValidEmail(email.text)) {
                      // Show warning dialog for invalid email
                      showGradientDialog(
                        context,
                        "Invalid Email",
                        "Please enter a valid email address.",
                        Colors.red, // Red neon color for warning
                      );
                    } else if (!isValidMobile(mobile.text)) {
                      // Show warning dialog for invalid mobile number
                      showGradientDialog(
                        context,
                        "Invalid Mobile Number",
                        "Please enter a valid mobile number.",
                        Colors.red, // Red neon color for warning
                      );
                    } else {
                      doSignUp();
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
                        "Sign Up",
                        style: TextStyle(
                            color: AppColors.appActiveColor, fontSize: 20),
                      ),
                    ),
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: MaterialButton(
                  onPressed: () {},
                  child: Container(
                    height: 65,
                    width: width,
                    decoration: BoxDecoration(
                      color: AppColors.appBackgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                      border:
                          Border.all(color: AppColors.dividerColor, width: 1.5),
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
                            "Continue With Google",
                            style: TextStyle(
                                color: AppColors.appActiveColor, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
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

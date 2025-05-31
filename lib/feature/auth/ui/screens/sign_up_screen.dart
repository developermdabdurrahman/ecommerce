import 'package:ecommerce/feature/auth/data/model/sign_up_model.dart';
import 'package:ecommerce/feature/auth/ui/controller/sign_up_controller.dart';
import 'package:ecommerce/feature/auth/ui/screens/otp_verification_screen.dart'
    show OtpVerificationScreen;
import 'package:ecommerce/feature/auth/ui/widgets/app_logo.dart';
import 'package:ecommerce/core/extensions/app_localization_extension.dart';
import 'package:ecommerce/core/extensions/text_theme_extension.dart';
import 'package:ecommerce/core/widgets/show_snack_Bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static String name = '/signUp';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();

  SignUpController signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, forceMaterialTransparency: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  AppLogo(),
                  SizedBox(height: 16),
                  Text(
                    context.localization.completeProfile,
                    style: context.textTheme.titleLarge,
                  ),
                  Text(
                    context.localization.signUpdetails,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    controller: _firstNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: context.localization.firstName,
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: context.localization.lastName,
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: context.localization.email,
                    ),
                    validator: (value) {
                      String email = value ?? '';
                      RegExp regExp = RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
                      );
                      if (regExp.hasMatch(email) == false) {
                        return 'Enter your valid email';
                      }
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    controller: _mobileTEController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: context.localization.mobile,
                    ),
                    validator: (value) {
                      String phoneNumber = value ?? '';
                      RegExp regExp = RegExp(r'^(?:\+88|88)?01[3-9]\d{8}$');
                      if (regExp.hasMatch(phoneNumber) == false) {
                        return 'Enter your valid phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: context.localization.password,
                    ),
                    validator: (value) {
                      if ((value?.isEmpty ?? true) || value!.length < 6) {
                        return 'Enter a password more than 6 letters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    maxLines: 3,
                    controller: _addressTEController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      hintText: context.localization.address,
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  GetBuilder<SignUpController>(
                    builder: (controller) {
                      return controller.inProgress == true
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                oneTabSignUp();
                              }
                            },
                            child: Text(
                              context.localization.registration,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                    },
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> oneTabSignUp() async {
    SignUpModel user = SignUpModel(
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      email: _emailTEController.text.trim(),
      phone: _mobileTEController.text.trim(),
      password: _passwordTEController.text.trim(),
      deliveryAddress: _addressTEController.text.trim(),
    );

    bool isSuccess = await signUpController.signUp(user);
    if (isSuccess) {
      Navigator.popAndPushNamed(
        context,
        OtpVerificationScreen.name,
        arguments: _emailTEController.text.trim(),
      );
    } else {
      showSnackBarMessage(context, signUpController.errorMsg, true);
    }
  }
}

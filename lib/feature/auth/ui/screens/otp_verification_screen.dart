import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/feature/auth/data/model/verify_otp_model.dart';
import 'package:crafty_bay/feature/auth/ui/controller/otp_veriffication_controller.dart';
import 'package:crafty_bay/feature/auth/ui/widgets/app_logo.dart';
import 'package:crafty_bay/core/extensions/app_localization_extension.dart';
import 'package:crafty_bay/core/extensions/text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  static String name = '/OtpVerification';

  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _otpTEController = TextEditingController();

  OtpVerifyicationController otpVerifyicationController =
      Get.find<OtpVerifyicationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, forceMaterialTransparency: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              SizedBox(height: 120),
              AppLogo(),
              SizedBox(height: 16),
              Text(
                context.localization.enterOtp,
                style: context.textTheme.titleLarge,
              ),
              Text(
                context.localization.otpSent,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(height: 20),
              _buildPinCodeTextField(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GetBuilder<OtpVerifyicationController>(
                  builder: (controller) {
                    return controller.inProgress == true
                        ? Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              oneTabVerityOtp();
                            }
                          },
                          child: Text('Verify'),
                        );
                  },
                ),
              ),

              SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: context.localization.otpExpire,
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: '120s',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.themeColor,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  context.localization.resendCode,
                  style: TextStyle(color: AppColors.themeColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: _formkey,
        child: PinCodeTextField(
          length: 4,
          controller: _otpTEController,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 50,
            activeFillColor: Colors.white,
            selectedFillColor: AppColors.themeColor,
            inactiveFillColor: Colors.teal.shade50,
            activeColor: AppColors.themeColor,
            selectedColor: AppColors.themeColor,
            inactiveColor: Colors.white,
          ),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          appContext: context,
          onChanged: (value) {},
          validator: (value) {
            if ((value?.length ?? 0) < 4) {
              return 'Enter your otp';
            }
            return null;
          },
        ),
      ),
    );
  }

  Future<void> oneTabVerityOtp() async {
    VerifyOtpModel verifyOtpModel = VerifyOtpModel(
      email: widget.email,
      otp: _otpTEController.text,
    );
    bool isSuccess = await otpVerifyicationController.verify(verifyOtpModel);
    if (isSuccess) {
      Get.back();
    }
  }
}

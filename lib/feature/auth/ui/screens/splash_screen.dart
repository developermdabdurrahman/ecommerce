import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/app/app_config.dart';
import 'package:crafty_bay/feature/auth/ui/controller/auth_controller.dart';
import 'package:crafty_bay/feature/auth/ui/widgets/app_logo.dart';
import 'package:crafty_bay/feature/common/screens/main_botton_nav_screen.dart';
import 'package:crafty_bay/core/extensions/app_localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveNextScreen();
  }

  Future<void> _moveNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    await Get.find<AuthController>().getUserData();
    Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(),
              AppLogo(),
              Spacer(),
              CircularProgressIndicator(color: AppColors.themeColor),
              const SizedBox(height: 16),
              Text(
                '${context.localization.version}: ${AppConfigs.currentAppVersion}',
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

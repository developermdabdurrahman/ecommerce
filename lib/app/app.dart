
import 'package:ecommerce/app/app_color.dart';
import 'package:ecommerce/app/app_routes.dart';
import 'package:ecommerce/app/controller_binder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class CraftyBayApp extends StatelessWidget {
  const CraftyBayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      initialRoute: '/',
      onGenerateRoute: AppRoutes.onGenerateRoute,
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF161D1D),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF161D1D)),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF161D1D),
          selectedItemColor: AppColors.themeColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.themeColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
        colorSchemeSeed: AppColors.themeColor,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor,
            fixedSize: const Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.themeColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.themeColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.themeColor),
          ),
        ),
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('en'),
      supportedLocales: [Locale('en'), Locale('bn')],
    );
  }
}

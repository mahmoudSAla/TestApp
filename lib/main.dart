import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:testapp/utils/all_Controller_binding.dart';
import 'package:testapp/views/auth/change%20password/change_password_screen.dart';
import 'package:testapp/views/auth/login/login_screen.dart';
import 'package:testapp/views/auth/update%20profile/update_profile_screen.dart';
import 'package:testapp/views/home/home_screen.dart';
import 'package:testapp/views/intro%20screen/intro_screen.dart';

import 'views/auth/register/register_screen.dart';
import 'views/splash screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // set Status bar color in Android devices
      statusBarIconBrightness: Brightness.dark, // set Status bar icons color in Android devices
      statusBarBrightness: Brightness.dark, // set Status bar icon color in iOS
    )
    );
    return GetMaterialApp(
      initialBinding: AllControllerBinding(),

      getPages: [
        GetPage(name: "/", page: ()=> const IntroScreen()) ,
        GetPage(name: "/splash", page: ()=> const SplashScreen())  ,
        GetPage(name: "/register", page: ()=> const RegisterScreen())  ,
        GetPage(name: "/login", page: ()=> const LoginScreen())  ,
        GetPage(name: "/home", page: ()=> const HomeScreen())  ,
        GetPage(name: "/update_profile", page: ()=> const UpdateProfile())  ,
        GetPage(name: "/change_password", page: ()=> const ChangePasswordScreen())  ,
      ],

      title: "TestApp",
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      builder: (context , child){
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: child!);
      },
    );
  }
}





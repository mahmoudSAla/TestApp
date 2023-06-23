import 'package:flutter/material.dart';
import 'package:testapp/views/auth/login/body/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: LoginBody(),
      ),
    );
  }
}


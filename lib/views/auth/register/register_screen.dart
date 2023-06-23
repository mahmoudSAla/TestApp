import 'package:flutter/material.dart';
import 'package:testapp/views/auth/register/body/register_body.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: SafeArea(
        
        child: RegisterBody(),
        
      ),
    );
  }
}

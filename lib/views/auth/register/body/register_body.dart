// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:testapp/controllers/user_controller.dart';
import 'package:testapp/utils/constants.dart';
import 'package:testapp/utils/size_config.dart';
import 'package:testapp/views/auth/widgets/main_pass_field.dart';
import 'package:testapp/views/auth/widgets/main_phone_text_field.dart';
import 'package:testapp/views/auth/widgets/main_text_field.dart';
import 'package:testapp/views/widgets/button.dart';
import 'package:testapp/views/widgets/system_dialogs.dart';



class RegisterBody extends StatelessWidget {
   RegisterBody({Key? key}) : super(key: key);

  UserController  userController = Get.find<UserController>() ;

  final _formKey = GlobalKey<FormState>();
  final  TextEditingController email = TextEditingController() ;
  final  TextEditingController name = TextEditingController() ;
  final  TextEditingController phone = TextEditingController() ;
  final  TextEditingController confirmPassword = TextEditingController() ;
  final TextEditingController password = TextEditingController() ;
  final Map<String, dynamic> _formData = {
    'email': null ,
    'name': null,
    'phone': null,
    'country_code': null,
    'password': null,
    'password_confirm' : null ,

  };

  @override
  Widget build(BuildContext context) {
    void onSubmit() async {


      if (!_formKey.currentState!.validate()) {


        return;
      } else {
        _formKey.currentState!.save();


        var result = await userController.register(_formData);

        if (result['success']) {
          Get.offAllNamed("/home") ;
          SystemDialog.successSnakeBar(title: "Success" , message: "You have registered successfully") ;
        } else {
          SystemDialog.failSnakeBar(title: "Fail" , message: result['message']) ;

        }
      }


    }
    return SingleChildScrollView(
      child: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight! * .94,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset("assets/logo/ali_fouad_logo.png" ,width: getProportionateScreenWidth(120),) ,
                SizedBox(
                  height: getProportionateScreenHeight(8),
                ) ,
                Text("Register" , style: Constants.authHeader,)
              ],
            ) ,


            Form(
              key: _formKey,
              child: Column(
                children: [
                   MainTextField(
                    text: "Full Name",
                    controller: name ,
                     onSave: (String? value){
                      _formData['name'] == value ;
                     },
                     onChange: (String? value){
                      _formData['name'] = value ;
                     },
                     onValidate: (String? value){
                      if(value!.isEmpty){
                        return "Please eter your full name";
                      }
                      return null ;
                     },
                  ) ,

                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                   MainPhoneTextField(

                    controller: phone,
                     onSave: (PhoneNumber? value){
                      _formData['phone'] = value!.number ;
                      _formData['country_code'] = value.countryCode ;
                     },

                  ) ,
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                   MainTextField(
                    text: "Email Address",
                     controller: email,
                     onSave: (String? value){
                       _formData['email'] = value ;
                     },
                     onChange: (String? value){
                       _formData['email'] = value ;
                     },
                     onValidate: (String? value){
                       if(value!.isEmpty){
                         return "Please enter your email address"  ;
                       }else if(!RegExp(
                           r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.?[a-zA-Z]+)$')
                           .hasMatch(value)){
                         return "please enter valid email" ;
                       }

                       return null ;
                     },
                  ) ,
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  MainPassField(
                    width:  getProportionateScreenWidth(300),
                    hint: "          Password",
                    obscure: true,
                    controller: password,
                    onSave: (String? value){
                      _formData['password'] = value ;
                    },
                    onChange: (String? value){
                      _formData['password'] = value ;
                    },

                    onValidate: (String? value){
                      if(value!.isEmpty){
                        return "Please enter password" ;
                      }else if(value.length < 6 ){
                        return "password must have 6 or more letters or numbers" ;
                      }

                      return null ;
                    },
                  ) ,
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  MainPassField(
                    width:  getProportionateScreenWidth(300),
                    hint: "        Confirm password",
                    obscure: true,
                    controller: confirmPassword,
                    onSave: (String? value){
                      _formData['password_confirm'] = value ;
                    },
                    onChange: (String? value){
                      _formData['password_confirm'] = value ;
                    },
                    onValidate: (String? value){
                      if(value!.isEmpty){
                        return "Please enter password" ;
                      }else if(value.length < 6 ){
                        return "password must have 6 or more letters or numbers" ;
                      }else if(_formData['password'] != value){
                        return "please confirm the password" ;
                      }

                      return null ;
                    },
                  ) ,
                  SizedBox(
                    height: getProportionateScreenHeight(16),
                  ),

                  Obx((){
                    if(userController.isloading.value){
                      return const CircularProgressIndicator() ;
                    }else{
                      return MainButton(
                        text: "Register",
                        onTap: (){
                          onSubmit() ;
                        },
                      );
                    }
                  })
                ],
              ),
            ) ,

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? " , style: Constants.footerText,) ,
                GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, "/login") ;
                    },
                    child: Text("Login" , style: Constants.linkedFooterText,
                    )

                ) ,
              ],
            )
          ],
        ),
      ),
    );
  }
}



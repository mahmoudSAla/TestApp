// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:testapp/controllers/user_controller.dart';
import 'package:testapp/utils/size_config.dart';
import 'package:testapp/views/auth/register/body/register_body.dart';
import 'package:testapp/views/auth/widgets/main_phone_text_field.dart';
import 'package:testapp/views/auth/widgets/main_text_field.dart';
import 'package:testapp/views/widgets/button.dart';
import 'package:testapp/views/widgets/system_dialogs.dart';




class UpdateProfileBody extends StatelessWidget {
   UpdateProfileBody({Key? key}) : super(key: key);

  UserController  userController = Get.find<UserController>() ;

  final _formKey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController() ;
   TextEditingController name = TextEditingController() ;
   TextEditingController phone = TextEditingController() ;
  final Map<String, dynamic> _formData = {'email': null ,  'password': null};



  @override
  Widget build(BuildContext context) {
    String countryCode = '' ;
    name = TextEditingController(text: userController.user.value.name);
    email = TextEditingController(text: userController.user.value.email) ;

    if(userController.user.value.countryCode == "+971"){
      countryCode = "AE" ;
    }else{
      countryCode = "EG" ;
    }
    phone = TextEditingController(text: userController.user.value.phone) ;
    void onSubmit() async {


      if (!_formKey.currentState!.validate()) {


        return;
      } else {
        _formKey.currentState!.save();


        var result = await userController.updateUserDate(_formData);
        if (result['success']) {
          Get.offAllNamed("/home") ;
          SystemDialog.successSnakeBar(title: "Success" , message: "your info has been updated successfully") ;
        } else {
          SystemDialog.failSnakeBar(title: "Fail" , message: result['message']) ;
        }
      }


    }
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(getProportionateScreenHeight(24)),
        child: Form(
            key: _formKey,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainTextField(
              text: "Full Name",
              controller: name,
              onChange: (String? value){
                _formData['name']  = value;
              },
              onSave: (String? value){
                _formData['name']  = value;
              },
              onValidate: (String? value){
                if(value!.isEmpty){
                  return "Please enter your full name" ;
                }

                return null;
              },
            ) ,
            SizedBox(
              height: getProportionateScreenHeight(16),
            ) ,
            MainPhoneTextField(
              controller: phone,
              countryCode: countryCode,
              onSave: (PhoneNumber? value){
                _formData['phone'] = value!.number ;
                _formData['country_code'] = value.countryCode ;
              },
            ) ,
            SizedBox(
              height: getProportionateScreenHeight(16),
            ) ,
            MainTextField(
              text: "Email Address",
              controller: email,
              onSave: (String? value){
                _formData['email']  = value ;
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
              onChange: (String? value){
                _formData['email']  = value ;

              },

            ) ,
            SizedBox(
              height: getProportionateScreenHeight(24),
            ) ,
            Obx((){
              if(userController.isloading.value){
                return const CircularProgressIndicator() ;
              }else{
                return MainButton(
                  text: "Save",
                  onTap: (){
                    onSubmit() ;
                  },
                ) ;
              }
            })
          ],



        )),
      ),
    );
  }
}

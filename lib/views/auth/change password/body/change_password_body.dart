// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/user_controller.dart';
import 'package:testapp/utils/constants.dart';
import 'package:testapp/utils/size_config.dart';
import 'package:testapp/views/auth/widgets/main_pass_field.dart';
import 'package:testapp/views/widgets/button.dart';
import 'package:testapp/views/widgets/system_dialogs.dart';




class ChangePasswordBody extends StatelessWidget {
   ChangePasswordBody({Key? key}) : super(key: key);
  UserController  userController = Get.find<UserController>() ;

  final _formKey = GlobalKey<FormState>();
  TextEditingController currentPassword = TextEditingController() ;
  TextEditingController password = TextEditingController() ;
  TextEditingController confirmPassword = TextEditingController() ;
  final Map<String, dynamic> _formData = {'current_password': null ,  'password': null , "password_confirm" : null};


  @override
  Widget build(BuildContext context) {
    void onSubmit() async {


      if (!_formKey.currentState!.validate()) {


        return;
      } else {
        _formKey.currentState!.save();


        var result = await userController.changePassword(_formData);
        if (result['success']) {
          Get.offAllNamed("/home") ;
          SystemDialog.successSnakeBar(title: "Success" , message: "your password has been updated successfully") ;

        } else {
          SystemDialog.failSnakeBar(title: "Fail" , message: result['message']) ;

        }
      }


    }
    return SizedBox(
      width: SizeConfig.screenWidth ,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(getProportionateScreenHeight(24)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainPassField(
                hint: "       Current Password",
                width: getProportionateScreenWidth(300),
                obscure: true,
                controller: currentPassword,
                onChange: (String? value){
                  _formData['current_password'] = value ;
                },
                onSave:(String? value){
                  _formData['current_password'] = value ;
                } ,
                onValidate: (String? value){
                  if(value!.isEmpty){
                    return "Please your current password" ;
                  }else if(value.length < 6 ){
                    return "password must 6 letters or number or more";
                  }
                  return null ;
                },

              ) ,
              SizedBox(
                height: getProportionateScreenWidth(16),
              ) ,
              MainPassField(
                hint: "       new Password",
                width: getProportionateScreenWidth(300),
                obscure: true,
                controller: password,
                onChange: (String? value){
                  _formData['password'] = value ;
                },
                onSave:(String? value){
                  _formData['password'] = value ;
                } ,
                onValidate: (String? value){
                  if(value!.isEmpty){
                    return "Please your current password" ;
                  }else if(value.length < 6 ){
                    return "password must 6 letters or number or more";
                  }
                  return null ;
                },

              ) ,
              SizedBox(
                height: getProportionateScreenWidth(16),
              ) ,
              MainPassField(
                hint: "       Confirm Password",
                width: getProportionateScreenWidth(300),
                obscure: true,
                controller: confirmPassword,
                onChange: (String? value){
                  _formData['password_confirm'] = value ;
                },
                onSave:(String? value){
                  _formData['password_confirm'] = value ;
                } ,
                onValidate: (String? value){
                  if(value!.isEmpty){
                    return "Please your current password" ;
                  }else if(value.length < 6 ){
                    return "password must 6 letters or number or more";
                  }else if (_formData['password'] != value){
                    return "please confirm password" ;
                  }
                  return null ;
                },


              ) ,
              SizedBox(
                height: getProportionateScreenWidth(32),
              ) ,

              Obx((){
                if(userController.isloading.value){
                  return const CircularProgressIndicator() ;
                }else{
                  return  MainButton(
                    text: "Save",
                    onTap: (){

                      onSubmit() ;
                    },
                  ) ;
                }
              })

            ],
          ),
        ),
      ),
    );
  }
}


// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/user_controller.dart';
import 'package:testapp/utils/constants.dart';
import 'package:testapp/utils/size_config.dart';
import 'package:testapp/views/auth/widgets/main_pass_field.dart';
import 'package:testapp/views/auth/widgets/main_text_field.dart';
import 'package:testapp/views/widgets/button.dart';
import 'package:testapp/views/widgets/system_dialogs.dart';







class LoginBody extends StatelessWidget {
   LoginBody({Key? key}) : super(key: key);

   UserController  userController = Get.find<UserController>() ;

  final _formKey = GlobalKey<FormState>();
  final  TextEditingController email = TextEditingController() ;
  final TextEditingController password = TextEditingController() ;
  final Map<String, dynamic> _formData = {'email': null ,  'password': null};



  @override
  Widget build(BuildContext context) {
    void onSubmit() async {


      if (!_formKey.currentState!.validate()) {


        return;
      } else {
        _formKey.currentState!.save();


        var result = await userController.login(_formData);
        if (result['success']) {
          SystemDialog.successSnakeBar(title: "Success" , message: "You have logged in successfully" );
          Get.offAllNamed("/home") ;
        } else {

          SystemDialog.failSnakeBar(title: "Fail" , message: result['message']) ;

        }
      }


    }
    return SingleChildScrollView(
      child: SizedBox(
        width: SizeConfig.screenWidth,
        height:  SizeConfig.screenHeight! *0.94,
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
                Text("Login" , style: Constants.authHeader,)
              ],
            ) ,
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),


            Form(
              key: _formKey,
              child: Column(
                children: [
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
                    hint: "        Password",
                    obscure: true,
                    controller:
                    password,
                    onValidate: (String? value){
                      if(value!.isEmpty){
                        return "please enter password" ;
                      }else if(value.length < 6 ){
                        return "password must be 6 or more letters or numbers" ;
                      }

                      return null ;
                    },
                    onChange: (String? value){
                      _formData['password'] = value ;
                    },
                    onSave: (String? value){
                      _formData['password'] = value ;
                    },
                  ) ,
                  SizedBox(
                    height: getProportionateScreenHeight(16),
                  ),

                  Obx((){
                    if(userController.isloading.value){
                      return const CircularProgressIndicator() ;
                    }else{
                      return  MainButton(
                        text: 'Login' ,
                        onTap: (){
                          onSubmit() ;
                        },

                      ) ;
                    }
                  })
                ],
              ),
            ) ,

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have account? " , style: Constants.footerText,) ,
                GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, "/register") ;
                    },
                    child: Text("Register" , style: Constants.linkedFooterText,
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

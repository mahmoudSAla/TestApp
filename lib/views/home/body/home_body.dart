// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/user_controller.dart';
import 'package:testapp/utils/constants.dart';
import 'package:testapp/utils/size_config.dart';
import 'package:testapp/views/home/widgets/home_text_icon.dart';
import 'package:testapp/views/home/widgets/profile_button.dart';
import 'package:testapp/views/widgets/system_dialogs.dart';

class HomeBody extends StatelessWidget {
   HomeBody({Key? key}) : super(key: key);
  final controller = Get.find<UserController>() ;

  @override
  Widget build(BuildContext context) {
    DateTime? lastPressed;

    return WillPopScope(
      onWillPop: ()async{
        final now = DateTime.now();
        const maxDuration =  Duration(seconds: 2);
        final isWarning =
            lastPressed == null || now.difference(lastPressed!) > maxDuration;
        if (isWarning) {
          lastPressed = DateTime.now();
          final snackBar = SnackBar(
            backgroundColor: Constants.kMainDarkBlue,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "click again to close the app",
                  style: TextStyle(
                    fontWeight: FontWeight.bold ,
                    fontSize: getProportionateScreenHeight(14) ,
                    fontFamily: "Alexandria" ,

                  ),

                ),
              ],
            ) ,
            duration: maxDuration ,);

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar) ;
          return false ;
        }else{
          exit(0) ;

        }
      },
      child: SizedBox(
        width: SizeConfig.screenWidth,
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                if(controller.isloading.value){
                  return const CircularProgressIndicator() ;
                }else{
                  return Column(
                    children: [
                      HomeTextIcon(
                        title: "${controller.user.value.name}" ,
                        icon: Icons.person_4_outlined,
                      ) ,
                      SizedBox(
                        height: getProportionateScreenHeight(16),
                      ) ,
                      HomeTextIcon(
                        title: "${controller.user.value.countryCode} ${controller.user.value.phone}",
                        icon: Icons.phone_android_outlined,
                      ) ,
                      SizedBox(
                        height: getProportionateScreenHeight(16),
                      ) ,
                      HomeTextIcon(
                        title: "${controller.user.value.email}",
                        icon: Icons.mail,
                      ) ,
                      SizedBox(
                        height: getProportionateScreenHeight(32),
                      ) ,
                    ],
                  ) ;
                }
              }),

              ProfileButton(
                onTap: (){Navigator.pushNamed(context, "/update_profile");},
                title: "Update Profile",

              ) ,
              SizedBox(
                height: getProportionateScreenHeight(16),
              ) ,
              ProfileButton(
                onTap: (){Navigator.pushNamed(context, "/change_password"); },
                title: "Change Password",

              ) ,
              SizedBox(
                height: getProportionateScreenHeight(16),
              ) ,
              ProfileButton(
                onTap: ()async{

                  SystemDialog.confirmDialog(context , title: "Warring!" , message: "Are you sure to delete this account?" , onOk: ()async{
                    var result  = await controller.deleteUser() ;
                    if(result['success']){
                      Get.offAllNamed("/splash") ;
                      SystemDialog.successSnakeBar(title: "Success" , message: "Your account has been deleted successfully") ;
                    }else{
                      SystemDialog.failSnakeBar(title: "Fail" , message: result['message']) ;
                    }
                  }) ;

                },
                title: "Delete Account",

              ) ,
              SizedBox(
                height: getProportionateScreenHeight(16),
              ) ,
              ProfileButton(
                onTap: (){
                  SystemDialog.confirmDialog(context ,
                    title: "Warring!" ,
                    message: "Are you sure you want to logout?" ,
                    onOk: ()async{
                      await controller.logOut() ;
                      Get.offAllNamed("/splash") ;
                    }
                  ) ;
                },
                title: "Logout",
              ) ,

            ],
          ),
        ),
      ),
    );
  }
}






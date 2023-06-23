import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/utils/constants.dart';


class SystemDialog {



  static Future<AwesomeDialog> confirmDialog(BuildContext context, {String? title , message , Function? onOk})async{
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.scale,
        title: title!,
        headerAnimationLoop: false,
        //customHeader: Image.asset("assets/icons/icons8-home-96.png"),

        desc: '$message',

        btnOkOnPress: () => onOk!(),
        btnOkColor: Constants.kMainDarkBlue ,
        btnOkText: "confirm" ,
        btnCancelText: "close",
        btnCancelOnPress: (){} , 
        buttonsTextStyle: Constants.buttonText ,
        titleTextStyle: Constants.authHeader ,
        descTextStyle: Constants.footerText

    )..show();
  }



  static Future<SnackbarController> successSnakeBar( {String? title , message})async{
    return Get.snackbar(
      "Success",
      "$message",
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      borderRadius: 10,
      backgroundColor:  Colors.green ,

    );
  }
  static Future<SnackbarController> failSnakeBar( {String? title , message})async{
    return Get.snackbar(
      "Fail",
      "$message",
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      borderRadius: 10,
      backgroundColor:  Colors.red ,

    );
  }

  
  
  
}
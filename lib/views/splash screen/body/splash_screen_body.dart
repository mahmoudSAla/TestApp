import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/utils/constants.dart';
import 'package:testapp/utils/size_config.dart';
import 'package:testapp/views/widgets/button.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()async{
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
      } ,
      child: SizedBox(
        width: SizeConfig.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // SizedBox(
            //   height: getProportionateScreenHeight(40),
            // ) ,
            Column(
              children: [
                Image.asset("assets/logo/ali_fouad_logo.png" ,width: getProportionateScreenWidth(120),) ,
                SizedBox(
                  height: getProportionateScreenHeight(8),
                ) ,
                Text("Welcome to the app" , style: Constants.authHeader,)
              ],
            ) ,
            SizedBox(
              height: getProportionateScreenHeight(24),
            ),

            Column(
              children: [
                MainButton(
                  text: "Login",
                  onTap: (){
                    Get.toNamed("/login") ;
                    // Navigator.pushNamed(context, "/login");
                  },
                ) ,
                SizedBox(
                  height: getProportionateScreenHeight(8),
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed("/register") ;


                  },
                  child: Container(
                    width: getProportionateScreenWidth(300),
                    padding: EdgeInsets.all(getProportionateScreenHeight(20)),
                    decoration: BoxDecoration(
                        color: Constants.kMainWhite ,
                        borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
                        border: Border.all(
                            color: Constants.kMainDarkBlue
                        )

                    ),
                    child: Center(
                      child: Text("Register" , style: Constants.darkButtonText,),
                    ),
                  ) ,
                )
              ],
            ) ,


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Designed and Developed by " , style: Constants.footerText,) ,
                Text("Ali Fouad" , style: Constants.linkedFooterText,

                ) ,
              ],
            )
          ],
        ),
      ),
    );
  }
}

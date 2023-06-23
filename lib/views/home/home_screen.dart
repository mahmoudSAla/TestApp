import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/utils/constants.dart';
import 'package:testapp/utils/size_config.dart';
import 'package:testapp/views/home/body/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Constants.kMainDarkBlue,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ) ,
        backgroundColor: Constants.kMainDarkBlue,

        title: Text("Home Page" , style: TextStyle(
          color: Constants.kMainWhite ,
          fontSize: getProportionateScreenHeight(20) ,
          fontWeight: FontWeight.bold ,
          fontFamily: "Alexandria" ,
        ),),
        foregroundColor: Constants.kMainDarkBlue,

      ),

      body:  HomeBody(),

    );
  }
}

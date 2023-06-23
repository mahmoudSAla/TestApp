

// ignore_for_file: constant_identifier_names


import 'package:flutter/material.dart';

import 'size_config.dart';


///
///


//awesome_dialog 3.1.0
//

///
///
class Constants {

  static const String BASE_URL = "https://testapi.alifouad91.com";


  static get kMainWhite => const Color(0xffFFFFFF);

  static get kMainGray => const Color(0xffAAAAAA);

  static get kMainDarkBlue => const Color(0xff370A45);

  static get kMainBlack => const  Color(0xff1E2929) ;




  static get authHeader =>
      TextStyle(
          color: Constants.kMainDarkBlue ,
          fontSize: getProportionateScreenHeight(30) ,
          fontFamily: "Alexandria" ,
          fontWeight: FontWeight.bold

      );



  static get buttonText => TextStyle(
      color: Constants.kMainWhite ,
      fontWeight: FontWeight.bold ,
      fontFamily: "Alexandria" ,
      fontSize: getProportionateScreenHeight(20)
  ) ;



  static get darkButtonText => TextStyle(
      color: Constants.kMainDarkBlue ,
      fontWeight: FontWeight.bold ,
      fontFamily: "Alexandria" ,
      fontSize: getProportionateScreenHeight(20)
  ) ;


  static get footerText => TextStyle(
      color: Constants.kMainBlack ,
      fontSize: getProportionateScreenHeight(16) ,
      fontFamily: "Alexandria" ,
      fontWeight: FontWeight.w500
  ) ;

  static get linkedFooterText => TextStyle(
  color: Constants.kMainDarkBlue ,
  fontSize: getProportionateScreenHeight(16) ,
  fontFamily: "Alexandria" ,
  fontWeight: FontWeight.w800 ,
  decoration: TextDecoration.underline
  ) ;


  static get profileButton => TextStyle(
    color: Constants.kMainDarkBlue ,
    fontFamily: "Alexandria" ,
    fontSize: getProportionateScreenHeight(22) ,
    fontWeight: FontWeight.bold ,

  );

  static get homeTextIon => TextStyle(
      fontFamily: "Alexandria" ,
      color: Constants.kMainGray ,
      fontWeight: FontWeight.bold ,
      fontSize: getProportionateScreenHeight(22) ,
      overflow: TextOverflow.fade
  ) ;


  }
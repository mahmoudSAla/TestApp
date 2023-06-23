import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/utils/constants.dart';
import 'package:testapp/utils/size_config.dart';
import 'package:testapp/views/auth/update%20profile/body/update_profile_body.dart';


class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Constants.kMainDarkBlue,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ) ,
        backgroundColor: Constants.kMainDarkBlue,
        title: Text("Update_profile" , style: TextStyle(
          color: Constants.kMainWhite ,
          fontSize: getProportionateScreenHeight(20) ,
          fontWeight: FontWeight.bold ,
          fontFamily: "Alexandria" ,
        ),),
        foregroundColor: Constants.kMainWhite,


      ),

  body:  UpdateProfileBody(),
    );
  }
}

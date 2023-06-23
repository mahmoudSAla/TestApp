

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:testapp/utils/constants.dart';
import 'package:testapp/utils/size_config.dart';

class MainPhoneTextField extends StatelessWidget {
  final String? countryCode ;
  final Function(PhoneNumber?)? onSave ;

  final TextEditingController? controller;

  const MainPhoneTextField({
    super.key, this.onSave, this.controller, this.countryCode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(300),
      // height: getProportionateScreenHeight(40),

      child: IntlPhoneField(
        controller: controller,
        showDropdownIcon: true,




        decoration:  InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
                borderSide:  BorderSide(color: Constants.kMainDarkBlue)
            ),

            hintText: 'PhoneNumber' ,

            contentPadding:  EdgeInsets.symmetric(vertical:8 ,horizontal: getProportionateScreenWidth(20) ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
                borderSide:  BorderSide(color: Constants.kMainDarkBlue)
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
                borderSide:  BorderSide(color: Constants.kMainDarkBlue)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
                borderSide:  BorderSide(color: Constants.kMainDarkBlue)
            ),

            hintStyle:  TextStyle(
                color: Constants.kMainGray,
                fontFamily: 'Alexandria' ,
                fontWeight: FontWeight.bold ,
                height: 1.4,
                fontSize: getProportionateScreenHeight(18)
            )
        ),
        // disableLengthCheck: true,
        initialCountryCode: countryCode??"AE",
        onSaved: (value) => onSave!(value),
      ),
    );
  }
}


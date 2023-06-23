
import 'package:flutter/material.dart';
import 'package:testapp/utils/constants.dart';
import 'package:testapp/utils/size_config.dart';

class MainTextField extends StatelessWidget {
  final String? text ;
  final TextEditingController? controller ;
  final Function(String?)? onSave ;
  final Function(String?)? onChange ;
  final Function(String?)? onValidate ;

  const MainTextField({
    super.key, this.text, this.onSave, this.onChange, this.onValidate, this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(300),
      child: TextFormField(
        textAlign: TextAlign.center,

        controller: controller,
        validator: (value) => onValidate!(value),
        onSaved: (value) => onSave!(value),
        onChanged: (value) => onChange!(value),

        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16 , horizontal: getProportionateScreenWidth(10)) ,

          alignLabelWithHint: true,
          hintText: text ,
          hintStyle: TextStyle(
              color: Constants.kMainGray ,
              fontFamily: "Alexandria" ,
              fontWeight: FontWeight.bold ,
              fontSize: getProportionateScreenHeight(18)


          ) ,


          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
            borderSide: BorderSide(
              color: Constants.kMainDarkBlue ,

            ) ,


          ) ,


          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
            borderSide: BorderSide(
              color: Constants.kMainDarkBlue ,

            ) ,


          ) ,
          disabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
            borderSide: BorderSide(
              color: Constants.kMainDarkBlue ,

            ) ,


          ) ,
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
            borderSide: BorderSide(
              color: Constants.kMainDarkBlue ,

            ) ,


          ) ,


        ),
      ),
    );
  }
}
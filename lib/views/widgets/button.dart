import 'package:flutter/material.dart';
import 'package:testapp/utils/constants.dart';
import 'package:testapp/utils/size_config.dart';




class MainButton extends StatelessWidget {
  final String ? text ;
  final Function? onTap ;
  const MainButton({Key? key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onTap!(),
      child: Container(
        width: getProportionateScreenWidth(300),
        padding: EdgeInsets.all(getProportionateScreenHeight(20)),
        decoration: BoxDecoration(
          color: Constants.kMainDarkBlue ,
          borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,

        ),
        child: Center(
          child: Text("$text" , style: Constants.buttonText,),
        ),
      ),
    );
  }
}

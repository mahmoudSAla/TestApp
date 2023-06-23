
import 'package:flutter/material.dart';
import 'package:testapp/utils/constants.dart';
import 'package:testapp/utils/size_config.dart';

class HomeTextIcon extends StatelessWidget {
  final String title ;
  final IconData icon ;
  const HomeTextIcon({
    super.key, required this.title,  required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon , color: Constants.kMainDarkBlue, size: getProportionateScreenHeight(38),)  ,
        SizedBox(
          width: getProportionateScreenWidth(10),
        ) ,
        SizedBox(
          width: getProportionateScreenWidth(280),
          child: Text(title , style: Constants.homeTextIon,),
        )
      ],
    );
  }
}

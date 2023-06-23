import 'package:flutter/material.dart';
import 'package:testapp/utils/constants.dart';
import 'package:testapp/utils/size_config.dart';

class ProfileButton extends StatelessWidget {
  final String title ;

  final Function onTap ;
  const ProfileButton({
    super.key, required this.title,  required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title ,style: Constants.profileButton,) ,
              Icon(Icons.arrow_forward_ios_outlined , size: getProportionateScreenHeight(30),color: Constants.kMainDarkBlue,)
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(8),
          ),
          Divider(
            color: Constants.kMainGray,
          )
        ],
      ),
    );
  }
}
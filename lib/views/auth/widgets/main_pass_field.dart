
import 'package:flutter/material.dart';
import 'package:testapp/utils/constants.dart';
import 'package:testapp/utils/size_config.dart';



class MainPassField extends StatefulWidget {



  final String? hint ;
  final double? width ;
  final TextEditingController? controller ;
  final Function(String?)? onValidate ;
  final Function(String?)? onSave ;
  final Function(String?)? onChange;
  final bool ? obscure ; 
  const MainPassField({Key? key, this.hint, this.width, this.controller, this.onValidate, this.onSave, this.onChange, this.obscure}) : super(key: key);

  @override
  State<MainPassField> createState() => _MainPassFieldState();
}

class _MainPassFieldState extends State<MainPassField> {
  bool hide = true ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hide = widget.obscure! ;
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width : widget.width??getProportionateScreenWidth(140),

      child:TextFormField(
        textAlign: TextAlign.center,
        controller: widget.controller,
        obscureText: hide,
        validator: (value) => widget.onValidate!(value),
        onChanged: (value)=> widget.onChange!(value),
        onSaved: (value) => widget.onSave!(value),
        decoration: InputDecoration(
            hintText: widget.hint??"" ,
            hintStyle:TextStyle(
                color: Constants.kMainGray,
                fontFamily: 'Alexandria' ,
                fontWeight: FontWeight.bold ,
                height: 1.4,
                fontSize: getProportionateScreenHeight(18)
            ),
            // errorStyle: Constants.errorText,
            filled: true ,
            suffixIcon: GestureDetector(
              onTap: (){
                if(hide){
                  setState(() {
                    hide = false ;
                  });
                }else{
                  setState(() {
                    hide = true ;
                  });
                }
              },
              child: hide ?const Icon(Icons.visibility_off_outlined , size: 20,) : const Icon(Icons.remove_red_eye_outlined , size: 20,),
            ),
            fillColor: Constants.kMainWhite ,

            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
                borderSide:  BorderSide(color: Constants.kMainDarkBlue)
            ),

            contentPadding: EdgeInsets.symmetric(vertical: 0 , horizontal: getProportionateScreenWidth(10)) ,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
                borderSide:  BorderSide(color: Constants.kMainDarkBlue)
            ),
            disabledBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
                borderSide:  BorderSide(color: Constants.kMainDarkBlue)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)) ,
                borderSide:  BorderSide(color: Constants.kMainDarkBlue)
            )
        ),
      ),
    );
  }
}

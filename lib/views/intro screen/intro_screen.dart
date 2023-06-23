import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/user_controller.dart';
import 'package:testapp/utils/size_config.dart';



class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 2) , ()async{
      UserController controller = Get.find<UserController>() ;

      await controller.getVisitFirstTime();
      await controller.autoAuthenticated();

      if(controller.visitFirstTime.value){
        await controller.storeVisitFirstTime();

        Get.toNamed("/splash") ;
      }else{
        if(controller.isAuthenticated.value){
            await controller.getUser() ;
            Get.offAllNamed("/home") ;
        }else{
          Get.toNamed("/splash") ;

        }
      }
    }) ;
    
    
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo/ali_fouad_logo.png" , width: getProportionateScreenWidth(140),)
            ],
          ),
        ),
      ),
    );
  }
}




import 'package:get/get.dart';
import 'package:testapp/controllers/user_controller.dart';

class AllControllerBinding implements Bindings {


  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<UserController>(UserController()) ;
  }
}
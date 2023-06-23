// ignore_for_file: library_prefixes

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as Get;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/models/use_model.dart';

import '../services/http_service_impl.dart';

import 'package:http/http.dart' as http;


class UserController extends Get.GetxController{
  late SharedPreferences _preferences;
  Get.RxBool isAuthenticated = false.obs ;
  Get.RxBool visitFirstTime = true.obs;


  Get.RxBool isloading  = false.obs ;

  final HttpServiceImpl httpService = HttpServiceImpl();
  Get.RxBool unAuth = true.obs;

  Get.Rx<UserModel> user = UserModel(

      ).obs ;
  Future<void> getVisitFirstTime() async {
    _preferences = await SharedPreferences.getInstance();
    visitFirstTime =
        Get.RxBool(_preferences.getBool('firstTime')??true)  ;

    // ignore: unnecessary_null_comparison
    if (visitFirstTime == null) {
      storeVisitFirstTime();
      visitFirstTime(true);
    }
  }
  Future<void> storeVisitFirstTime() async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setBool('firstTime', false);
  }
  Future<void> autoAuthenticated() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isAuthenticated1;
    preferences.getBool('userExistence') != null
        ? isAuthenticated1 = preferences.getBool('userExistence')!
        : isAuthenticated1 = false;
    if (isAuthenticated1) {
      var user = preferences.getString('user');
      if (user != null) {
        this.user = Get.Rx<UserModel>(UserModel.fromJson(json.decode(user)));
        isAuthenticated(true);
      } else {
        isAuthenticated(false);
      }
    } else {
      return;
    }
  }

  Future<void> storeAuthUser(UserModel? user, String token,
      [isAuth = false]) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (isAuth) {
      preferences.setBool('userExistence', true);
      Map<String, dynamic> userMap = user!.toJson();
      if (token != '') {
        try{
          preferences.setString('authToken', token);

        }catch (e){
          if(kDebugMode){
            print(e);
          }
        }
      }
      preferences.setString('user', jsonEncode(userMap));
    } else {
      preferences.remove('user');
      preferences.remove('userExistence');
      preferences.remove('authToken');
      preferences.remove('checkUserSubscription');
    }
  }

  Future<Map<String, dynamic>> getUser() async {
    Map<String, dynamic> result = {
      'success': false,
      'error': null,
      'message': null
    };

    // isloading(true) ;

    String url = '/user/${user.value.id} ';
    httpService.init();
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final token = sharedPreferences.getString('authToken');
      http.StreamedResponse response = await httpService.getRequest(url, token ?? '');
      var data = json.decode(await response.stream.bytesToString()) ;

      if (response.statusCode == 200 ) {
        user = Get.Rx<UserModel>(UserModel.fromJson(data['data'])) ;

        result['success'] = true  ;
      } else {
        result['success'] = false  ;
        result['message'] = data['message'] ;
      }
    } catch (error) {
      result['message'] = error;
    }
    // isloading(false) ;
    return result;
  }
  Future<Map<String, dynamic>> login(formData) async {
    Map<String, dynamic> result = {
      'success': false,
      'error': null,
      'message': null
    };


    Map<String , String> userData = {
      'email': formData['email'],
      'password': formData['password']
    } ;

    isloading(true) ;

    String url = '/login';
    httpService.init();
    try {

      http.StreamedResponse response = await httpService.postRequest(url, userData, '' );
        // print(await response.stream.bytesToString());
        var data = json.decode(await response.stream.bytesToString()) ;


        if (response.statusCode == 200 ) {

        user = Get.Rx<UserModel>(UserModel.fromJson(data['data'])) ;

        String token = user.value.token! ;
        storeAuthUser(user.value, token.toString() , true) ;
        isAuthenticated(true) ;
        result['success'] = true  ;
      } else {
        isAuthenticated(false) ;
        result['success'] = false  ;
        result['message'] = data['message'] ;
        // result['message'] = response.data['message'] ;
      }
    } catch (error) {
      result['message'] = error;
    } finally{
      isloading(false) ;

    }
    return result;
  }
  Future<Map<String, dynamic>> register(formData) async {
    Map<String, dynamic> result = {
      'success': false,
      'error': null,
      'message': null
    };


    Map<String , String> userData = {
      'email': formData['email'],
      'password': formData['password'] ,
      "name" : formData['name'] ,
      "phone" : formData['phone'] ,
      "country_code" : formData['country_code'] ,
      'password_confirm' : formData['password_confirm']
    } ;

    isloading(true) ;

    String url = '/user/register';
    httpService.init();
    try {

      http.StreamedResponse response = await httpService.postRequest(url, userData, '' );
        // print(await response.stream.bytesToString());
        var data = json.decode(await response.stream.bytesToString()) ;

        if (response.statusCode == 201 ) {

        user = Get.Rx<UserModel>(UserModel.fromJson(data['data'])) ;

        String token = user.value.token! ;
        storeAuthUser(user.value, token.toString() , true) ;
        isAuthenticated(true) ;
        result['success'] = true  ;

      } else {
        isAuthenticated(false) ;
        result['success'] = false  ;
        result['message'] = data['message'] ;
      }
    } catch (error) {
      result['message'] = error;
    } finally{
      isloading(false) ;

    }
    return result;
  }
  Future<Map<String, dynamic>>  updateUserDate(formData) async {
    Map<String, dynamic> result = {
      'success': false,
      'error': null,
      'message': null
    };


    Map<String , String> userData = {
      'email': formData['email'],
      "name" : formData['name'] ,
      "phone" : formData['phone'] ,
      "country_code" : formData['country_code'] ,

    } ;

    isloading(true) ;

    String url = '/user/update';
    httpService.init();
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final token = sharedPreferences.getString('authToken');
      http.StreamedResponse response = await httpService.postRequest(url, userData, token??'' );
        // print(await response.stream.bytesToString());
        var data = json.decode(await response.stream.bytesToString()) ;

        if (response.statusCode == 200 ) {

        result['success'] = true  ;

      } else {
        isAuthenticated(false) ;
        result['success'] = false  ;
        result['message'] = data['message'] ;
      }
    } catch (error) {
      result['message'] = error;
    } finally{
      isloading(false) ;

    }
    return result;
  }
  Future<Map<String, dynamic>>  changePassword(formData) async {
    Map<String, dynamic> result = {
      'success': false,
      'error': null,
      'message': null
    };


    Map<String , String> userData = {
      'current_password': formData['current_password'],
      "password" : formData['password'] ,
      "password_confirm" : formData['password_confirm'] ,

    } ;

    isloading(true) ;

    String url = '/user/changepassword';
    httpService.init();
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final token = sharedPreferences.getString('authToken');
      http.StreamedResponse response = await httpService.postRequest(url, userData, token??'' );
        // print(await response.stream.bytesToString());
      var data = json.decode(await response.stream.bytesToString()) ;


        if (response.statusCode == 200 ) {


        isAuthenticated(true) ;
        result['success'] = true  ;

      } else {
        isAuthenticated(false) ;
        result['success'] = false  ;
        result['message'] = data['message'] ;
      }
    } catch (error) {
      result['message'] = error;
    } finally{
      isloading(false) ;

    }
    return result;
  }
  Future<Map<String, dynamic>>  deleteUser() async {
    Map<String, dynamic> result = {
      'success': false,
      'error': null,
      'message': null
    };



    isloading(true) ;

    String url = '/user/delete';
    httpService.init();
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final token = sharedPreferences.getString('authToken');
      http.StreamedResponse response = await httpService.deleteRequest(url, token??'' );
        // print(await response.stream.bytesToString());
      var data = json.decode(await response.stream.bytesToString()) ;


        if (response.statusCode == 200 ) {
          result['message'] = data['message'] ;

        isAuthenticated(true) ;
        result['success'] = true  ;

      } else {
        isAuthenticated(false) ;
        result['success'] = false  ;
        result['message'] = data['message'] ;
      }
    } catch (error) {
      result['message'] = error;
    } finally{
      isloading(false) ;

    }
    return result;
  }



  logOut()async{
    user = Get.Rx<UserModel>(UserModel()) ;
    isAuthenticated(false) ;
    await storeAuthUser(user.value, "" , false) ;
}
}


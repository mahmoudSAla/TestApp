// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables


import 'package:flutter/foundation.dart';
import 'package:testapp/utils/constants.dart';
import 'package:http/http.dart' as http;



import 'http_service.dart';

String  baseUrl = '${Constants.BASE_URL}/api';
late var headers ;
//const baseUrl = 'http://10.0.2.2:8000/api';
const appTOKEN = '';

const List<String> allowedSHAFingerprints = [
];

class HttpServiceImpl implements HttpService {

  @override
  Future<http.StreamedResponse> getRequest(String url, token ) async {
    var request = http.MultipartRequest('GET', Uri.parse(baseUrl+url));

    request.headers.addAll(headers);
    request.headers.addAll({
      'Authorization': 'Bearer $token',
    }) ;
    http.StreamedResponse response = await request.send();

    return response;
  }


  @override
  Future<http.StreamedResponse> deleteRequest(String url, token ) async {
    var request = http.MultipartRequest('DELETE', Uri.parse(baseUrl+url));

    request.headers.addAll(headers);
    request.headers.addAll({
      'Authorization': 'Bearer $token',
    }) ;
    http.StreamedResponse response = await request.send();

    return response;
  }

  @override
  Future<http.StreamedResponse> postRequest(String url, postData, token) async {
     late http.StreamedResponse response ;
      try{
        var request = http.MultipartRequest('POST', Uri.parse(baseUrl+url));
        request.fields.addAll(postData);
        request.headers.addAll(headers);
        request.headers.addAll({
          'Authorization': 'Bearer $token',
        }) ;

       response = await request.send();
        //
        // print(await response.stream.bytesToString());
      }catch(e){
          if(kDebugMode){
            print(e) ;
          }
      }
      return response ;
  }



  @override
  void init() {
       headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json' ,

  };

  }
}

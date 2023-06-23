import 'package:http/http.dart' as http;

abstract class HttpService {
  void init();

  Future<http.StreamedResponse> getRequest(String url, String token);
  Future<http.StreamedResponse> deleteRequest(String url, String token);
  Future<http.StreamedResponse> postRequest(String url, Map<String , String> postData, String token);
}

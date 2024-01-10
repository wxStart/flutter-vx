import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;

enum HttpMethod {
  GET,
  POST,
}

class HttpManager {
  static Dio? _dioInstance;

  static Dio _getDioInstance() {
    // if (_dioInstance == null) {
    //   _dioInstance = Dio();
    // }
    _dioInstance ??= Dio();
    return _dioInstance!;
  }

  static Future<Response> get(String url, {dynamic data}) {
    return _sendRequest(HttpMethod.GET, url, data: data);
  }

  static Future<Response> post(String url, {dynamic data}) {
    return _sendRequest(HttpMethod.POST, url, data: data);
  }

  static Future<Response> _sendRequest(
    HttpMethod method,
    String url, {
    dynamic data,
  }) {
    try {
      switch (method) {
        case HttpMethod.GET:
          return _getDioInstance().get(url, queryParameters: data);
        case HttpMethod.POST:
          return _getDioInstance().post(url, data: data);
        default:
          throw Exception("请求方式错误");
      }
    } on DioException catch (e) {
      print(e.message);
      return Future.error(e);
    } on Exception catch (e) {
      print(e.toString());
      return Future.error(e);
    }
  }
}

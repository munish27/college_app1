import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/data/api/api_endpoints.dart';
import 'package:dio/dio.dart';

enum RequestType { GET, POST, PUT, DELETE }

enum RequestFormat { FORMDATA, JSON }

class ApiProvider {
  Future<Response> performCall({
    required String url,
    Map<String, dynamic>? request,
    required RequestType requestType,
    required RequestFormat requestFormat,
    required bool shouldRetry,
    required bool isAuthorized,
  }) async {
    Response _response;

    final _usertype = await MyPreference().getUserType();
    late String _baseUrl;
    if (_usertype == 0) {
      _baseUrl = ApiEndpoints.ADMIN_BASE_URL;
    } else if (_usertype == 1) {
      _baseUrl = ApiEndpoints.STAFF_BASE_URL;
    } else {
      _baseUrl = ApiEndpoints.STUDENT_BASE_URL;
    }

    print('url is $_baseUrl');

    final dio = Dio(BaseOptions(baseUrl: _baseUrl));

    try {
      switch (requestType) {
        case RequestType.GET:
          if (request != null && request.isNotEmpty) {
            _response = await dio.get(url, queryParameters: request);
          } else {
            _response = await dio.get(url);
          }
          break;
        case RequestType.POST:
          if (request != null && request.isNotEmpty) {
            _response = await dio.post(url, data: request);
          } else {
            _response = await dio.post(url);
          }
          break;
        case RequestType.PUT:
          if (request != null && request.isNotEmpty) {
            _response = await dio.put(url, data: request);
          } else {
            _response = await dio.put(url);
          }
          break;
        case RequestType.DELETE:
          if (request != null && request.isNotEmpty) {
            _response = await dio.delete(url, data: request);
          } else {
            _response = await dio.delete(url);
          }
          break;
      }
    } catch (e) {
      rethrow;
    }
    return _response;
  }
}

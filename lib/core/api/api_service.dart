import 'package:bestforming_cac/core/api/api_constant.dart';
import 'package:dio/dio.dart';

import 'api_client.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<dynamic> getData({
    required int headerType,
    required String url,
    Map<String, dynamic>? queryParameter,
  }) async {
    if (headerType == 1) {
      dio.options.headers = ApiConstant.getHeaders;
    } else if (headerType == 2) {
      dio.options.headers = await ApiConstant.getHeadersWithBearer;
    }
    HttpClient appApiProvider = HttpClient.fromHeaderType(headerType, dio);
    return appApiProvider.get(url, queryParameters: queryParameter);
  }

  Future<dynamic> postData({
    required headerType,
    required String url,
    dynamic body,
    bool isMultiPart = false,
  }) async {
    if (headerType == 1) {
      dio.options.headers = ApiConstant.getHeaders;
    } else if (headerType == 2) {
      dio.options.headers = await ApiConstant.getHeadersWithBearer;
    }
    HttpClient appApiProvider = HttpClient.fromHeaderType(headerType, dio);
    return appApiProvider.post(url, body: body, isMultiPart: isMultiPart);
  }

  Future<dynamic> putData({
    required headerType,
    required String url,
    dynamic body,
    bool isMultiPart = false,
  }) async {
    if (headerType == 1) {
      dio.options.headers = ApiConstant.getHeaders;
    } else if (headerType == 2) {
      dio.options.headers = await ApiConstant.getHeadersWithBearer;
    }
    HttpClient appApiProvider = HttpClient.fromHeaderType(headerType, dio);
    return appApiProvider.put(url, body: body, isMultiPart: isMultiPart);
  }

  Future<dynamic> patchData({
    required headerType,
    required String url,
    dynamic body,
    bool isMultiPart = false,
  }) async {
    if (headerType == 1) {
      dio.options.headers = ApiConstant.getHeaders;
    } else if (headerType == 2) {
      dio.options.headers = await ApiConstant.getHeadersWithBearer;
    }
    HttpClient appApiProvider = HttpClient.fromHeaderType(headerType, dio);
    return appApiProvider.patch(url, body: body, isMultiPart: isMultiPart);
  }

  Future<dynamic> deleteData({
    required headerType,
    required String url,
    dynamic body,
    bool isMultiPart = false,
  }) async {
    if (headerType == 1) {
      dio.options.headers = ApiConstant.getHeaders;
    } else if (headerType == 2) {
      dio.options.headers = await ApiConstant.getHeadersWithBearer;
    }
    HttpClient appApiProvider = HttpClient.fromHeaderType(headerType, dio);
    return appApiProvider.delete(url, body: body, isMultiPart: isMultiPart);
  }
}

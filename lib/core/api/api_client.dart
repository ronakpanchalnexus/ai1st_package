import 'dart:io';

import 'package:bestforming_cac/core/api/api_constant.dart';
import 'package:bestforming_cac/core/helper/utils.dart';
import 'package:dio/dio.dart';

class HttpClient<T> {
  final Dio dio;

  HttpClient.fromHeaderType(int headerType, this.dio) {
    dio.options.baseUrl = ApiConstant.baseUrl;
    dio.options.receiveDataWhenStatusError = true;
    dio.options.receiveDataWhenStatusError = true;
    dio.options.connectTimeout = Duration(seconds: 60);
    dio.options.receiveTimeout = Duration(seconds: 60);
  }

  Map<String, dynamic> _addLanguageParameter(
    Map<String, dynamic>? queryParameters,
  ) {
    return {};
    /*return {
      ...?queryParameters,
      'lang':
          Prefs.getString(key: Constants.languageCode) == 'en' ? "en" : "fr",
    };*/
  }

  Future get(url, {Map<String, dynamic>? queryParameters}) async {
    queryParameters = _addLanguageParameter(queryParameters);
    Utils.log('url -> ${ApiConstant.baseUrl}$url');
    Utils.log('request -> $queryParameters');
    try {
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          contentType: ApiConstant.headerApplicationJson,
          responseType: ResponseType.plain,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 401 &&
          response.statusMessage == 'Unauthorized') {
        Utils.logOutWithoutContext();
      }
      return response.data;
    } catch (error) {
      return _handleError(error);
    }
  }

  Future post(String url, {dynamic body, bool isMultiPart = false}) async {
    Utils.log('url -> ${ApiConstant.baseUrl}$url');
    Utils.log('request -> $body');
    try {
      final Response response;
      Utils.log('url -> ${ApiConstant.baseUrl}$url');
      Utils.log(body.toString());
      response = await dio.post(
        ApiConstant.baseUrl + url,
        data: body,
        queryParameters: _addLanguageParameter({}),
        options: Options(
          contentType: isMultiPart ? Headers.formUrlEncodedContentType : null,
          responseType: ResponseType.plain,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 401 &&
          response.statusMessage == 'Unauthorized') {
        Utils.logOutWithoutContext();
      }
      return response.data;
    } catch (error) {
      return _handleError(error);
    }
  }

  Future put(String url, {dynamic body, required bool isMultiPart}) async {
    Utils.log('url -> ${ApiConstant.baseUrl}$url');
    Utils.log('request -> $body');
    try {
      final Response response;
      response = await dio.put(
        ApiConstant.baseUrl + url,
        data: body,
        queryParameters: _addLanguageParameter({}),
        options: Options(
          contentType: isMultiPart ? Headers.formUrlEncodedContentType : null,
          responseType: ResponseType.plain,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 401 &&
          response.statusMessage == 'Unauthorized') {
        Utils.logOutWithoutContext();
      }
      return response.data;
    } catch (error) {
      return _handleError(error);
    }
  }

  Future patch(String url, {dynamic body, required bool isMultiPart}) async {
    Utils.log('url -> ${ApiConstant.baseUrl}$url');
    Utils.log('request -> $body');
    try {
      final Response response;
      response = await dio.patch(
        ApiConstant.baseUrl + url,
        data: body,
        queryParameters: _addLanguageParameter({}),
        options: Options(
          contentType: isMultiPart ? Headers.formUrlEncodedContentType : null,
          responseType: ResponseType.plain,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 401 &&
          response.statusMessage == 'Unauthorized') {
        Utils.logOutWithoutContext();
      }
      return response.data;
    } catch (error) {
      return _handleError(error);
    }
  }

  Future delete(String url, {dynamic body, required bool isMultiPart}) async {
    Utils.log('url -> ${ApiConstant.baseUrl}$url');
    Utils.log('request -> $body');
    try {
      final Response response;
      response = await dio.delete(
        ApiConstant.baseUrl + url,
        queryParameters: _addLanguageParameter({}),
        data: body,
        options: Options(
          responseType: ResponseType.plain,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 401 &&
          response.statusMessage == 'Unauthorized') {
        Utils.logOutWithoutContext();
      }
      return response.data;
    } catch (error) {
      return _handleError(error);
    }
  }

  dynamic _handleError(dynamic error) {
    if (error is SocketException) {
      throw Exception('No Internet connection');
    } else if (error is HttpException) {
      throw Exception("Couldn't reach the server");
    } else if (error is FormatException) {
      throw Exception('Invalid response format');
    } else {
      throw Exception('Unknown error occurred');
    }
  }
}

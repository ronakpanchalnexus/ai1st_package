import 'dart:convert';

import 'package:bestforming_cac/core/constants/constants.dart';
import 'package:bestforming_cac/core/helper/prefs.dart';
import 'package:bestforming_cac/core/helper/utils.dart';

class ApiConstant {
  /// stage url
  // static const String baseUrl = 'http://35.156.4.190/ai1st/';
  // static const String baseUrl = 'https://ai1st.nexuslink.co.in/';
  static const String baseUrl = 'https://nexuslinkdev.com/ai1st_me/';

  /// header parameters
  static const authorization = 'Authorization';
  static const contentType = 'Content-Type';
  static const languageCode = 'language_code';
  static const headerApplicationJson = 'application/json';
  static const headerMultipartFormData = 'multipart/form-data';

  /// endpoints
  static const login = 'wp-json/jwt-auth/v1/token';
  static const videoLibrary = 'wp-json/custom-vl/v1/video-listing';
  static const getCourses = 'wp-json/custom-ld/v1/course-listing';
  static const getCoursesDetail = 'wp-json/custom-ld/v1/course-detail';
  static const markTopicComplete = 'wp-json/custom-ld/v1/mark-topic-complete';
  static const forgotPassword = 'wp-json/custom/v1/forgot-password';

  /// request params
  static const username = 'username';
  static const email = 'email';
  static const password = 'password';
  static const courseId = 'course_id';
  static const topicId = 'topic_id';
  static const userId = 'user_id';
  static const enroll = 'enroll';

  /// headers
  static Future<Map<String, String>?> get getHeadersWithBearer async {
    Utils.log('@@@ token -> ${Prefs.getString(key: Constants.accessToken)}');
    final parts = Prefs.getString(key: Constants.accessToken).split('.');
    if (parts.length != 3) {
      Utils.log('Expired');
      await Utils.refreshToken((newToken) {
        return {authorization: 'Bearer $newToken'};
      });
      throw Exception('Invalid token');
    }
    final payload = json.decode(
      utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
    );
    final exp = payload["exp"];
    DateTime expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    if (expiryDate.isBefore(DateTime.now())) {
      Utils.log('Expired');
      await Utils.refreshToken((newToken) {
        return {
          'AI1ST_SECRET_KEY': 'XoFXP4mMBJX10fNDgCBLeaz6LM5498nr',
          authorization: 'Bearer $newToken'
        };
      });
    } else {
      Utils.log('Not Expired');
      return {
        'AI1ST_SECRET_KEY': 'XoFXP4mMBJX10fNDgCBLeaz6LM5498nr',
        authorization: 'Bearer ${Prefs.getString(key: Constants.accessToken)}',
      };
    }
    return {
      'AI1ST_SECRET_KEY': 'XoFXP4mMBJX10fNDgCBLeaz6LM5498nr',
      authorization: 'Bearer ${Prefs.getString(key: Constants.accessToken)}',
    };
  }

  static Map<String, String> get getHeaders {
    return {
      'AI1ST_SECRET_KEY': 'XoFXP4mMBJX10fNDgCBLeaz6LM5498nr',
    };
  }
}

import 'dart:ui' as ui;

import 'package:ai1st_package/core/constants/colours.dart';
import 'package:ai1st_package/core/constants/constants.dart';
import 'package:ai1st_package/core/constants/strings.dart';
import 'package:ai1st_package/core/helper/build_context.dart';
import 'package:ai1st_package/core/helper/prefs.dart';
import 'package:ai1st_package/core/routes/route_constants.dart';
import 'package:ai1st_package/core/routes/router.dart';
import 'package:ai1st_package/src/shared/safe_gesture_detector.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_textview.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static AlertDialog? alert;
  static bool _isLoaderVisible = false;

  static void log(String message) {
    debugPrint(message);
  }

  static void showSnackBar(context, String message, {int duration = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
        backgroundColor: AppColors.getColor(context).primaryColor,
        content: AI1stTextView(
          text: message.tr(),
          maxLine: 2,
          color: AppColors.getColor(context).bgColor,
        ),
      ),
    );
  }

  static void changeLanguage(BuildContext context, String lang) {
    Prefs.setString(key: Constants.languageCode, value: lang);
    if (lang == Constants.languageFR) {
      EasyLocalization.of(context)?.setLocale(Locale('fr', 'FR'));
      Localizations.override(context: context, locale: Locale('fr', 'FR'));
    } else {
      EasyLocalization.of(context)?.setLocale(Locale('en', 'US'));
      Localizations.override(context: context, locale: Locale('en', 'US'));
    }
  }

  static Locale getCurrentLocale() {
    switch (Prefs.getString(key: Constants.languageCode)) {
      case Constants.languageFR:
        return Locale('fr', 'FR');
      case Constants.languageEN:
        return Locale('en', 'US');
      default:
        return Locale('en', 'US');
    }
  }

  static Future<bool> checkInternet({bool fromAPi = true}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    }
    if (fromAPi) {
      // showNoInternetDialog();
      Utils.log('no internet');
    }
    return false;
  }

  static showLoaderDialog(context, {String message = "Loading..."}) {
    if (_isLoaderVisible) return; // Prevent multiple loaders
    _isLoaderVisible = true;
    alert = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Center(
        child: CupertinoActivityIndicator(
          radius: 20.0,
          color: AppColors.getColor(context).colorWhite,
        ),
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: PopScope(canPop: false, child: alert!),
        );
      },
    ).then((value) {
      // Reset loader visibility when the dialog is dismissed
      _isLoaderVisible = false;
    });
  }

  static void dismissLoaderDialog(context) {
    if (alert != null && _isLoaderVisible) {
      _isLoaderVisible = false;
      Navigator.pop(context);
    }
  }

  static Future changeFocus(BuildContext context) async {
    final FocusScopeNode focus = FocusScope.of(context);
    focus.nextFocus();
  }

  static int getWeekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = getTotalNumberOfWeeks(date.year - 1);
    } else if (woy > getTotalNumberOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }

  static int getTotalNumberOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  static Future<void> datePicker(
    context, {
    required DateTime initDate,
    required Function(DateTime?) callBack,
  }) async {
    DateTime date = DateTime.now();
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (_) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Material(
                color: AppColors.getColor(context).colorWhite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.27,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: initDate,
                        onDateTimeChanged: (value) {
                          // callBack(value);
                          date = value;
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SafeGestureDetector(
                            onTap: () {
                              callBack(null);
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 48.0,
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color:
                                      AppColors.getColor(context).primaryColor,
                                ),
                              ),
                              child: Center(
                                child: AI1stTextView(
                                  text: Strings.cancel,
                                  color:
                                      AppColors.getColor(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SafeGestureDetector(
                            onTap: () {
                              callBack(date);
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 48.0,
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: AppColors.getColor(context).primaryColor,
                              ),
                              child: Center(
                                child: AI1stTextView(
                                  text: Strings.continueString,
                                  color: AppColors.getColor(context).colorWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<ui.Image>? loadAssetImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List uInt8 = data.buffer.asUint8List();

    final ui.Codec codec = await ui.instantiateImageCodec(uInt8);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  static void hideKeyboard(context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static void showKeyboard(context) {
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  static Future<void> logOut(context) async {
    String languageCode = Prefs.getString(key: Constants.languageCode);
    bool darkMode = Prefs.getBool(key: Constants.isDarkMode);
    String password = Prefs.getString(key: Constants.password);
    String email = Prefs.getString(key: Constants.email);
    Prefs.clear();
    Prefs.setString(key: Constants.languageCode, value: languageCode);
    Prefs.setBool(key: Constants.isDarkMode, value: darkMode);
    if (password.isNotEmpty) {
      Prefs.setString(key: Constants.password, value: password);
      Prefs.setString(key: Constants.email, value: email);
    }
    if (context.mounted) {
      navigateTo(
        context: context,
        route: RouteConstants.login,
        finishAll: true,
      );
    }
    /*final authDataSource = GetIt.I<AuthenticationRemoteDataSource>();
    await authDataSource.signOut().then((value) {
      String languageCode = Prefs.getString(key: Constants.languageCode);
    Prefs.clear();
    Prefs.setString(key: Constants.languageCode, value: languageCode);
      if (context.mounted) {
        navigateTo(
          context: context,
          route: RouteConstants.login,
          finishAll: true,
        );
      }
    });*/
  }

  static Future<void> logOutWithoutContext() async {
    String languageCode = Prefs.getString(key: Constants.languageCode);
    bool darkMode = Prefs.getBool(key: Constants.isDarkMode);
    String password = Prefs.getString(key: Constants.password);
    String email = Prefs.getString(key: Constants.email);
    Prefs.clear();
    Prefs.setString(key: Constants.languageCode, value: languageCode);
    Prefs.setBool(key: Constants.isDarkMode, value: darkMode);
    if (password.isNotEmpty) {
      Prefs.setString(key: Constants.password, value: password);
      Prefs.setString(key: Constants.email, value: email);
    }
    if (mContext.mounted) {
      navigateTo(
        context: mContext,
        route: RouteConstants.login,
        finishAll: true,
      );
    }
  }

  static String removeZeros(double value) {
    String result = value.toStringAsFixed(2).replaceAll(RegExp(r'0+$'), '');
    if (result.endsWith('.')) {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }

  static refreshToken(Function(String) callback) {
    /// perform refresh token logic.
  }

  static String getMaskedPhoneNumber(String phoneNumber) {
    return '${'*' * (phoneNumber.length - 2)}${phoneNumber.substring(phoneNumber.length - 2)}';
  }

  static String getMaskedEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email; // Invalid email, return as is

    final localPart = parts[0];
    final domainPart = parts[1];
    final maskedLocal = '*' * localPart.length;

    return '$maskedLocal@$domainPart';
  }

  static String getFormattedTimeOld(String? date) {
    final dateTime = DateTime.parse(date ?? '');
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 5) {
      return Strings.justNow;
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds} ${Strings.secondsAgo.tr()}';
    } else if (difference.inMinutes < 60) {
      return difference.inMinutes > 1
          ? '${difference.inMinutes} ${Strings.minutesAgo.tr()}'
          : '${difference.inMinutes} ${Strings.minuteAgo.tr()}';
    } else if (difference.inHours < 24) {
      return difference.inHours > 1
          ? '${difference.inHours} ${Strings.hoursAgo.tr()}'
          : '${difference.inHours} ${Strings.hourAgo.tr()}';
    } else if (difference.inDays < 30) {
      return difference.inDays > 1
          ? '${difference.inDays} ${Strings.daysAgo.tr()}'
          : '${difference.inDays} ${Strings.dayAgo.tr()}';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return months > 1
          ? '$months ${Strings.monthsAgo.tr()}'
          : '$months ${Strings.monthAgo.tr()}';
    } else {
      final years = (difference.inDays / 365).floor();
      return years > 1
          ? '$years ${Strings.yearsAgo.tr()}'
          : '$years ${Strings.yearAgo.tr()}';
    }
  }

  static String getFormattedTime(String? date) {
    final dateTime = DateTime.parse(date ?? '');
    return DateFormat('EEEE, dd MMMM yyyy', 'de').format(dateTime);
  }
}

void showNoInternetDialog() {
  showDialog(
    context: mContext,
    builder: (BuildContext context) {
      return AlertDialog(
        title: AI1stTextView(
          text: Strings.appName,
          color: AppColors.getColor(context).colorBlack,
        ),
        content: AI1stTextView(
          text: Strings.internetConnectionMessage,
          color: AppColors.getColor(context).colorBlack,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: AI1stTextView(
              text: Strings.close,
              color: AppColors.getColor(context).colorBlack,
            ),
          ),
        ],
      );
    },
  );
}

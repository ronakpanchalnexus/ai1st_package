import 'package:ai1st_package/core/constants/constants.dart';
import 'package:ai1st_package/core/helper/prefs.dart';
import 'package:flutter/material.dart';

class ThemeUtils {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier<ThemeMode>(Prefs.getBool(key: Constants.isDarkMode)
          ? ThemeMode.dark
          : ThemeMode.light);

  static void changeTheme() {
    final isDark = Prefs.getBool(key: Constants.isDarkMode);
    final newTheme = isDark ? ThemeMode.light : ThemeMode.dark;

    Prefs.setBool(
      key: Constants.isDarkMode,
      value: !isDark,
    );

    ThemeUtils.themeNotifier.value = newTheme;
  }
}

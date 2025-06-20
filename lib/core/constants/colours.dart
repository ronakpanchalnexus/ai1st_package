import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color primaryColor;
  final Color bgColor;
  final Color textFieldBgColor;
  final Color hintTextColor;
  final Color textPrimaryColor;
  final Color colorWhite;
  final Color colorBlack;
  final Color textFieldBorderColor;
  final Color colorRed;
  final Color colorGreen;

  const AppColors({
    required this.primaryColor,
    required this.bgColor,
    required this.textFieldBgColor,
    required this.hintTextColor,
    required this.textPrimaryColor,
    required this.colorWhite,
    required this.colorBlack,
    required this.textFieldBorderColor,
    required this.colorRed,
    required this.colorGreen,
  });

  @override
  AppColors copyWith({
    Color? primaryColor,
    Color? bgColor,
    Color? textFieldBgColor,
    Color? hintTextColor,
    Color? textPrimaryColor,
    Color? colorWhite,
    Color? colorBlack,
    Color? textFieldBorderColor,
    Color? colorRed,
    Color? colorGreen,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      bgColor: bgColor ?? this.bgColor,
      textFieldBgColor: textFieldBgColor ?? this.textFieldBgColor,
      hintTextColor: hintTextColor ?? this.hintTextColor,
      textPrimaryColor: textPrimaryColor ?? this.textPrimaryColor,
      colorWhite: colorWhite ?? this.colorWhite,
      colorBlack: colorBlack ?? this.colorBlack,
      textFieldBorderColor: textFieldBorderColor ?? this.textFieldBorderColor,
      colorRed: colorRed ?? this.colorRed,
      colorGreen: colorGreen ?? this.colorGreen,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      bgColor: Color.lerp(bgColor, other.bgColor, t)!,
      textFieldBgColor:
          Color.lerp(textFieldBgColor, other.textFieldBgColor, t)!,
      hintTextColor: Color.lerp(hintTextColor, other.hintTextColor, t)!,
      textPrimaryColor:
          Color.lerp(textPrimaryColor, other.textPrimaryColor, t)!,
      colorWhite: Color.lerp(colorWhite, other.colorWhite, t)!,
      colorBlack: Color.lerp(colorBlack, other.colorBlack, t)!,
      textFieldBorderColor:
          Color.lerp(textFieldBorderColor, other.textFieldBorderColor, t)!,
      colorRed: Color.lerp(colorRed, other.colorRed, t)!,
      colorGreen: Color.lerp(colorGreen, other.colorGreen, t)!,
    );
  }

  static AppColors getColor(context) {
    return Theme.of(context).extension<AppColors>()!;
  }
}

import 'package:ai1st_package/core/constants/colours.dart';
import 'package:ai1st_package/core/constants/fonts.dart';
import 'package:ai1st_package/src/shared/safe_gesture_detector.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AI1stButton extends StatelessWidget {
  const AI1stButton({
    super.key,
    this.isOutlined = false,
    this.iconSize = 24.0,
    this.icon,
    required this.text,
    this.height = 51.0,
    this.width = double.infinity,
    this.borderRadius = 0.0,
    this.color,
    this.outlinedTextColor,
    this.outlinedBorderColor,
    this.bgColor,
    required this.onTap,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.padding = 20.0,
    this.fontFamily = Fonts.futuraNowHeadlineMediumItalic,
  });

  final double? iconSize;
  final bool isOutlined;
  final String? icon;
  final String text;
  final double height;
  final double width;
  final double borderRadius;
  final Color? color;
  final Color? outlinedTextColor;
  final Color? outlinedBorderColor;
  final Color? bgColor;
  final MainAxisAlignment mainAxisAlignment;
  final Function() onTap;
  final double padding;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return SafeGestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isOutlined
              ? AppColors.getColor(context).colorRed
              : (bgColor ?? AppColors.getColor(context).colorRed),
          borderRadius: BorderRadius.circular(borderRadius),
          border: isOutlined
              ? Border.all(
                  color: (outlinedBorderColor ??
                      AppColors.getColor(context).primaryColor),
                )
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            icon != null
                ? Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: SvgPicture.asset(
                      icon!,
                      width: iconSize,
                      height: iconSize,
                    ),
                  )
                : SizedBox.shrink(),
            Text(
              text.tr(),
              style: TextStyle(
                fontWeight: getFontWeight(fontFamily),
                fontFamily: fontFamily,
                fontSize: getFontSize(fontFamily),
                color: isOutlined
                    ? (outlinedTextColor ??
                        AppColors.getColor(context).primaryColor)
                    : (color ?? AppColors.getColor(context).colorWhite),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*double getFontSize(String fontFamily) {
    switch (fontFamily) {
      case Fonts.interBold:
        return 22.sp;
      case Fonts.interSemiBold:
        return 16.sp;
      case Fonts.interRegular:
        return 14.sp;
      case Fonts.interBold:
        return 22.sp;
      case Fonts.interSemiBold:
        return 16.sp;
      case Fonts.interRegular:
        return 14.sp;
      default:
        return 14.sp;
    }
  }*/

  double getFontSize(String fontFamily) {
    switch (fontFamily) {
      // case Fonts.interBold:
      //   return 22.sp;
      case Fonts.futuraNowHeadlineBold:
        return 20.sp;
      case Fonts.futuraNowHeadlineBlackItalic:
        return 18.sp;
      // case Fonts.interSemiBold:
      //   return 16.sp;
      case Fonts.futuraNowHeadlineMedium:
        return 16.sp;
      case Fonts.futuraNowHeadlineRegular:
        return 14.sp;
      // case Fonts.interRegular:
      //   return 14.sp;
      // case Fonts.interLight:
      //   return 12.sp;
      case Fonts.futuraNowHeadlineLight:
        return 12.sp;
      default:
        return 14.sp;
    }
  }

  FontWeight getFontWeight(String fontFamily) {
    switch (fontFamily) {
      // case Fonts.interBold:
      //   return FontWeight.w700;
      case Fonts.futuraNowHeadlineBlackItalic:
        //   return FontWeight.w700;
        // case Fonts.interSemiBold:
        return FontWeight.w600;
      case Fonts.futuraNowHeadlineMedium:
        return FontWeight.w500;
      // case Fonts.interRegular:
      //   return FontWeight.w400;
      // case Fonts.interLight:
      //   return FontWeight.w400;
      case Fonts.futuraNowHeadlineLight:
        return FontWeight.w400;
      default:
        return FontWeight.w400;
    }
  }
}

import 'package:ai1st_package/core/constants/fonts.dart';
import 'package:ai1st_package/src/shared/safe_gesture_detector.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AI1stTextView extends StatelessWidget {
  const AI1stTextView({
    super.key,
    required this.text,
    this.color,
    this.padding = 0,
    this.maxLine,
    this.textAlign = TextAlign.left,
    this.onTap,
    this.underLine = false,
    this.disableTranslate = false,
    this.fontFamily = Fonts.futuraNowHeadlineRegular,
  });

  final String text;
  final double padding;
  final Color? color;
  final TextAlign textAlign;
  final Function()? onTap;
  final int? maxLine;
  final bool underLine;
  final bool disableTranslate;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return onTap != null
        ? SafeGestureDetector(
            onTap: onTap!,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Text(
                disableTranslate ? text : text.tr(),
                textAlign: textAlign,
                maxLines: maxLine,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: getFontWeight(fontFamily),
                  fontFamily: fontFamily,
                  fontSize: getFontSize(fontFamily),
                  color: color,
                  decoration: underLine ? TextDecoration.underline : null,
                ),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.all(padding),
            child: Text(
              disableTranslate ? text : text.tr(),
              textAlign: textAlign,
              maxLines: maxLine,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: getFontWeight(fontFamily),
                fontFamily: fontFamily,
                fontSize: getFontSize(fontFamily),
                color: color,
                decoration: underLine ? TextDecoration.underline : null,
              ),
            ),
          );
  }

  double getFontSize(String fontFamily) {
    switch (fontFamily) {
      case Fonts.futuraNowHeadlineBold:
        return 20.sp;
      case Fonts.futuraNowHeadlineBlackItalic:
        return 18.sp;
      case Fonts.futuraNowHeadlineMedium:
        return 16.sp;
      case Fonts.futuraNowHeadlineRegular:
        return 14.sp;
      case Fonts.futuraNowHeadlineMediumItalic:
        return 16.sp;
      case Fonts.futuraNowHeadlineLight:
        return 12.sp;
      default:
        return 14.sp;
    }
  }

  FontWeight getFontWeight(String fontFamily) {
    switch (fontFamily) {
      case Fonts.futuraNowHeadlineBold:
        return FontWeight.w600;
      case Fonts.futuraNowHeadlineBlackItalic:
        return FontWeight.w600;
      case Fonts.futuraNowHeadlineMedium:
        return FontWeight.w500;
      case Fonts.futuraNowHeadlineMediumItalic:
        return FontWeight.w500;
      case Fonts.futuraNowHeadlineLight:
        return FontWeight.w400;
      default:
        return FontWeight.w400;
    }
  }
}

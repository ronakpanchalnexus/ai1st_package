import 'package:bestforming_cac/core/constants/colours.dart';
import 'package:bestforming_cac/src/shared/safe_gesture_detector.dart';
import 'package:flutter/material.dart';

class AI1stCardView extends StatelessWidget {
  const AI1stCardView({
    super.key,
    required this.child,
    this.borderRadius = 10.0,
    this.elevation = 0.0,
    this.bgColor,
    this.padding,
    this.width,
    this.height = 56.0,
    this.onTap,
    this.isOutlined = false,
  });

  final Widget child;
  final double borderRadius;
  final double elevation;
  final double? width;
  final double? height;
  final Color? bgColor;
  final Function()? onTap;
  final EdgeInsets? padding;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return onTap != null
        ? SafeGestureDetector(
            onTap: onTap!,
            child: Card(
              elevation: elevation,
              surfaceTintColor:
                  (bgColor ?? AppColors.getColor(context).colorWhite),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: isOutlined
                    ? BorderSide(
                        color: AppColors.getColor(context).textFieldBorderColor)
                    : BorderSide.none,
              ),
              child: Container(
                padding: padding,
                width: width ?? double.infinity,
                height: height,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: isOutlined
                      ? Border.all(
                          color:
                              AppColors.getColor(context).textFieldBorderColor)
                      : null,
                ),
                child: child,
              ),
            ))
        : Card(
            elevation: elevation,
            surfaceTintColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: isOutlined
                  ? BorderSide(
                      color: AppColors.getColor(context).textFieldBorderColor)
                  : BorderSide.none,
            ),
            child: Container(
              padding: padding,
              width: width ?? double.infinity,
              height: height,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: isOutlined
                    ? Border.all(
                        color: AppColors.getColor(context).textFieldBorderColor)
                    : null,
              ),
              child: child,
            ),
          );
  }
}

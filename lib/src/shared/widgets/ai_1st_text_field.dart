import 'dart:async';

import 'package:bestforming_cac/core/constants/colours.dart';
import 'package:bestforming_cac/core/constants/fonts.dart';
import 'package:bestforming_cac/core/constants/media_res.dart';
import 'package:bestforming_cac/src/shared/safe_gesture_detector.dart';
import 'package:bestforming_cac/src/shared/widgets/ai_1st_textview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AI1stTextField extends StatefulWidget {
  const AI1stTextField({
    super.key,
    this.controller,
    this.hint = '',
    this.textInputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    this.onTextChanged,
    this.isPassword = false,
    this.focusNode,
    this.leading,
    this.suffix,
    this.maxLength,
    this.showPassword = false,
    this.onPasswordTap,
    this.showDecoration = true,
    this.readOnly = false,
    this.errorText,
    this.onEditingComplete,
    this.minLines = 1,
    this.maxLines = 1,
    this.textColor,
    this.hintTextColor,
    this.bgColor,
    this.textSize,
    this.height,
    this.fontFamily,
    this.fontWeight,
    this.padding,
    this.isOutlined = false,
    this.delayTextChanged = false,
  });

  final String hint;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final TextInputType inputType;
  final Function(String)? onTextChanged;
  final bool isPassword;
  final bool showPassword;
  final bool showDecoration;
  final FocusNode? focusNode;
  final Widget? leading;
  final Widget? suffix;
  final int? maxLength;
  final Function()? onPasswordTap;
  final bool readOnly;
  final String? errorText;
  final Function()? onEditingComplete;
  final int minLines;
  final int maxLines;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? bgColor;
  final double? textSize;
  final double? height;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final bool isOutlined;
  final bool delayTextChanged;

  @override
  State<AI1stTextField> createState() => _AI1stTextFieldState();
}

class _AI1stTextFieldState extends State<AI1stTextField> {
  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.minLines == 1 ? widget.height ?? 60.0 : null,
          padding: widget.padding ??
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: widget.errorText == null
              ? widget.showDecoration
                  ? widget.isOutlined
                      ? BoxDecoration(
                          color: AppColors.getColor(context).colorWhite,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: AppColors.getColor(context)
                                .textFieldBorderColor,
                          ),
                        )
                      : BoxDecoration(
                          color: widget.bgColor ??
                              AppColors.getColor(context).textFieldBgColor,
                          borderRadius: BorderRadius.circular(10.0),
                        )
                  : null
              : BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.red, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.leading ?? SizedBox.shrink(),
              SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  minLines: widget.minLines,
                  readOnly: widget.readOnly,
                  focusNode: widget.focusNode,
                  controller: widget.controller,
                  maxLines: widget.maxLines,
                  maxLength: widget.maxLength,
                  onChanged: widget.delayTextChanged
                      ? (value) {
                          if (_debounceTimer?.isActive ?? false) {
                            _debounceTimer!.cancel();
                          }
                          _debounceTimer = Timer(
                            const Duration(milliseconds: 300),
                            () {
                              widget.onTextChanged!(value);
                            },
                          );
                        }
                      : widget.onTextChanged,
                  textInputAction: widget.textInputAction,
                  keyboardType: widget.inputType,
                  obscureText: widget.isPassword && !widget.showPassword,
                  obscuringCharacter: '⁕',
                  textCapitalization: widget.isPassword ||
                          widget.inputType == TextInputType.emailAddress
                      ? TextCapitalization.none
                      : TextCapitalization.sentences,
                  inputFormatters: widget.inputType ==
                          TextInputType.numberWithOptions(decimal: true)
                      ? [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d*'),
                          ),
                        ]
                      : [],
                  style: TextStyle(
                    color: widget.textColor ??
                        AppColors.getColor(context).textPrimaryColor,
                    fontSize: widget.textSize ?? 14.0.sp,
                    fontFamily: Fonts.futuraNowHeadlineRegular,
                    fontWeight: widget.fontWeight ?? FontWeight.w400,
                  ),
                  onEditingComplete: widget.onEditingComplete,
                  decoration: InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                    hintText: widget.hint.tr(),
                    hintStyle: TextStyle(
                      color: widget.hintTextColor ??
                          AppColors.getColor(context).hintTextColor,
                      fontSize: 14.0.sp,
                      fontFamily: Fonts.futuraNowHeadlineRegular,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              widget.suffix ?? SizedBox.shrink(),
              if (widget.isPassword)
                SafeGestureDetector(
                  onTap: widget.onPasswordTap!,
                  child: widget.showPassword
                      ? SvgPicture.asset(MediaRes.icShowPassword)
                      : SvgPicture.asset(MediaRes.icHidePassword),
                ),
            ],
          ),
        ),
        if (widget.errorText != null)
          Container(
            margin: EdgeInsets.only(left: 10.0, top: 3.0),
            child: AI1stTextView(
              text: widget.errorText!,
              color: Colors.red,
              fontFamily: Fonts.futuraNowHeadlineLight,
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

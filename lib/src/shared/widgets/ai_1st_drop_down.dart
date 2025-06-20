import 'package:ai1st_package/core/constants/colours.dart';
import 'package:ai1st_package/core/constants/media_res.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_card_view.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_textview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AI1stDropDown<T> extends StatelessWidget {
  const AI1stDropDown({
    super.key,
    this.borderRadius = 10.0,
    this.elevation = 0.0,
    this.padding,
    this.width,
    this.height = 56.0,
    this.onTap,
    this.disableClick = false,
    this.hint = '',
    required this.onChanged,
    required this.list,
    this.selectedItem,
    required this.itemToString,
  });

  final String hint;
  final double borderRadius;
  final double elevation;
  final double? width;
  final double? height;
  final Function()? onTap;
  final EdgeInsets? padding;
  final bool disableClick;

  final Function(T?) onChanged;
  final List<T> list;
  final T? selectedItem;
  final String Function(T) itemToString;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disableClick,
      child: AI1stCardView(
        isOutlined: true,
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: DropdownButton<T>(
              value: selectedItem,
              underline: DropdownButtonHideUnderline(child: SizedBox.shrink()),
              isExpanded: true,
              dropdownColor: AppColors.getColor(context).colorWhite,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              hint: AI1stTextView(text: hint),
              icon: SvgPicture.asset(MediaRes.icDownArrow),
              items: list.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: AI1stTextView(text: itemToString(item)),
                );
              }).toList(),
              onChanged: (T? newValue) => onChanged(newValue),
            ),
          ),
        ),
      ),
    );
  }
}

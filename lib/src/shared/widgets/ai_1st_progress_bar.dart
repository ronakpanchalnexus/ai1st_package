import 'package:ai1st_package/core/constants/colours.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_textview.dart';
import 'package:flutter/material.dart';

class Ai1stProgressBar extends StatelessWidget {
  final double progress;

  const Ai1stProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppColors.getColor(context).primaryColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: progress.round(),
            child: Container(
              alignment: Alignment.center,
              height: 30.0,
              decoration: BoxDecoration(
                color: AppColors.getColor(context).colorRed,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: AI1stTextView(
                text: '${progress.round()}%',
                color: AppColors.getColor(context).colorWhite,
              ),
            ),
          ),
          Expanded(
            flex: 100 - progress.round(),
            child: Container(
              height: 30.0,
              decoration: BoxDecoration(
                color: AppColors.getColor(context).bgColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

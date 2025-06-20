import 'package:ai1st_package/core/constants/colours.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_textview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleButtonDialog {
  static void showSingleButtonDialog(
    context, {
    required String title,
    required String message,
    required String button,
    required Function() callback,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: Center(
            child: AI1stTextView(
              text: title,
              color: AppColors.getColor(context).colorRed,
            ),
          ),
          content: Center(
            child: AI1stTextView(
              text: message,
              color: AppColors.getColor(context).primaryColor,
              textAlign: TextAlign.center,
              maxLine: 5,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () async {
                Navigator.pop(context);
                callback();
              },
              isDefaultAction: true,
              isDestructiveAction: true,
              child: AI1stTextView(
                text: button,
                color: AppColors.getColor(context).colorRed,
              ),
            ),
          ],
        );
      },
    );
  }
}

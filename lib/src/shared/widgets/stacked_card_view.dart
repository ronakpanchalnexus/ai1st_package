import 'package:ai1st_package/core/constants/colours.dart';
import 'package:ai1st_package/core/constants/media_res.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_card_view.dart';
import 'package:flutter/material.dart';

class StackedCardView extends StatelessWidget {
  final String imageUrl;

  const StackedCardView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          Positioned(
            left: 14,
            right: 14,
            child: _buildCard(child: commonChildWidget(context, 2)),
          ),
          Positioned(
            top: 10,
            left: 7,
            right: 7,
            child: _buildCard(child: commonChildWidget(context, 1)),
          ),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: _buildCard(
              child: commonChildWidget(context, 0),
            ),
          ),
        ],
      ),
    );
  }

  Widget commonChildWidget(BuildContext context, int index) {
    return imageUrl.isNotEmpty
        ? Image.network(
            imageUrl,
            opacity: AlwaysStoppedAnimation(index == 0
                ? 1.0
                : index == 1
                    ? 0.8
                    : 0.5),
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: index == 0
                    ? AppColors.getColor(context).bgColor
                    : Colors.grey.withAlpha(
                        index == 1 ? 128 : 204,
                      ),
                padding: EdgeInsets.all(5.0),
                child: Center(
                  child: Image.asset(
                    MediaRes.icLogoPadded,
                    fit: BoxFit.fitWidth,
                    color: AppColors.getColor(context).primaryColor,
                  ),
                ),
              );
            },
          )
        : Container(
            color: AppColors.getColor(context).bgColor,
            padding: EdgeInsets.all(5.0),
            child: Image.asset(
              MediaRes.icLogoPadded,
              fit: BoxFit.fitWidth,
              color: AppColors.getColor(context).primaryColor,
            ),
          );
    /*return AI1stNetworkImageWidget(
      imageUrl: imageUrl,
      opacity: index == 0
          ? 1.0
          : index == 1
              ? 0.8
              : 0.5,
    );*/
  }

  Widget _buildCard({Widget? child}) {
    return AI1stCardView(
      height: 200,
      borderRadius: 15.0,
      elevation: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          child: child,
        ),
      ),
    );
  }
}

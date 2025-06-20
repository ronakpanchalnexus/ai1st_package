import 'package:ai1st_package/core/constants/colours.dart';
import 'package:ai1st_package/core/constants/media_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class AI1stNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final bool isUser;

  const AI1stNetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.isUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => Container(
              color: AppColors.getColor(context).bgColor,
              padding: EdgeInsets.all(5.0),
              child: Center(
                child: Image.asset(
                  isUser ? MediaRes.icUserPlaceHolder : MediaRes.icLogoPadded,
                  fit: BoxFit.fitWidth,
                  color: AppColors.getColor(context).primaryColor,
                ),
              ),
            ),
          )
        : Container(
            color: AppColors.getColor(context).bgColor,
            padding: EdgeInsets.all(5.0),
            child: Image.asset(
              isUser ? MediaRes.icUserPlaceHolder : MediaRes.icLogoPadded,
              color: AppColors.getColor(context).primaryColor,
              fit: BoxFit.fitWidth,
            ),
          );
  }
}

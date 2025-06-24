import 'package:ai1st_package/core/constants/colours.dart';
import 'package:ai1st_package/core/constants/media_res.dart';
import 'package:ai1st_package/core/routes/route_constants.dart';
import 'package:ai1st_package/core/routes/router.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2)).then((_) {
        if (!mounted) return;
        navigateTo(
          context: context,
          route: RouteConstants.home,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getColor(context).bgColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(70.0),
              child: Image.asset(
                MediaRes.icLogoPadded,
                color: AppColors.getColor(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

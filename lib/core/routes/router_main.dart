part of 'router.dart';

Route<dynamic> generateRoute(
  RouteSettings settings, {
  bool reverseAnimation = false,
}) {
  final isTokenExpired = Prefs.getBool(key: Constants.isTokenExpired);
  if (isTokenExpired) {
    return _pageBuilder(
      (_) => LoginScreen(),
      settings: settings,
      reverseAnimation: reverseAnimation,
    );
  } else {
    switch (settings.name) {
      case RouteConstants.home:
        return _pageBuilder(
          (_) => HomeScreen(),
          settings: settings,
          reverseAnimation: reverseAnimation,
        );

      case RouteConstants.courseDetail:
        return _pageBuilder(
          (_) => CourseDetailScreen(),
          settings: settings,
          reverseAnimation: reverseAnimation,
        );

      case RouteConstants.editProfile:
        return _pageBuilder(
          (_) => EditProfileScreen(),
          settings: settings,
          reverseAnimation: reverseAnimation,
        );

      case RouteConstants.videoDetail:
        return _pageBuilder(
          (_) => VideoDetailScreen(),
          settings: settings,
          reverseAnimation: reverseAnimation,
        );

      case RouteConstants.downloadCertificate:
        return _pageBuilder(
          (_) => DownloadCertificateScreen(),
          settings: settings,
          reverseAnimation: reverseAnimation,
        );

      default:
        return _pageBuilder(
          (_) => Scaffold(
            body: const Placeholder(),
          ),
          settings: settings,
          reverseAnimation: reverseAnimation,
        );
    }
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
  required bool reverseAnimation,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, secondaryAnimation, child) {
      final begin =
          reverseAnimation ? const Offset(-1.5, 0.0) : const Offset(1.5, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
    pageBuilder: (context, animation, secondaryAnimation) => page(context),
  );
}

Future<void> navigateTo({
  required BuildContext context,
  required String route,
  String? routeUntil,
  Object? arguments,
  bool finish = false,
  bool finishAll = false,
  bool finishUntil = false,
  bool reverseAnimation = false,
  Function(dynamic)? then,
}) async {
  mContext = context;

  final routeSettings = RouteSettings(name: route, arguments: arguments);
  final routeToPush = generateRoute(
    routeSettings,
    reverseAnimation: reverseAnimation,
  );

  if (finish) {
    final result = await Navigator.pushReplacement(context, routeToPush);
    then?.call(result);
    return;
  }

  if (finishAll) {
    Navigator.pushAndRemoveUntil(context, routeToPush, (route) => false);
    return;
  }

  if (finishUntil) {
    Navigator.pushAndRemoveUntil(
      context,
      routeToPush,
      ModalRoute.withName(routeUntil ?? route),
    );
    return;
  }

  final result = await Navigator.push(context, routeToPush);
  then?.call(result);
}

import 'package:ai1st_package/core/constants/colours.dart';
import 'package:ai1st_package/core/constants/constants.dart';
import 'package:ai1st_package/core/constants/strings.dart';
import 'package:ai1st_package/core/helper/build_context.dart';
import 'package:ai1st_package/core/helper/prefs.dart';
import 'package:ai1st_package/core/helper/theme_utils.dart';
import 'package:ai1st_package/core/routes/router.dart';
import 'package:ai1st_package/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class InitPackage extends StatefulWidget {
  const InitPackage({super.key});

  @override
  State<InitPackage> createState() => _InitPackageState();
}

class _InitPackageState extends State<InitPackage> {
  @override
  void initState() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableBuildModes = [];
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Brightness? _brightness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (!mounted) return;
    setState(() {
      _brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      Prefs.setBool(
        key: Constants.isDarkMode,
        value: _brightness != Brightness.light,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return BlocProvider(
      create: (_) => GetIt.I.get<AuthenticationBloc>(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeUtils.themeNotifier,
          builder: (context, currentThemeMode, child) {
            return MaterialApp(
              navigatorKey: NavigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: Strings.appName,
              themeMode: currentThemeMode,
              theme: ThemeData(
                useMaterial3: true,
                extensions: const [
                  AppColors(
                    primaryColor: Colors.black,
                    bgColor: Color(0xFFF8F6F1),
                    textFieldBgColor: Color(0xFFF8F9FA),
                    hintTextColor: Color(0xFFBDC1C6),
                    textPrimaryColor: Color(0xFF0E1118),
                    colorWhite: Color(0xFFFFFFFF),
                    colorBlack: Color(0xFF000000),
                    textFieldBorderColor: Color(0xFFCECECE),
                    colorRed: Color(0xFFBC002D),
                    colorGreen: Color(0xFF11CA2D),
                  )
                ],
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.dark,
                extensions: const [
                  AppColors(
                    primaryColor: Colors.white,
                    bgColor: Colors.black,
                    textFieldBgColor: Color(0xFFF8F9FA),
                    hintTextColor: Color(0xFFBDC1C6),
                    textPrimaryColor: Color(0xFF0E1118),
                    colorWhite: Color(0xFFFFFFFF),
                    colorBlack: Color(0xFF000000),
                    textFieldBorderColor: Color(0xFFCECECE),
                    colorRed: Color(0xFFBC002D),
                    colorGreen: Color(0xFF11CA2D),
                  )
                ],
              ),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              onGenerateRoute: generateRoute,
            );
          },
        ),
      ),
    );
  }
}

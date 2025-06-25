import 'package:bestforming_cac/core/constants/constants.dart';
import 'package:bestforming_cac/core/di/injection_container.dart';
import 'package:bestforming_cac/core/helper/build_context.dart';
import 'package:bestforming_cac/core/helper/prefs.dart';
import 'package:bestforming_cac/core/helper/utils.dart';
import 'package:bestforming_cac/src/features/authentication/presentation/view/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    initAllItems();
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
      Utils.log('-> bearer is ${Prefs.getString(key: Constants.accessToken)}');
      Prefs.setBool(
        key: Constants.isDarkMode,
        value: _brightness != Brightness.light,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return HomeScreen();
  }

  Future<void> initAllItems() async {
    init();
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableBuildModes = [];
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}

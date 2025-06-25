import 'package:bestforming_cac/core/constants/colours.dart';
import 'package:bestforming_cac/core/constants/constants.dart';
import 'package:bestforming_cac/core/constants/fonts.dart';
import 'package:bestforming_cac/core/constants/media_res.dart';
import 'package:bestforming_cac/core/constants/strings.dart';
import 'package:bestforming_cac/core/helper/prefs.dart';
import 'package:bestforming_cac/core/helper/utils.dart';
import 'package:bestforming_cac/core/helper/validation.dart';
import 'package:bestforming_cac/core/routes/route_constants.dart';
import 'package:bestforming_cac/core/routes/router.dart';
import 'package:bestforming_cac/src/features/authentication/domain/usecases/sign_in_use_case.dart';
import 'package:bestforming_cac/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:bestforming_cac/src/shared/safe_gesture_detector.dart';
import 'package:bestforming_cac/src/shared/widgets/ai_1st_button.dart';
import 'package:bestforming_cac/src/shared/widgets/ai_1st_text_field.dart';
import 'package:bestforming_cac/src/shared/widgets/ai_1st_textview.dart';
import 'package:bestforming_cac/src/shared/widgets/single_button_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _kEmailController = TextEditingController();
  final TextEditingController _kPasswordController = TextEditingController();
  String? _kEmailError;
  String? _kPasswordError;
  bool _kShowPassword = false;
  bool _kStayLoggedIn = false;
  final _kAuthBloc = GetIt.I.get<AuthenticationBloc>();

  @override
  void initState() {
    String password = Prefs.getString(key: Strings.password);
    if (password.isNotEmpty) {
      setState(() {
        _kStayLoggedIn = true;
        _kPasswordController.text = password;
        _kEmailController.text = Prefs.getString(key: Strings.email);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _kAuthBloc,
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state) {
            case AuthenticationLoading():
              Utils.showLoaderDialog(context);
              break;
            case SignedInStateSuccess():
              Utils.dismissLoaderDialog(context);
              if (_kStayLoggedIn) {
                Prefs.setString(
                    key: Constants.password,
                    value: _kPasswordController.text.trim());
              } else {
                Prefs.setString(key: Constants.password, value: '');
              }
              /*--------------------------------------------------------*/
              Prefs.setString(
                  key: Constants.accessToken,
                  value: state.loginEntity.data?.token ?? '');
              Prefs.setString(
                  key: Constants.email,
                  value: state.loginEntity.data?.userEmail ?? '');
              Prefs.setString(
                  key: Constants.niceName,
                  value: state.loginEntity.data?.userNicename ?? '');
              Prefs.setString(
                  key: Constants.displayName,
                  value: state.loginEntity.data?.userDisplayName ?? '');
              Prefs.setString(
                  key: Constants.displayName,
                  value: state.loginEntity.data?.userDisplayName ?? '');
              Prefs.setInt(
                  key: Constants.userId,
                  value: state.loginEntity.data?.userId ?? 0);
              Prefs.setBool(key: Constants.isLogin, value: true);
              navigateTo(
                context: context,
                route: RouteConstants.home,
              );
              break;
            case SignedInStateFailed():
              Utils.dismissLoaderDialog(context);
              Utils.showSnackBar(context, state.dioException.message ?? '');
              break;
            case ForgotPasswordStateSuccess():
              Utils.dismissLoaderDialog(context);
              SingleButtonDialog.showSingleButtonDialog(
                context,
                title: Strings.appName,
                message: state.forgotPasswordEntity.message!,
                button: Strings.continueString,
                callback: () {},
              );
              break;
            case ForgotPasswordStateFailed():
              Utils.dismissLoaderDialog(context);
              Utils.showSnackBar(context, state.dioException.message ?? '');
              break;
            default:
              break;
          }
          if (state is AuthenticationLoading) {
            Utils.showLoaderDialog(context);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.getColor(context).bgColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60.0),
                  Center(
                    child: SizedBox.square(
                      dimension: 200.0,
                      child: Image.asset(
                        MediaRes.icLogoPadded,
                        color: AppColors.getColor(context).primaryColor,
                      ),
                    ),
                  ),
                  Center(
                    child: AI1stTextView(
                      text: Strings.pleaseLogInToContinue,
                      maxLine: 2,
                      textAlign: TextAlign.center,
                      fontFamily: Fonts.futuraNowHeadlineBold,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  AI1stTextView(
                    text: Strings.email,
                    fontFamily: Fonts.futuraNowHeadlineMedium,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  AI1stTextField(
                    controller: _kEmailController,
                    errorText: _kEmailError,
                    textInputAction: TextInputAction.next,
                    hint: Strings.enterYourEmail,
                    inputType: TextInputType.emailAddress,
                    isOutlined: true,
                  ),
                  SizedBox(height: 30.0),
                  AI1stTextView(
                    text: Strings.password,
                    fontFamily: Fonts.futuraNowHeadlineMedium,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  AI1stTextField(
                    controller: _kPasswordController,
                    errorText: _kPasswordError,
                    textInputAction: TextInputAction.done,
                    hint: Strings.enterYourPassword,
                    inputType: TextInputType.text,
                    isOutlined: true,
                    isPassword: true,
                    showPassword: _kShowPassword,
                    onPasswordTap: () {
                      setState(() {
                        _kShowPassword = !_kShowPassword;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: Checkbox(
                          value: _kStayLoggedIn,
                          activeColor: AppColors.getColor(context).colorRed,
                          onChanged: (value) {
                            setState(() {
                              _kStayLoggedIn = !_kStayLoggedIn;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      AI1stTextView(
                        text: Strings.stayLoggedIn,
                        onTap: () {
                          setState(() {
                            _kStayLoggedIn = !_kStayLoggedIn;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  AI1stButton(
                    text: Strings.continueString,
                    onTap: () {
                      if (ValidationHelper.emailValidator(
                            context,
                            _kEmailController.text.trim(),
                            (p0) {
                              setState(() {
                                _kEmailError = p0;
                              });
                            },
                          ) &&
                          ValidationHelper.passwordValidator(
                            context,
                            _kPasswordController.text.trim(),
                            (p0) {
                              setState(() {
                                _kPasswordError = p0;
                              });
                            },
                          )) {
                        _kAuthBloc.add(
                          SignInEvent(
                            signInParams: SignInParams(
                              username: _kEmailController.text.trim(),
                              password: _kPasswordController.text.trim(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  AI1stTextView(
                    text: Strings.forgotPasswordMessage,
                    maxLine: 6,
                  ),
                  Divider(
                    height: 40,
                  ),
                  SafeGestureDetector(
                    onTap: () {
                      if (ValidationHelper.emailValidator(
                        context,
                        _kEmailController.text.trim(),
                        (p0) {
                          setState(() {
                            _kEmailError = p0;
                          });
                        },
                      )) {
                        _kAuthBloc.add(
                          ForgotPasswordEvent(
                            email: _kEmailController.text.trim(),
                          ),
                        );
                      }
                    },
                    child: Center(
                      child: AI1stTextView(
                        text: Strings.forgotPassword,
                        color: AppColors.getColor(context).colorRed,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

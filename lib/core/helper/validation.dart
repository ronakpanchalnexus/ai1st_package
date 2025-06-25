import 'package:bestforming_cac/core/constants/strings.dart';

class ValidationHelper {
  static bool emailValidator(context, String email, Function(String?) error) {
    if (email.isEmpty) {
      error(Strings.emailValidation);
      return false;
    } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+",
    ).hasMatch(email)) {
      error(Strings.validEmailValidation);
      return false;
    } else {
      error(null);
      return true;
    }
  }

  static bool phoneNumberValidator(
    context,
    String mobileNumber,
    Function(String?) error,
  ) {
    if (mobileNumber.isEmpty) {
      error(Strings.phoneNumberValidation);
      return false;
    } else {
      error(null);
      return true;
    }
  }

  static bool passwordValidator(
    context,
    String password,
    Function(String?) error,
  ) {
    if (password.isEmpty) {
      error(Strings.passwordValidation);
      return false;
    } else if (password.length < 8) {
      error(Strings.validPasswordValidation);
      return false;
    } else {
      error(null);
      return true;
    }
  }
}

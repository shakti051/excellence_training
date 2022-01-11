class Validators {
  static String? validateName(String value, String type) {
    String pattern = r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Enter your ${type.toLowerCase()}';
    } else if (regex.hasMatch(value)) {
      return '$type must be a-z and A-Z';
    }
    return null;
  }

  static String? validateEmail(String value) {
    Pattern _ = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r'{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]'
        r'{0,253}[a-zA-Z0-9])?)*$';

    String pat =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    // ignore: omit_local_variable_types
    RegExp regex = RegExp(pat);
    if (value.isEmpty) {
      return 'Enter your email';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
      // if (value == null || value.length <= 0) {
      //   return "Email is Required";
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    String caps = r'^(?=.*[A-Z])';
    if (value.isEmpty) {
      return 'Enter password';
    }
    if (value.length < 8) {
      return 'The password must contain more than 8 letter';
    }
    if (!RegExp(caps).hasMatch(value)) {
      return 'The password must contain a capital alphabet';
    }
    if (!RegExp(r'^(?=.*[@#$%^&+=!_])').hasMatch(value)) {
      return 'The password must contain a special character';
      //if (!regExp.hasMatch(value)) {
    } else {
      return null;
    }
  }

  static String? validateBusinessMobile(String value) {
    // ignore: omit_local_variable_types
    String pattern = r'(^[0-9]*$)';
    // ignore: omit_local_variable_types
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Enter a phone number';
    } else if (value.length != 10) {
      return 'Mobile number must of 10 digits';
    } else if (!regExp.hasMatch(value)) {
      return 'Mobile Number must be digits';
    }
    return null;
  }

  static String? validateRequired(String value, String type) {
    if (value.isEmpty) {
      return 'Enter a $type ';
    }
    // if (value.length < 0 && value.length > 11)
    //   return "Please enter a valid IFSC code";
    else {
      return null;
    }
  }

  static String? validateIfsc(String value, String type) {
    String pat = r'^([A-Z]{4}0[A-Z0-9]{6}$)';
    RegExp rex = RegExp(pat);
    if (value.isEmpty) {
      return 'Enter a $type ';
    }
    if (!rex.hasMatch(value)) {
      return 'Please enter a valid IFSC code';
    } else {
      return null;
    }
  }

  static String? validateNotRequired(String value) {
    return null;
  }

  static String? validatePin(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Pin is required';
    } else if (value.length != 6) {
      return 'Pin must be 6 digits long';
    } else if (!regExp.hasMatch(value)) {
      return 'Pin must be digits';
    }
    return null;
  }
}

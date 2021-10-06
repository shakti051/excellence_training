class Validators {
  static String validateName(String value, String type) {
    Pattern pattern = r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return "Enter your ${type.toLowerCase()}";
    } else if (regex.hasMatch(value)) {
      return "$type must be a-z and A-Z";
    }
    return null;
  }

  static String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";

    Pattern pat =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = new RegExp(pat);
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

  static String validatePassword(String value) {
    String caps = r'^(?=.*[A-Z])';
    if (value == null || value.length <= 0) {
      return "Enter password";
    }
    if (value.length < 8) {
      return 'The password must contain more than 8 letter';
    }
    if (!RegExp(caps).hasMatch(value)) {
      return 'The password must contain a capital alphabet';
    }
    if (!RegExp(r'^(?=.*[@#$%^&+=!_])').hasMatch(value)) {
      return "The password must contain a special character";
      //if (!regExp.hasMatch(value)) {
    } else {
      return null;
    }
  }

  static String validateBusinessMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Enter a phone number";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  static String validateRequired(String value, String type) {
    if (value.length == 0) {
      return "Enter a $type ";
    }
    // if (value.length < 0 && value.length > 11)
    //   return "Please enter a valid IFSC code";
    else
      return null;
  }

  static String validateIfsc(String value, String type) {
    Pattern pat = r'^([A-Z]{4}0[A-Z0-9]{6}$)';
    RegExp rex = new RegExp(pat);
    if (value.length == 0) {
      return "Enter a $type ";
    }
    if (!rex.hasMatch(value))
      return "Please enter a valid IFSC code";
    else
      return null;
  }

  static String validateNotRequired(String value) {
    return null;
  }

  static String validatePin(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Pin is required";
    } else if (value.length != 6) {
      return "Pin must be 6 digits long";
    } else if (!regExp.hasMatch(value)) {
      return "Pin must be digits";
    }
    return null;
  }
}

class ValidationMixin {
  //bool validateEmail(String value) => !value.contains('@') && value.length >= 10 ;

  bool validateName(String value) => value.length >= 4;

  bool validateMobile(String value) => value.length == 10;
  bool validateDOB(String value) => value.isNotEmpty;
}

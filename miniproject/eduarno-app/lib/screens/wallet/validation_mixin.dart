class ValidationMixin {

  String validateWithdraw(String value) {
    if (value.length < 3 )
      return 'withdraw atleast 100';
    if (value.length > 7 )
    return 'withdraw less than Ninety Lakh';
    else
      return null;
      
  }
}
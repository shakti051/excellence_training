import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/Utilities/dimentions.dart';
import 'package:eduarno/screens/wallet/validation_mixin.dart';
import 'package:eduarno/screens/wallet/wallet_provider.dart';
import 'package:eduarno/screens/wallet/wallet_success.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletBottomSheet extends StatefulWidget {
  @override
  _WalletBottomSheetState createState() => _WalletBottomSheetState();
}

class _WalletBottomSheetState extends State<WalletBottomSheet>
    with ValidationMixin {
  final TextEditingController _amountTextController = TextEditingController();
  Razorpay _razorpay;
  final formKey = GlobalKey<FormState>();
//key_id,key_secret
//rzp_test_hr37rXD91BCP7z,wjlgOcWFaNRmyOZ07lf7P1PU
  String bank_code = '0000';
  bool fetch_bank_code = false;
  void getValues() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    bank_code = sharedPrefs.getString('digit_code');
    setState(() {
      fetch_bank_code = true;
    });
    print('bank_code:' + bank_code);
  }

  @override
  void initState() {
    super.initState();
    getValues();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_hr37rXD91BCP7z',
      'amount': int.parse(_amountTextController.text) * 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WalletSuccess()));
    print('Orderid' + response.orderId + ' ' + response.paymentId);
    Fluttertoast.showToast(
        msg: 'SUCCESS: ' + response.paymentId, toastLength: Toast.LENGTH_LONG);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('error msg: ' + response.message);
    Fluttertoast.showToast(
        msg: 'ERROR: ' + response.code.toString() + ' - ' + response.message,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'EXTERNAL_WALLET: ' + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                      opacity: 0,
                      child: Icon(Icons.clear, color: Colors.black54)),
                  Text('Withdraw',
                      style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.clear, color: Colors.black54)),
                ],
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.only(left: 16),
                child: Text(
                    'Note that that the amount will we credited to your linked',
                    style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_SMALL,
                        fontFamily: 'Poppins',
                        color: Colors.black54,
                        fontWeight: FontWeight.w500)),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.MARGIN_SIZE_DEFAULT, right: 4),
                    child: Text('bank account ending with',
                        style: TextStyle(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            fontFamily: 'Poppins',
                            color: Colors.black54,
                            fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    child: Text( "null",//fetch_bank_code ? bank_code : "null",
                        style: TextStyle(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Form(
                key: formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(
                                  left: Dimensions.MARGIN_SIZE_DEFAULT),
                              color: shadowBlue,
                              child: Theme(
                                data: ThemeData(
                                  primaryColor: kLightGreen,
                                  // primaryColorDark: Colors.red,
                                ),
                                child: TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        hintText: 'Amount'),
                                    controller: _amountTextController,
                                    validator: validateWithdraw,
                                    keyboardType: TextInputType.number),
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: 60,
                              margin: EdgeInsets.only(
                                  left: Dimensions.MARGIN_SIZE_DEFAULT),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.green[100],
                                        blurRadius: 4,
                                        offset: Offset(4, 8))
                                  ]),
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                              Provider.of<WalletProvider>(context,listen: false).updateTxnAmount(_amountTextController.text);        
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WalletSuccess(
                                                recentTxn: _amountTextController
                                                    .text)),
                                      );
                                      //  openCheckout();
                                      //  Navigator.pop(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: btnGreen,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Text('Withdraw',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins'))))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT, top: 8, bottom: 16),
                child: Text('Max: 9000000',
                    style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_SMALL,
                        fontFamily: 'Poppins',
                        color: Colors.black54,
                        fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 20),
            ],
          )),
    );
  }
}

class MyCard extends StatelessWidget {
  String amount;
  MyCard({this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: shadowBlue,
      shadowColor: shadowBlue,
      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Text('\$ ' + amount,
              style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  fontFamily: 'Poppins',
                  color: Colors.black87,
                  fontWeight: FontWeight.w400))),
    );
  }
}

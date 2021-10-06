import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/Utilities/dimentions.dart';
import 'package:eduarno/screens/wallet/wallet_bottomsheet.dart';
import 'package:eduarno/screens/wallet/wallet_history_model.dart';
import 'package:eduarno/screens/wallet/wallet_history_service.dart';
import 'package:eduarno/screens/wallet/wallet_list_service.dart';
import 'package:eduarno/screens/wallet/wallet_listing_model.dart';
import 'package:eduarno/screens/wallet/wallet_provider.dart';
import 'package:eduarno/screens/wallet/wallet_transaction_model.dart';
import 'package:eduarno/screens/wallet/wallet_txn_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class Wallet extends StatefulWidget {
  const Wallet({Key key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  WalletHistoryModel walletHistoryModel;
  WalletHistoryService api = WalletHistoryService();
  WalletTrasanctionModel walletTrasanctionModel;
  WalletTxnService apiTxn = WalletTxnService();
  WalletListService apiList = WalletListService();
  WalletListingModel walletListingModel;
  bool _apiHit = false;
  bool apiListStatus = false;
  var walletHistory;
  var walletTransation;
  List<String> updatedAt = List();
  String bank_code;
//B8hhjxATrqCvYzk6g
  _getWalletList() async {
    walletHistory = await apiList.getWalletList().then((value) {
      walletListingModel = value;
      setState(() {
        apiListStatus = true;
      });
      for (int i = 0; i < walletListingModel.data.length; i++) {
        var dt =
            convertTimeStampToHumanDate(walletListingModel.data[i].createdAt);
        updatedAt.add(dt);
      }
      print('Your Wallet amount : ' +
          walletListingModel.data.first.walletAmount.toString());
    });
    return walletHistory;
  }

  _getWalletTxn() async {
    walletTransation = await apiTxn.getWalletTxn(txnAmount:Provider.of<WalletProvider>(context,listen: false).getTxnAmount).then((value) {
      walletTrasanctionModel = value;
      setState(() {
        _apiHit = true;
      });
      
      print("Txn amount : " + walletTrasanctionModel.data.transactionAmount);
    });
    return walletTransation;
  }

  _getWithdraw() async {
    return await api.getWithdrawlist().then((value) {
      walletHistoryModel = value;
      // setState(() {
      //   _apiHit = true;
      // });
      print('payment status: ' + walletHistoryModel.currency);
    });
  }

  String convertTimeStampToHumanDate(int timeStamp) {
    final time = DateTime.now().subtract(Duration(microseconds: timeStamp));
    var dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    var timeFinal = timeago.format(dt).split(' ');
    var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    var timeinit = timeFinal[0] + ' ' + timeFinal[1];
    return timeinit;
  }

  @override
  void initState() {
    super.initState();

    //  _getWithdraw();
    _getWalletTxn();
    _getWalletList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        backwardsCompatibility: true,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        elevation: .6,
        title: Text('Wallet',
            style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                fontFamily: 'Poppins',
                color: Colors.black,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color: kLightGreen),
          onPressed: () => {
            Navigator.pop(context)
            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (_) => MyBottomBar())),
          },
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20, width: MediaQuery.of(context).size.width),
            Image.asset('assets/wallet_img.png'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/rupee.png'), height: 35),
                Text('Wallet Empty',
                    style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(height: 4),
            Text(
              'Wallet balance',
              style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  fontFamily: 'Poppins',
                  color: Colors.black54,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.MARGIN_SIZE_DEFAULT),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green[100],
                                  blurRadius: 4,
                                  offset: Offset(4, 8), // Shadow position
                                )
                              ]),
                          child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) =>
                                        SingleChildScrollView(
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: WalletBottomSheet())));
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: btnGreen,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
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
                Expanded(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Icon(Icons.help, color: Colors.black54),
                    SizedBox(width: 8),
                    Container(
                        margin: EdgeInsets.only(right: 16),
                        child: Text('Need Help ?',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                fontFamily: 'Poppins')))
                  ]),
                )
              ],
            ),
            Divider(
                color: Colors.grey[200],
                height: 40,
                thickness: 2,
                indent: 16,
                endIndent: 16),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: Dimensions.FONT_SIZE_DEFAULT),
              child: Text('History',
                  style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontFamily: 'Poppins',
                      color: Colors.black87,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(height: 20),
            apiListStatus
                ? ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    itemCount: walletListingModel.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xfff6fcfc)),
                        child: ListTile(
                          leading:
                              walletListingModel.data[index].transactionType ==
                                      'withdraw'
                                  ? Icon(Icons.arrow_upward,
                                      size: 24, color: Colors.redAccent)
                                  : Icon(Icons.arrow_downward,
                                      size: 24, color: kLightGreen),
                          title: Text(
                              walletListingModel.data[index].transactionType,
                              style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_SMALL,
                                  fontFamily: 'Poppins',
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500)),
                          subtitle: Text(
                              walletListingModel.data[index].transactionAmount
                                  .toString(),
                              style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_SMALL,
                                  fontFamily: 'Poppins',
                                  color: walletListingModel
                                              .data[index].transactionType ==
                                          'withdraw'
                                      ? Colors.redAccent
                                      : kLightGreen,
                                  fontWeight: FontWeight.w500)),
                          trailing: Text(updatedAt.elementAt(index)),
                        ),
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      )),
    );
  }
}

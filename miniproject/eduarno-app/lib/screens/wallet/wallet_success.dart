import 'package:eduarno/Utilities/dimentions.dart';
import 'package:eduarno/screens/wallet/wallet.dart';
import 'package:eduarno/screens/wallet/wallet_list_service.dart';
import 'package:eduarno/screens/wallet/wallet_listing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eduarno/Utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class WalletSuccess extends StatefulWidget {
  String recentTxn;
  WalletSuccess({this.recentTxn:"100"});

  @override
  _WalletSuccessState createState() => _WalletSuccessState();
}

class _WalletSuccessState extends State<WalletSuccess> {
  WalletListService apiList = WalletListService();
  WalletListingModel walletListingModel;
  List<String> _updatedAt = List();
  var walletTransation;
  var walletHistory;
  bool apiListStatus = false;

  DateTime now = DateTime.now();
  dynamic currentTime = DateFormat.jm().format(DateTime.now());
  _getWalletList() async {
    walletHistory = await apiList.getWalletList().then((value) {
      walletListingModel = value;
      setState(() {
        apiListStatus = true;
      });
      for (int i = 0; i < walletListingModel.data.length; i++) {
        var dt =
            _convertTimeStampToHumanDate(walletListingModel.data[i].createdAt);
        _updatedAt.add(dt);
      }
      // print('Wallet amount : ' +
      //     walletListingModel.data.first.walletAmount.toString());
    });
    return walletHistory;
  }

  String _convertTimeStampToHumanDate(int timeStamp) {
    final time = DateTime.now().subtract(Duration(microseconds: timeStamp));
    var dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    var timeFinal = timeago.format(dt).split(' ');
   // var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    var timeinit = timeFinal[0] + ' ' + timeFinal[1];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(now.day.toString() +"/" +now.month.toString() +"/" + now.year.toString()+ " at "+ now.hour.toString() + ":" + now.minute.toString()) ;
    print(currentTime);
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
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white),
          elevation: .6,
          title: Text(
            'Wallet',
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
              fontFamily: 'Poppins',
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left, color: kLightGreen),
              onPressed: () => {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Wallet()))
                  })),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20, width: MediaQuery.of(context).size.width),
              Image.asset('assets/success_img.png'),
              Text('Success',
                  style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 16),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Rs. "+
                       widget.recentTxn+' has been withdrawn from your wallet on ${now.day.toString()+"/"+now.month.toString() +"/" + now.year.toString()+ " at " +currentTime }',
                      style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                          fontWeight: FontWeight.w400))),
              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Wallet()));
                },
                child: Text('Back to wallet',
                    style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        fontFamily: 'Poppins',
                        color: kLightGreen,
                        fontWeight: FontWeight.w500)),
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
                          fontWeight: FontWeight.w500))),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xfff6fcfc)),
                          child: ListTile(
                            leading: walletListingModel
                                        .data[index].transactionType ==
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
                            trailing: Text("10 min ago"),
                          ),
                        );
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}

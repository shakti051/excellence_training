import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:intl/intl.dart';
import 'package:pay_app/roomBottomSheet2.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HotelDetails extends StatefulWidget {
  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  // Widget roomBottomSheet(BuildContext context) {
  //   return RoomBottomSheet2();
  // }
  String _selectedDate;
  String _dateCount;
  String _range;
  String _rangeCount;
  String _startDate;
  String _endDate;

  @override
  void initState() {
    _selectedDate = '';
    _dateCount = '';
    _range = '';
    _rangeCount = '';
    _startDate = '';
    _endDate = '';
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
        _startDate =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString();
        _endDate = DateFormat('dd/MM/yyyy')
            .format(args.value.endDate ?? args.value.startDate)
            .toString();
      } else if (args.value is DateTime) {
        _selectedDate = args.value;
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  DateTime _checkInDate;
  DateTime _checkOutDate;

  @override
  Widget build(BuildContext context) {
    customDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext c) {
            return Dialog(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: 450,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    //  Text('Selected range: ' + _range),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(right: 1),
                                child: Text(
                                  "From",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white54),
                                ))),
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: 1),
                                child: Text(
                                  "To",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white54),
                                )))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(right: 1),
                                child: Text(
                                  _startDate,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ))),
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: 1),
                                child: Text(
                                  _endDate,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                )))
                      ],
                    ),
                    SfDateRangePicker(
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        onPressed: () {
                          
                        },
                        child: Text("Apply"),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('images/pic.jpg'),
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  //color: Colors.transparent,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Hotel Details',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 21,
                ),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Radission Blue Resort',
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      fontFamily: 'Poppins'),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Color(0xff5CADFF),
                    ),
                    Text(
                      'Devenahalli, Banglore',
                      style: TextStyle(color: Color(0xff5CADFF)),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Container(
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.photo),
                      //       Text('Photos'),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Icon(Icons.home_filled),
                            Text('Getaway Details'),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10, left: 5),
                        child: Row(
                          children: [
                            Icon(Icons.location_pin),
                            Text('Location Details'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Image.asset('hotelsimages/hotel1.jpg'),
                Container(
                  height: 300,
                  child: Carousel(
                    dotColor: Color(0xff8F00D6),
                    indicatorBgPadding: 7.0,
                    autoplay: false,
                    images: [
                      ClipRRect(
                        child: Image.asset('hotelsimages/hotel1.jpg',
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      ClipRRect(
                        child: Image.asset('hotelsimages/hotel2.jpg',
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      ClipRRect(
                        child: Image.asset('hotelsimages/hotel3.jpg',
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Details',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  decoration: BoxDecoration(color: Color(0xffEEEEEE)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Overview',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Text(
                  'The Windflower Prakruthi, on the outskirts of Bangalore is located close to the Devanahalli airport. This scenic, green, well manicured 7 acre resort promises a perfect getaway for couples, families, family get-togethers, weddings and corporate events such as team building activities, off site meetings, product launches or just about anything a holiday maker or corporate may be looking for in a weekend end getaway or a weekday escape.',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  decoration: BoxDecoration(color: Color(0xffEEEEEE)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Facilities',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                //Text('General - Room Service, Air Conditioned, Mini Bar, Cable / Satellite TV, Hair Dryer, TV, Shower.'),
                ListTile(
                  leading: Text('General'),
                  title: Text(
                    'Room Service, Air Conditioned, Mini Bar, Cable / Satellite TV, Hair Dryer, TV, Shower.',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 10),
                  ),
                ),
                ListTile(
                  leading: Text('Services'),
                  title: Text(
                    'Safe-Deposit Box, Self Laundry, Wireless internet on site.',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 10),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Color(0xffEEEEEE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Find the best deals',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff8F00D6),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: <Widget>[
                          TextField(
                            enabled: false,
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.bodyText2,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: _checkInDate == null
                                  ? 'Check In'
                                  : _checkInDate.toString(),
                              contentPadding: const EdgeInsets.fromLTRB(
                                  6, 6, 48, 6), // 48 -> icon width
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.calendar_today_rounded,
                              color: const Color(0xff8F00D6),
                            ),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2050))
                                  .then((date) {
                                setState(() {
                                  _checkInDate = date;
                                });
                              });
                            },
                          ),

                          // FocusScope.of(context).requestFocus(
                          //   FocusNode(),
                          // );
                        ],
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: <Widget>[
                          TextField(
                            enabled: false,
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.bodyText2,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: _checkOutDate == null
                                  ? 'Check Out'
                                  : _checkOutDate.toString(),
                              contentPadding: const EdgeInsets.fromLTRB(
                                  6, 6, 48, 6), // 48 -> icon width
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.calendar_today_rounded,
                              color: const Color(0xff8F00D6),
                            ),
                            onPressed: () {
                              customDialog();
                              // showDatePicker(
                              //         context: context,
                              //         initialDate: DateTime.now(),
                              //         firstDate: DateTime(2021),
                              //         lastDate: DateTime(2050))
                              //     .then(
                              //   (date) {
                              //     setState(
                              //       () {
                              //         _checkOutDate = date;
                              //       },
                              //     );
                              //   },
                              // );
                              // FocusScope.of(context).requestFocus(
                              //   FocusNode(),
                              // );
                            },
                          ),
                        ],
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.person),
                              Text('1 Room   2 Adults 1 Children'),
                              InkWell(
                                child: Icon(Icons.edit),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RoomBottomSheet2(),
                                    ),
                                  );
                                  // showModalBottomSheet(
                                  //     context: context, builder: roomBottomSheet);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Book Now'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

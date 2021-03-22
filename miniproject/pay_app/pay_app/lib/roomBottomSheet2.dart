import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RoomBottomSheet2 extends StatefulWidget {
  @override
  _RoomBottomSheet2State createState() => _RoomBottomSheet2State();
}

class _RoomBottomSheet2State extends State<RoomBottomSheet2> {
  int _counter = 1;


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) _counter--;
    });
  }

  int _childrenCounter = 0;

  void _incrementChildrenCounter (){
    setState(() {
      _childrenCounter++;
    });
  }

  void _decrementChildrenCounter (){
    setState(() {
      if (_childrenCounter > 0) _childrenCounter--;
    });
  }

  // int _value = 1;
  //
  // // var _currentRoomSelected = '1 Room';
  // var _roomDropDownValue = [
  //   '1 Room',
  //   '2 Rooms',
  //   '3 Rooms',
  //   '4 Rooms',
  //   '5 Rooms',
  // ];
  //
  // var _currentAdultSelected = '2 Adults';
  // var _adultDropDownValue = [
  //   '1 Adult',
  //   '2 Adults',
  //   '3 Adults',
  //   '4 Adults',
  // ];
  //
  // var _currentChildrenSelected = '1 children';
  // var _childrenDropDownValue = [
  //   '0 children',
  //   '1 children',
  //   '2 children',
  //   '3 children',
  // ];
  //
  // var _currentChildrenSelectedAge = '1 yr';
  // var _childrenAgeDropDownValue = [
  //   '1 yr',
  //   '2 yr',
  //   '3 yr',
  //   '4 yr',
  //   '5 yr',
  //   '6 yr',
  //   '7 yr',
  //   '8 yr',
  //   '9 yr',
  //   '10 yr',
  //   '11 yr',
  //   '12 yr',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Select Guests & Rooms',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Container(
                //margin: EdgeInsets.all(10),
                //width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(20),
                //   //color: Colors.white,
                // ),
                height: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ROOM 1'),
                              SizedBox(height: 10),
                              Text(
                                'Adults',
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 20),
                              ),
                              Text(
                                '14y and above 14y',
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 10, color: Colors.black54),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _decrementCounter();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    color: Colors.black54,
                                  ),
                                  // margin: EdgeInsets.only(left: 130),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 36,
                                padding: EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  '$_counter',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _incrementCounter();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    color: Colors.black54,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Children',
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 20),
                              ),
                              Text(
                                '13y and above 14y',
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 10, color: Colors.black54),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _decrementChildrenCounter();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    color: Colors.black54,
                                  ),
                                  // margin: EdgeInsets.only(left: 130),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 36,
                                padding: EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  //borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  '$_childrenCounter',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _incrementChildrenCounter();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    color: Colors.black54,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Text(
                    '+ ADD Another Room',
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xff8F00D6),
                  Color(0xffA42AC3),
                ],
              ),
             // shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'DONE ',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Poppins'),
              ),
            ),
          ),
        ],
      ),
    );
    //   ),
    //   body: Container(
    //     // child: Column(
    //     //   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     //   children: [
    //     //     Row(
    //     //       mainAxisAlignment: MainAxisAlignment.center,
    //     //       children: [
    //     //         // Text(
    //     //         //   'ROOM 1',
    //     //         //   style: TextStyle(
    //     //         //       fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
    //     //         // ),
    //     //         // DropdownButton(
    //     //         //     value: _value,
    //     //         //     items: [
    //     //         //       DropdownMenuItem(
    //     //         //         child: Text(" 1 Room"),
    //     //         //         value: 1,
    //     //         //       ),
    //     //         //       DropdownMenuItem(
    //     //         //         child: Text(" 2 Rooms"),
    //     //         //         value: 2,
    //     //         //       ),
    //     //         //       DropdownMenuItem(
    //     //         //         child: Text(" 3 Rooms"),
    //     //         //         value: 3,
    //     //         //       ),
    //     //         //       DropdownMenuItem(
    //     //         //         child: Text(" 4 Rooms"),
    //     //         //         value: 4,
    //     //         //       ),
    //     //         //     ],
    //     //         //     onChanged: (value) {
    //     //         //       setState(() {
    //     //         //         _value = value;
    //     //         //         print("Your list would be long $value");
    //     //         //       });
    //     //         //     }),
    //     //
    //     //
    //     //         // DropdownButton<int>(
    //     //         //   items: _roomDropDownValue.map((int _value) {
    //     //         //     return DropdownMenuItem<int>(
    //     //         //       value: _value,
    //     //         //       child: Padding(
    //     //         //         padding: const EdgeInsets.all(8.0),
    //     //         //         child: Text(),
    //     //         //       ),
    //     //         //     );
    //     //         //   }).toList(),
    //     //         //   onChanged: (value2) {
    //     //         //     setState(() {
    //     //         //       this._value = value2;
    //     //         //     });
    //     //         //   },
    //     //         // ),
    //     //       ],
    //     //     ),
    //         child: ListView.builder(
    //           physics: NeverScrollableScrollPhysics(),
    //           itemCount: _value,
    //           //int.parse(_currentRoomSelected),
    //           shrinkWrap: true,
    //           scrollDirection: Axis.vertical,
    //           itemBuilder: (ctx, i) => Container(
    //             margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
    //             decoration: BoxDecoration(
    //               color: Colors.greenAccent,
    //               borderRadius: BorderRadius.circular(20),
    //             ),
    //             height: 120,
    //             child: Column(
    //               children: [
    //                 Text(
    //                   'ROOM 1',
    //                   style: TextStyle(
    //                       fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
    //                 ),
    //                 //Text('Room $_value'),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Column(
    //                       children: [
    //                         Text(
    //                           'Adults',
    //                           style: TextStyle(
    //                               fontFamily: 'Poppins',
    //                               fontWeight: FontWeight.bold),
    //                         ),
    //                         DropdownButton<String>(
    //                           items: _adultDropDownValue
    //                               .map((String dropDownStringItem) {
    //                             return DropdownMenuItem<String>(
    //                               value: dropDownStringItem,
    //                               child: Padding(
    //                                 padding: const EdgeInsets.all(8.0),
    //                                 child: Text(dropDownStringItem),
    //                               ),
    //                             );
    //                           }).toList(),
    //                           onChanged: (String newValueSelected) {
    //                             setState(() {
    //                               this._currentAdultSelected = newValueSelected;
    //                             });
    //                           },
    //                           value: _currentAdultSelected,
    //                         ),
    //                       ],
    //                     ),
    //                     Column(
    //                       children: [
    //                         Text(
    //                           'Children',
    //                           style: TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               fontFamily: 'Poppins'),
    //                         ),
    //                         DropdownButton<String>(
    //                           items: _childrenDropDownValue
    //                               .map((String dropDownStringItem) {
    //                             return DropdownMenuItem<String>(
    //                               value: dropDownStringItem,
    //                               child: Padding(
    //                                 padding: const EdgeInsets.all(8.0),
    //                                 child: Text(dropDownStringItem),
    //                               ),
    //                             );
    //                           }).toList(),
    //                           onChanged: (String newValueSelected) {
    //                             setState(() {
    //                               this._currentChildrenSelected =
    //                                   newValueSelected;
    //                             });
    //                           },
    //                           value: _currentChildrenSelected,
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //                 // Column(
    //                 //   children: [
    //                 //     Text(
    //                 //       "Children's Age",
    //                 //       style: TextStyle(
    //                 //           fontWeight: FontWeight.bold,
    //                 //           fontFamily: 'Poppins'),
    //                 //     ),
    //                 //     DropdownButton<String>(
    //                 //       items: _childrenAgeDropDownValue
    //                 //           .map((String dropDownStringItem) {
    //                 //         return DropdownMenuItem<String>(
    //                 //           value: dropDownStringItem,
    //                 //           child: Padding(
    //                 //             padding: const EdgeInsets.all(8.0),
    //                 //             child: Text(dropDownStringItem),
    //                 //           ),
    //                 //         );
    //                 //       }).toList(),
    //                 //       onChanged: (String newValueSelected) {
    //                 //         setState(() {
    //                 //           this._currentChildrenSelectedAge =
    //                 //               newValueSelected;
    //                 //         });
    //                 //       },
    //                 //       value: _currentChildrenSelectedAge,
    //                 //     ),
    //                 //   ],
    //                 // ),
    //                 //Divider(color: Colors.blueGrey)
    //               ],
    //             ),
    //           ),
    //         ),
    //         // InkWell(
    //         //   child: Container(
    //         //     margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
    //         //     height: 50,
    //         //     width: MediaQuery.of(context).size.width,
    //         //     decoration: BoxDecoration(
    //         //       gradient: LinearGradient(
    //         //         begin: Alignment.topLeft,
    //         //         end: Alignment.topRight,
    //         //         colors: [
    //         //           Color(0xff8F00D6),
    //         //           Color(0xffA42AC3),
    //         //         ],
    //         //       ),
    //         //       borderRadius: BorderRadius.circular(20),
    //         //     ),
    //         //     child: Center(
    //         //       child: Padding(
    //         //         padding: const EdgeInsets.all(8.0),
    //         //         child: Text(
    //         //           'Apply',
    //         //           style: TextStyle(
    //         //               fontSize: 20,
    //         //               fontWeight: FontWeight.bold,
    //         //               color: Colors.white),
    //         //         ),
    //         //       ),
    //         //     ),
    //         //   ),
    //         // ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

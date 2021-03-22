import 'package:flutter/material.dart';

class RoomBottomSheet extends StatefulWidget {
  @override
  _RoomBottomSheetState createState() => _RoomBottomSheetState();
}

class _RoomBottomSheetState extends State<RoomBottomSheet> {
  var _currentRoomSelected = '1 Room';
  var _roomDropDownValue = [
    '1 Room',
    '2 Rooms',
    '3 Rooms',
    '4 Rooms',
    '5 Rooms',
  ];

  var _currentAdultSelected = '2 Adults';
  var _adultDropDownValue = [
    '1 Adult',
    '2 Adults',
    '3 Adults',
    '4 Adults',
  ];

  var _currentChildrenSelected = '1 children';
  var _childrenDropDownValue = [
    '0 children',
    '1 children',
    '2 children',
    '3 children',
  ];

  var _currentChildrenSelectedAge = '1 yr';
  var _childrenAgeDropDownValue = [
    '1 yr',
    '2 yr',
    '3 yr',
    '4 yr',
    '5 yr',
    '6 yr',
    '7 yr',
    '8 yr',
    '9 yr',
    '10 yr',
    '11 yr',
    '12 yr'
  ];




  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rooms :',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
                DropdownButton<String>(
                  items: _roomDropDownValue.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(dropDownStringItem),
                      ),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    setState(() {
                      this._currentRoomSelected = newValueSelected;
                    });
                  },
                  value: _currentRoomSelected,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Adults',
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      items: _adultDropDownValue.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(dropDownStringItem),
                          ),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this._currentAdultSelected = newValueSelected;
                        });
                      },
                      value: _currentAdultSelected,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Children',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                    ),
                    DropdownButton<String>(
                      items: _childrenDropDownValue.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(dropDownStringItem),
                          ),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this._currentChildrenSelected = newValueSelected;
                        });
                      },
                      value: _currentChildrenSelected,
                    ),
                  ],
                ),

                Column(
                  children: [
                    Text(
                      "Children's Age",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                    ),
                    DropdownButton<String>(
                      items: _childrenAgeDropDownValue.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(dropDownStringItem),
                          ),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this._currentChildrenSelectedAge = newValueSelected;
                        });
                      },
                      value: _currentChildrenSelectedAge,
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xff8F00D6),
                      Color(0xffA42AC3),
                    ],
                  ),
                  
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Apply',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

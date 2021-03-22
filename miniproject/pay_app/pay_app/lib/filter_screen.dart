import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'filter_button.dart';
import 'iconscreens/place_screen.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _currentRangeValues = const RangeValues(10, 400);

  final List _imagesList = [
    {
      'images': 'images/beach.jpg',
      'text': 'Beach',
    },
    {
      'images': 'images/heritage.png',
      'text': 'Heritage',
    },
    {
      'images': 'images/heart.png',
      'text': 'Romantic',
    },
    {
      'images': 'images/hill.png',
      'text': 'Hill',
    },
    {
      'images': 'images/wildlife.png',
      'text': 'Wildlife',
    },
  ];

  bool liked = false;

  void _pressed() {
    setState(() {
      liked = !liked;
    });
  }

  void onPlaceScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return PlacesScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Travel Preferences',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterButton(
                    title: 'Drive',
                    onPressedFunction: _pressed,
                    buttonColor: liked ? Color(0xff8F00D6) : Colors.white),
                FilterButton(
                    title: 'Drive or Fly',
                    onPressedFunction: _pressed,
                    buttonColor: liked ? Color(0xff8F00D6) : Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Distance',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: RangeSlider(
                    activeColor: Color(0xff8F00D6),
                    inactiveColor: Color(0xffC4C4C4),
                    values: _currentRangeValues,
                    min: 0,
                    max: 800,
                    divisions: 16,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
                ),
                Text(
                  'Km',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              'Stay Type',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterButton(
                    title: 'Economy',
                    onPressedFunction: _pressed,
                    buttonColor: liked ? Color(0xff8F00D6) : Colors.white),
                FilterButton(
                    title: 'Mild Range',
                    onPressedFunction: _pressed,
                    buttonColor: liked ? Color(0xff8F00D6) : Colors.white),
                FilterButton(
                    title: 'Luxury',
                    onPressedFunction: _pressed,
                    buttonColor: liked ? Color(0xff8F00D6) : Colors.white),
              ],
            ),
            Text(
              'Interested In',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Container(
                  height: 70,
                  width: 340,
                  child: ListView.builder(
                    itemCount: _imagesList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (filterItem, i) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(right: 4, left: 5.1),
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: ExactAssetImage(
                                _imagesList[i]['images'],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 7),
                          child: Text(
                            _imagesList[i]['text'],
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () => onPlaceScreen(context),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 7),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xff8F00D6),
                      Color(0xffA42AC3),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    'Add Filters',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

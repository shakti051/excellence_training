import '../models/place.dart';
import 'package:flutter/cupertino.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  
  List<Place> get items {
    return [..._items];
  }

}

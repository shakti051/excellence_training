import 'package:eduarno/repo/bloc/profile/model/city.dart';
import 'package:eduarno/repo/bloc/profile/model/location_state.dart';
import 'package:eduarno/repo/bloc/profile/model/user_profile.dart';
import 'package:eduarno/repo/utils/network/callApi.dart';
import 'package:eduarno/widgets/toast.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  static final ProfileProvider _singleton = ProfileProvider._internal();

  factory ProfileProvider() {
    return _singleton;
  }

  ProfileProvider._internal();

  List<LocationState> _locationStateList = [];
  List<City> _cityList = [];
  UserProfile userProfile;
  String _selectedState;
  String _selectedStateId;
  String _selectedCity;
  String _selectedCityId;
  String _isStateSelected = 'false';

  List<LocationState> get locationStateList => _locationStateList;

  List<City> get cityList => _cityList;

  String get selectedState => _selectedState;

  String get selectedStateId => _selectedStateId;

  String get selectedCityId => _selectedCityId;

  String get selectedCity => _selectedCity;

  String get isStateSelected => _isStateSelected;

  set selectedStateId(String value) {
    _selectedStateId = value;
    notifyListeners();
  }

  set selectedCity(String value) {
    _selectedCity = value;
    notifyListeners();
  }

  set selectedCityId(String value) {
    _selectedCityId = value;
    notifyListeners();
  }

  set isStateSelected(String value) {
    _isStateSelected = value;
    notifyListeners();
  }

  set selectedState(String value) {
    _selectedState = value;
    notifyListeners();
  }

  /// fetch all states
  Future<bool> getState() async {
    final data = await callGetApi('get_states');

    if (data['code'] == 200) {
      _locationStateList = List<LocationState>.from(
          data["data"].map((x) => LocationState.fromJson(x)));
      notifyListeners();
      return true;
    }
    ShowToast.show(data['message'] ?? 'Something Went wrong');

    return false;
  }

  /// fetch city by state id
  Future<bool> getCityByStateId(String stateId) async {
    _cityList = [];
    final data = await callApi({
      'state_id': stateId,
    }, 'get_cities_by_state_id');

    if (data['code'] == 200) {
      _cityList = List<City>.from(data["data"].map((x) => City.fromJson(x)));
      notifyListeners();
      return true;
    }

    ShowToast.show(data['message'] ?? 'Something Went wrong');

    return false;
  }

  /// set users personal profile
  Future<bool> setPersonalProfile(
      {String id,
      String name,
      String phone,
      String phoneCountryCode,
      String whatsapp,
      String whatsAppCountryCode,
      String accountNumber,
      String ifscCode,
      String state,
      String city,
      String pinCode}) async {
    final data = await callApi({
      'id': id,
      'name': name,
      'user_contact': phone,
      'user_contact_country_code': phoneCountryCode,
      'user_contact_whatsapp': whatsapp,
      'user_whatsapp_country_code': whatsAppCountryCode,
      'user_account': accountNumber,
      'user_ifsc': ifscCode,
      'user_city': city,
      'user_state': state,
      'user_pincode': pinCode,
    }, 'user/personal_update_profile_user_by_id');
    try {
      if (data['code'] == 200) {
        userProfile = List<UserProfile>.from(
            data["data"].map((x) => UserProfile.fromJson(x)))[0];
        notifyListeners();
        return true;
      }
    } catch (e) {}

    ShowToast.show(data['message'] ?? 'Something Went wrong');

    return false;
  }

  /// set users personal profile
  Future<bool> getPersonalProfile(String id) async {
    final data = await callApi({
      'id': id,
    }, 'user/user_by_id');
    try {
      if (data['code'] == 200) {
        userProfile = List<UserProfile>.from(
            data["data"].map((x) => UserProfile.fromJson(x)))[0];
        // User().name = userProfile.userName;
        notifyListeners();
        return true;
      }
    } catch (e) {}

    ShowToast.show(data['message'] ?? 'Something Went wrong');
    
    return false;
  }
}

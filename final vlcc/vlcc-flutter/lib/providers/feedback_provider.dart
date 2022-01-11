import 'package:flutter/material.dart';
import 'package:vlcc/models/offer_banner_model.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';

class FeedbackProvider extends ChangeNotifier {
  static final FeedbackProvider _singleton = FeedbackProvider._internal();

  factory FeedbackProvider() {
    return _singleton;
  }
  FeedbackProvider._internal();
  final Services _services = Services();

  OfferBannerModel _offerBannerModel = OfferBannerModel();
  OfferBannerModel get offerBannerModel => _offerBannerModel;

  List<BannerUnit> _bannerList = [];
  List<BannerUnit> get bannerList => _bannerList;

  Future<void> getOfferBanner() async {
    // ---------------------> This api will get the offer banner <------------------------------
    var offerBody = {'offerbanner': 'offerbanner'};
    _services
        .callApi(offerBody, '/India/api/offerbanner',
            apiName: 'Get offer banner', isHttp: false)
        .then((value) {
      var offerBanner = value;
      final offerBannerMod = offerBannerModelFromJson(offerBanner);
      _offerBannerModel = offerBannerMod;
      _bannerList = offerBannerMod.banner ?? [];
      notifyListeners();
    });
  }

  bool _yes = true;
  bool _no = false;
  bool _oneStar = true;
  bool _twoStar = false;
  bool _threeStar = false;
  bool _fourStar = false;
  bool _fiveStar = false;
  //Time
  bool _onTime = false;
  bool _tenMin = false;
  bool _thirtyMin = false;
  bool _twoHour = false;

  get getOnTime => _onTime;
  get getTen => _tenMin;
  get getThirtyMin => _thirtyMin;
  get getTwoHour => _twoHour;

  get getYes => _yes;
  get getNo => _no;
  get oneStar => _oneStar;
  get twoStar => _twoStar;
  get threeStar => _threeStar;
  get fourStar => _fourStar;
  get fiveStar => _fiveStar;

  void selectOnTime() {
    _onTime = true;
    _tenMin = false;
    _thirtyMin = false;
    _twoHour = false;
    notifyListeners();
  }

  void selectTenMin() {
    _onTime = false;
    _tenMin = true;
    _thirtyMin = false;
    _twoHour = false;
    notifyListeners();
  }

  void selectThirtyMin() {
    _onTime = false;
    _tenMin = false;
    _thirtyMin = true;
    _twoHour = false;
    notifyListeners();
  }

  void selectTwoHour() {
    _onTime = false;
    _tenMin = false;
    _thirtyMin = false;
    _twoHour = true;
    notifyListeners();
  }

  void selectOneStar() {
    _oneStar = !_oneStar;
    getRating();
    notifyListeners();
  }

  void selectTwoStar() {
    _twoStar = !_twoStar;
    getRating();
    notifyListeners();
  }

  void selectThreeStar() {
    _threeStar = !_threeStar;
    getRating();
    notifyListeners();
  }

  void selectFourStar() {
    _fourStar = !_fourStar;
    getRating();
    notifyListeners();
  }

  void selectFiveStar() {
    _fiveStar = !_fiveStar;
    getRating();
    notifyListeners();
  }

  void getRating() {
    // if (_oneStar == false) {
    //   _twoStar = false;
    //   _threeStar = false;
    //   _fourStar = false;
    //   _fiveStar = false;
    // }
    // if (_twoStar == false) {
    //   _threeStar = false;
    //   _fourStar = false;
    //   _fiveStar = false;
    // }
    // if (_threeStar == false) {
    //   _fourStar = false;
    //   _fiveStar = false;
    // }
    // if (_fourStar == false) {
    //   _fiveStar = false;
    // }
    if (_twoStar == true) {
      _oneStar = true;
    }
    if (_threeStar == true) {
      _oneStar = true;
      _twoStar = true;
    }
    if (_fourStar == true) {
      _oneStar = true;
      _twoStar = true;
      _threeStar = true;
    }
    if (_fiveStar == true) {
      _oneStar = true;
      _twoStar = true;
      _threeStar = true;
      _fourStar = true;
    }
    notifyListeners();
  }

  void selectYes() {
    _no = false;
    _yes = true;
    notifyListeners();
  }

  void selectNo() {
    _no = true;
    _yes = false;
    notifyListeners();
  }
}

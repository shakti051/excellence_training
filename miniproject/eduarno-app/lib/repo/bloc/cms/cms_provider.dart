import 'package:eduarno/repo/bloc/cms/model/CMSItem.dart';
import 'package:eduarno/repo/utils/network/callApi.dart';
import 'package:eduarno/widgets/toast.dart';
import 'package:flutter/widgets.dart';

class CMSProvider extends ChangeNotifier {
  static final CMSProvider _singleton = CMSProvider._internal();

  factory CMSProvider() {
    return _singleton;
  }

  CMSProvider._internal();

  List<CMSItem> _cmsItemList = [];

  List<CMSItem> get cmsItemList => _cmsItemList;

  /// fetch all cms
  Future<bool> getCMS() async {
    final data = await callGetApi('get_cms');

    if (data['code'] == 200) {
      _cmsItemList =
          List<CMSItem>.from(data["data"].map((x) => CMSItem.fromJson(x)));
      notifyListeners();
      return true;
    }
    ShowToast.show(data['message'] ?? 'Something Went wrong');

    return false;
  }
}

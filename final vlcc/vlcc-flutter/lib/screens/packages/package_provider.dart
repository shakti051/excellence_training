import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:vlcc/models/cash_invoice.dart';
import 'package:vlcc/models/package_invoice_listing.dart';
import 'package:vlcc/models/package_listing_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/apiHandler/api_url/api_url.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/widgets/signup_widgets/profile_provider.dart';

class PackageProvider extends ChangeNotifier {
  static final PackageProvider _singleton = PackageProvider._internal();

  factory PackageProvider() {
    return _singleton;
  }

  PackageProvider._internal();

  final ProfileProvider _profileProvider = ProfileProvider();
  //-------------------------------------> Store cash Invoice <--------------------------
  CashBookingInvoiceModel _cashBookingInvoiceModel = CashBookingInvoiceModel();
  CashBookingInvoiceModel get cashBookingInvoiceModel =>
      _cashBookingInvoiceModel;

  // ---------------------------------> Store Package Invoice <---------------------------------------
  PackageInvoiceListing _packageInvoiceListingModel = PackageInvoiceListing();
  PackageInvoiceListing get packageInvoiceListingModel =>
      _packageInvoiceListingModel;
  // ---------------------------------> Store Packages <---------------------------------------
  PackageListingModel _packageListingModel = PackageListingModel();
  PackageListingModel get packageListingModel => _packageListingModel;
  final Services _services = Services();
  final VlccShared _vlccShared = VlccShared();

  List<PackageDetail> _activePackages = [];
  List<PackageDetail> get activePackages => _activePackages;
  set activePackages(List<PackageDetail> activePackageDetailValue) {
    _activePackages = activePackageDetailValue;
    notifyListeners();
  }

  List<PackageDetail> _inActivePackages = [];
  List<PackageDetail> get inActivePackages => _inActivePackages;
  set inActivePackages(List<PackageDetail> inActivePackageDetailValue) {
    _inActivePackages = inActivePackageDetailValue;
    notifyListeners();
  }

  Future<void> getCashInvoice() async {
    var body = {
      'auth_token': _vlccShared.authToken,
      'device_id': _vlccShared.deviceId,
      'client_mobile': _vlccShared.mobileNum,
    };
    _services
        .callApi(body, ApiUrl.cashInvoiceApi, apiName: 'Cash booking invoice')
        .then((value) {
      var modelValue = value;
      var jsonTest = json.decode(value);
      if (jsonTest['Status'] == 2000) {
        final cashBookin = cashBookinInvoiceModelFromJson(modelValue);
        _cashBookingInvoiceModel = cashBookin;
      }
      notifyListeners();
    });
  }

  Future<void> getPackageModelData() async {
    var body = {
      'auth_token': _vlccShared.authToken,
      'device_id': _vlccShared.deviceId,
      'client_mobile': _vlccShared.mobileNum,
    };
    _services.callApi(body, ApiUrl.packageListingUrl).then((value) {
      var modelValue = value;
      // var modelValue = ApiUrl.packageListingModelResponse;
      var jsonTest = json.decode(value);
      if (jsonTest['Status'] == 2000) {
        final packageListing = packageListingFromJson(modelValue);
        _packageListingModel = packageListing;

        var todaysDate = DateTime.now();
        _activePackages.clear(); // Clearing the list before append function
        _inActivePackages.clear(); // Clearing the list before append function
        List<bool> renewStatusType = [];
        var inactiveCount = 0;
        for (var package in _packageListingModel.packageDetails!) {
          if (todaysDate.isBefore(package.bookingExpiryDate ?? todaysDate)) {
            _activePackages.add(package);
          } else {
            _inActivePackages.add(package);
            inactiveCount++;
            renewStatusType
                .add(package.renewStatus.toLowerCase() == 'yes' ? true : false);
          }
        }
        _profileProvider.setPackageRenewStatus(renewList: renewStatusType);
      }
      notifyListeners();
    });
  }

  Future<void> getPackageInvoice() async {
    var body = {
      'auth_token': _vlccShared.authToken,
      'device_id': _vlccShared.deviceId,
      'client_mobile': _vlccShared.mobileNum,
    };
    _services.callApi(body, ApiUrl.packageInvoiceListing).then((value) {
      var modelValue = value;
      // var modelValue = ApiUrl.packageInvoiceDetailsListingResponse;
      var jsonTest = json.decode(value);
      if (jsonTest['Status'] == 2000) {
        final packageInvoiceListing = packageInvoiceListingFromJson(modelValue);
        _packageInvoiceListingModel = packageInvoiceListing;
      }
      notifyListeners();
    });
  }

  Future<InvoiceDetail> getPackageSpecificInvoice(
      {required String packageName}) async {
    final invoice = _packageInvoiceListingModel.invoiceDetails!.firstWhere(
        (invoice) => invoice.invoicePackageBooingNumber == packageName,
        orElse: () {
      return InvoiceDetail();
    });
    return invoice;
  }

  Color _packageCardColor = AppColors.randomColor;
  Color get packageCardColor => _packageCardColor;
  set packageCardColor(Color color) {
    _packageCardColor = color;
    notifyListeners();
  }
}

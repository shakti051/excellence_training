import 'dart:developer';

import 'package:get/get.dart';
import 'package:payumoney_pro_unofficial/payumoney_pro_unofficial.dart';
import 'package:uuid/uuid.dart';
import 'package:vlcc/screens/appointments/appointment_requested.dart';

class PayUMoneyVlcc {
  // final String amount = "1";

  // Phone Number should be 10 digits. Please validate it before passing else it will throw error.
  // hashUrl is required. check github documentation for nodejs code.
  Future<void> callPaymentMethod(
      {required String amount,
      required String centerName,
      required String serviceName,
      required String db,
      required String preferredTime}) async {
    var response = await PayumoneyProUnofficial.payUParams(
      email: 'test@example.com',
      firstName: "Vlcc",
      merchantName: 'VLCC Wellness',
      isProduction: true,
      merchantKey:
          'uBcYW4', //You will find these details from payumoney dashboard
      merchantSalt: 'a78BVon9',
      amount: amount,
      productInfo: serviceName, // Enter Product Name
      transactionId: Uuid().v4(), //Every Transaction should have a unique ID
      hashUrl: '',
      userCredentials: 'merchantKey:test@example.com',
      showLogs: true,
      userPhoneNumber: '9999999999',
    );

    if (response['status'] == PayUParams.success) {
      handlePaymentSuccess(
        amount,
        centerName: centerName,
        db: '',
        serviceName: serviceName,
        preferredTime: preferredTime,
      );
    }

    if (response['status'] == PayUParams.failed) {
      handlePaymentFailure(amount, response['message']);
    }
  }

  // Function to implement business login on payment success
  handlePaymentSuccess(String amount,
      {required String centerName,
      required String serviceName,
      required String db,
      required String preferredTime}) {
    log("Success");
    Get.to(AppointmentRequested(
      centerName: centerName,
      serviceName: serviceName,
      date: db,
      time: preferredTime,
    ));
  }

  handlePaymentFailure(String amount, String error) {
    log("Failed");
    log('', error: error);
  }
}

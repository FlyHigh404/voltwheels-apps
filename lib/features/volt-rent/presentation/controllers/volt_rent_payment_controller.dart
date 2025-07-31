import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:voltwheels_mobile/core/utils/date_utils.dart';
import 'package:voltwheels_mobile/core/utils/generate_id.dart';
import 'package:voltwheels_mobile/features/volt-rent/domain/entities/volt_rent_order.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/services/mid_trans_qris_model.dart';

import '../../domain/entities/volt_rent_vechile.dart';
import '../pages/volt_rent_webview_payment.dart';
import '../services/midtrans_qris_service.dart';

class VoltRentPaymentController extends GetxController {
  final RxInt activeStepper = Get.arguments['active_stepper'] != null
      ? (Get.arguments['active_stepper'] as int).obs
      : 1.obs;

  final Rx<MidtransResponse?> midtransResponse = Rx<MidtransResponse?>(null);

  final RxString orderId = Get.arguments['order_id'] != null
      ? (Get.arguments['order_id'] as String).obs
      : ''.obs;

  var remainingTime = ''.obs;

  Timer? _timer;

  Timer? _statusTimer;

  final Rx<VoltRentVehicle> voltRenVehicle =
      (Get.arguments['vehicle'] as VoltRentVehicle).obs;

  final Duration rentDuration = Get.arguments['duration'] as Duration;

  int? totalPrice = 0;

  final Rx<VoltRentOrder?> voltRentOrder = Rx<VoltRentOrder?>(null);

  void updateStepper(int value) {
    activeStepper.value = value;
  }

  void updateMidtransResponse(MidtransResponse value) {
    midtransResponse.value = value;
  }

  void startPolling(String orderId) {
    _statusTimer?.cancel();
    _fetchOrderStatus(orderId);

    _statusTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _fetchOrderStatus(orderId);
    });
  }

  Future<void> _fetchOrderStatus(String orderId) async {
    final result = await MidtransService.getOrderStatus(orderId);

    result.fold(
      (error) {
        print(error);
      },
      (status) {
        print(status['transaction_status']);
        print(status);

        if (status['transaction_status'] == 'settlement') {
          _statusTimer?.cancel();
          MidtransService.storeOrderDetailsToFirestore(status);
          updateStepper(3);
        }
      },
    );
  }

  Future<void> onClickPaymentQris() async {
    EasyLoading.show(status: "Generate QR code");
    final result = await MidtransService.createQrisTransaction(
      grossAmount: totalPrice ?? 0,
      name: FirebaseAuth.instance.currentUser?.displayName ?? "Johnn",
      email: FirebaseAuth.instance.currentUser?.email ?? "Jonn@gmail.com",
    );

    result.match(
      (error) => print(error),
      (data) {
        updateMidtransResponse(data);
        updateStepper(2);
        print(data.actions.firstOrNull?.url ?? '');
        startPolling(data.orderId);
        startCountdown(
            expiryTime: data.expiryTime, startTime: data.transactionTime);
      },
    );

    EasyLoading.dismiss();
  }

  void startCountdown(
      {required DateTime expiryTime, required DateTime startTime}) {
    _timer?.cancel();
    // final duration = expiryTime.difference(DateTime.now());

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = expiryTime.difference(DateTime.now());
      if (remaining.isNegative) {
        _timer?.cancel();
        remainingTime.value = "00:00";
      } else {
        remainingTime.value = formatDurationTimer(remaining);
      }
    });
  }



  Future<String?> fetchCustomerDetails() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      String email = user.email ?? '';
      try {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(email)
                .get();
        Map<String, dynamic> data = snapshot.data() ?? {};
        print("data: $data");
        String? phoneNumber = data['phoneNumber'];
        return phoneNumber;
      } catch (e) {
        print('Error fetching data: $e');
      }
    } else {
      throw Exception('User not logged in');
    }
    return null;
  }

  String generateStartTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('yyyy-MM-dd HH:mm Z').format(now);
    return formattedTime;
  }

  Future<Map<String, dynamic>?> generatePaymentLink() async {
    EasyLoading.show(status: "Generate payment link");
    String? phoneNumber = await fetchCustomerDetails();

    String serverKey = dotenv.env['MIDTRANS_SERVER_KEY_PRODUCTION']!;
    String authString = base64Encode(utf8.encode('$serverKey:'));

    String url = '${dotenv.env['MIDTRANS_BASE_URL']}/v1/payment-links';

    Map<String, dynamic> requestBody = {
      "transaction_details": {
        "order_id": generateId(featureCode: 'VR'),
        "gross_amount": totalPrice,
      },
      "customer_required": true,
      "usage_limit": 1,
      "expiry": {
        "start_time": generateStartTime(),
        "duration": 1,
        "unit": "days"
      },
      "item_details": [
        {
          "id": "sem-001",
          "name": voltRenVehicle.value.name,
          "price": totalPrice,
          "quantity": 1,
          "brand": "VoltRent",
          "category": "Transport",
          "merchant_name": "VoltRent"
        }
      ],
      "customer_details": {
        "first_name": FirebaseAuth.instance.currentUser?.displayName,
        "email": FirebaseAuth.instance.currentUser?.email,
        "phone": phoneNumber ?? '+620000',
      },
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Basic $authString',
      },
      body: jsonEncode(requestBody),
    );

    EasyLoading.dismiss();

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      orderId.value = responseData['order_id'];
      print(responseData);
      return responseData;
    } else {
      print(
          'Failed to create payment link. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  }

  void onClickWebView(BuildContext context) async {
    try {
      Map<String, dynamic>? responseData = await generatePaymentLink();
      String paymentLink = responseData?['payment_url'];
      String orderId = responseData?['order_id'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PaymentWebView(url: paymentLink, orderId: orderId),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred: $e'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  void onInit() {
    totalPrice = Get.arguments['total'] + 0;
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _statusTimer?.cancel();
    super.onClose();
  }
}

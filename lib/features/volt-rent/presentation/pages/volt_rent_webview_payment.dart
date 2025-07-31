import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/controllers/volt_rent_payment_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentWebView extends StatefulWidget {
  final String url;
  final String orderId;

  const PaymentWebView({
    super.key,
    required this.url,
    required this.orderId,
  });

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _webViewController;
  bool isLoading = true;
  final VoltRentPaymentController voltRentPaymentController =
      Get.find<VoltRentPaymentController>();
  late Timer _timer;

  void initWebView(String url) {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(
        Uri.parse(url),
        method: LoadRequestMethod.get,
      );
  }

  @override
  void initState() {
    super.initState();
    initWebView(widget.url);
    _startPollingPaymentStatus();
  }

  void _startPollingPaymentStatus() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await _checkPaymentStatus();
    });
  }

  Future<void> _checkPaymentStatus() async {
    String serverKey = dotenv.env['MIDTRANS_SERVER_KEY_PRODUCTION']!;
    String authString = base64Encode(utf8.encode('$serverKey:'));

    String url =
        '${dotenv.env['MIDTRANS_BASE_URL']}/v1/payment-links/${widget.orderId}/status';

    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Basic $authString',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      String transactionStatus =
          responseData['purchase_history'][0]['transaction_status'];
      print('Payment status: $transactionStatus');

      if (transactionStatus == 'settlement') {
        await _storeOrderDetailsToFirestore(responseData);
        _timer.cancel();
        voltRentPaymentController.orderId.value =
            responseData['purchase_history'][0]['order_id'];
        Get.back();
        voltRentPaymentController.updateStepper(3);
      }
    } else {
      print(
          'Failed to check payment status. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> _storeOrderDetailsToFirestore(
      Map<String, dynamic> responseData) async {
    try {
      String orderId = responseData['purchase_history'][0]['order_id'];

      Map<String, dynamic> orderData = {
        'order_id': orderId,
        'vehicle_id': voltRentPaymentController.voltRenVehicle.value.id,
        'user_id': FirebaseAuth.instance.currentUser?.uid,
        'name': FirebaseAuth.instance.currentUser?.displayName,
        'email': FirebaseAuth.instance.currentUser?.email,
        'timestamp': FieldValue.serverTimestamp(),
        'payment_details': responseData,
        'start_time': DateTime.now(),
        'expiry_time': DateTime.now().add(
          Duration(hours: voltRentPaymentController.rentDuration.inHours),
        )
      };

      await FirebaseFirestore.instance.collection('orders').add(orderData);
      print('Order details saved to Firestore');
    } catch (e) {
      print('Failed to save order details to Firestore: $e');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : WebViewWidget(
              controller: _webViewController,
            ),
    );
  }
}

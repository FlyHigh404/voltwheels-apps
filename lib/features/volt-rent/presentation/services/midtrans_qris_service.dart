import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'mid_trans_qris_model.dart';

class MidtransService {
  static  String apiUrl = '${dotenv.env['MIDTRANS_BASE_URL']}/v2/charge';
  static const String serverKey =
      'U0ItTWlkLXNlcnZlci1ZRlVmVWlCclpwUG5ESlR1SlRsdlUwcUo6';
  static const _uuid = Uuid();
  static String prodServerKey =
      base64Encode(utf8.encode('${dotenv.env['MIDTRANS_SERVER_KEY_PRODUCTION']}:'));

  static Future<Either<String, MidtransResponse>> createQrisTransaction({
    required int grossAmount,
    required String name,
    required String email,
  }) async {
    final String orderId = _uuid.v4();

    var options = Options(
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json',
        'authorization': 'Basic $prodServerKey',
      },
    );

    var data = {
      'payment_type': 'qris',
      'transaction_details': {
        'order_id': orderId,
        'gross_amount': grossAmount,
      },
      'customer_details': {
        'first_name': name,
        'email': email,
      },
      'qris': {'acquirer': 'gopay'},
    };

    try {
      var response = await Dio().post(apiUrl, data: data, options: options);

      if (response.data['status_code'] == '200') {
        return right(MidtransResponse.fromJson(response.data));
      }

      return left(response.data.toString());
    } on DioException catch (e) {
      if (e.response != null) {
        return left('Error: ${e.response!.data}');
      } else {
        return left('Error sending request!');
      }
    }
  }

  static Future<Either<String, Map<String, dynamic>>> getOrderStatus(
      String orderId) async {
    try {
      final response = await GetIt.instance<Dio>().get(
        '${dotenv.env['MIDTRANS_BASE_URL']}/v2/$orderId/status',
        options: Options(
          headers: {
            'accept': 'application/json',
            'authorization': 'Basic $prodServerKey',
          },
        ),
      );

      if (response.statusCode == 200) {
        return right(response.data as Map<String, dynamic>);
      } else {
        return left(
            'Failed to fetch order status with code ${response.statusCode}');
      }
    } catch (e) {
      return left('Error fetching order status: $e');
    }
  }

  static Future<void> storeOrderDetailsToFirestore(
      Map<String, dynamic> responseData) async {
    try {
      String orderId = responseData['order_id'];

      Map<String, dynamic> orderData = {
        'order_id': orderId,
        'name': FirebaseAuth.instance.currentUser?.displayName,
        'email': FirebaseAuth.instance.currentUser?.email,
        'timestamp': FieldValue.serverTimestamp(),
        'payment_details': responseData,
      };

      await FirebaseFirestore.instance.collection('orders').add(orderData);
      print('Order details saved to Firestore');
    } catch (e) {
      print('Failed to save order details to Firestore: $e');
    }
  }
}

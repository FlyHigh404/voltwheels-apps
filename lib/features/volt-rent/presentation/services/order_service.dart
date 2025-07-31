import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/features/volt-rent/data/models/volt_rent_order_model.dart';

class OrderService {
  static Future<Either<String, List<VoltRentOrderModel>>> getOrdersByUserId(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('user_id', isEqualTo: userId)
          .get();

      List<VoltRentOrderModel> orders = querySnapshot.docs.map((doc) {
        return VoltRentOrderModel.fromFirestore(doc);
      }).toList();

      return right(orders);
    } catch (e) {
      return left('Failed to retrieve order details: $e');
    }
  }

  static Future<Either<String, VoltRentOrderModel?>> getOrderByUserIdAndOrderId(
      String userId, String orderId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('user_id', isEqualTo: userId)
          .where('order_id', isEqualTo: orderId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return right(
            VoltRentOrderModel.fromFirestore(querySnapshot.docs.first));
      } else {
        return left("Data empty");
      }
    } catch (e) {
      return left('Failed to retrieve order: $e');
    }
  }

  static Future<Either<String, VoltRentOrderModel?>> getLatestOrderByUserId(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('user_id', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return right(
            VoltRentOrderModel.fromFirestore(querySnapshot.docs.first));
      } else {
        return right(null); // No orders found
      }
    } catch (e) {
      return left('Failed to retrieve the latest order: $e');
    }
  }
}

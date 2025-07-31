import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voltwheels_mobile/core/error/exceptions.dart';

import '../models/volt_rent_order_model.dart';

abstract class VoltRentOrderRemoteDatasource {
  Future<List<VoltRentOrderModel>> getOrder(String userId);
}

class VoltRentOrderRemoteDatasourceImpl
    implements VoltRentOrderRemoteDatasource {
  @override
  Future<List<VoltRentOrderModel>> getOrder(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('user_id', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      List<VoltRentOrderModel> orders = querySnapshot.docs.map((doc) {
        return VoltRentOrderModel.fromFirestore(doc);
      }).toList();

      return orders;
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}

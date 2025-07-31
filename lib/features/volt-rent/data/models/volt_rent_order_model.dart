import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voltwheels_mobile/features/volt-rent/domain/entities/volt_rent_order.dart';

class VoltRentOrderModel extends VoltRentOrder {
  const VoltRentOrderModel({
    required super.orderId,
    required super.userId,
    super.name,
    super.email,
    required super.timestamp,
    required super.paymentDetails,
    required super.startTime,
    required super.expiryTime,
    required super.vehicleId,
  });

  factory VoltRentOrderModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return VoltRentOrderModel(
      orderId: data['order_id'] ?? '',
      userId: data['user_id'] ?? '',
      vehicleId: data['vehicle_id'] ?? '',
      name: data['name'],
      email: data['email'],
      timestamp: data['timestamp'],
      paymentDetails: Map<String, dynamic>.from(data['payment_details']),
      startTime: (data['start_time'] as Timestamp).toDate(),
      expiryTime: (data['expiry_time'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'name': name,
      'email': email,
      'timestamp': timestamp,
      'payment_details': paymentDetails,
      'start_time': Timestamp.fromDate(startTime),
      'expiry_time': Timestamp.fromDate(expiryTime),
    };
  }

  factory VoltRentOrderModel.fromJson(Map<String, dynamic> json) {
    return VoltRentOrderModel(
      orderId: json['order_id'] ?? '',
      userId: json['user_id'] ?? '',
      vehicleId: json['vehicle_id'],
      name: json['name'],
      email: json['email'],
      timestamp: Timestamp.fromDate(DateTime.parse(json['timestamp'])),
      paymentDetails: Map<String, dynamic>.from(json['payment_details']),
      startTime: DateTime.parse(json['start_time']),
      expiryTime: DateTime.parse(json['expiry_time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'name': name,
      'email': email,
      'timestamp': timestamp,
      'payment_details': paymentDetails,
      'start_time': startTime.toIso8601String(),
      'expiry_time': expiryTime.toIso8601String(),
    };
  }
}

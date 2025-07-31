import 'package:cloud_firestore/cloud_firestore.dart';

class VoltRentOrder {
  final String orderId;
  final String vehicleId;
  final String userId;
  final String? name;
  final String? email;
  final Timestamp timestamp;
  final Map<String, dynamic> paymentDetails;
  final DateTime startTime;
  final DateTime expiryTime;

  const VoltRentOrder({
    required this.orderId,
    required this.userId,
    required this.vehicleId,
    this.name,
    this.email,
    required this.timestamp,
    required this.paymentDetails,
    required this.startTime,
    required this.expiryTime,
  });
}

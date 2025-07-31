import 'dart:convert';

class MidtransTransactionResponse {
  final String transactionTime;
  final double grossAmount;
  final String currency;
  final String orderId;
  final String paymentType;
  final String signatureKey;
  final String statusCode;
  final String transactionId;
  final String transactionStatus;
  final String fraudStatus;
  final String expiryTime;
  final String settlementTime;
  final String statusMessage;
  final String merchantId;
  final String transactionType;
  final String issuer;
  final String acquirer;

  MidtransTransactionResponse({
    required this.transactionTime,
    required this.grossAmount,
    required this.currency,
    required this.orderId,
    required this.paymentType,
    required this.signatureKey,
    required this.statusCode,
    required this.transactionId,
    required this.transactionStatus,
    required this.fraudStatus,
    required this.expiryTime,
    required this.settlementTime,
    required this.statusMessage,
    required this.merchantId,
    required this.transactionType,
    required this.issuer,
    required this.acquirer,
  });

  factory MidtransTransactionResponse.fromJson(Map<String, dynamic> json) {
    return MidtransTransactionResponse(
      transactionTime: json['transaction_time'],
      grossAmount: double.parse(json['gross_amount']),
      currency: json['currency'],
      orderId: json['order_id'],
      paymentType: json['payment_type'],
      signatureKey: json['signature_key'],
      statusCode: json['status_code'],
      transactionId: json['transaction_id'],
      transactionStatus: json['transaction_status'],
      fraudStatus: json['fraud_status'],
      expiryTime: json['expiry_time'],
      settlementTime: json['settlement_time'],
      statusMessage: json['status_message'],
      merchantId: json['merchant_id'],
      transactionType: json['transaction_type'],
      issuer: json['issuer'],
      acquirer: json['acquirer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_time': transactionTime,
      'gross_amount': grossAmount,
      'currency': currency,
      'order_id': orderId,
      'payment_type': paymentType,
      'signature_key': signatureKey,
      'status_code': statusCode,
      'transaction_id': transactionId,
      'transaction_status': transactionStatus,
      'fraud_status': fraudStatus,
      'expiry_time': expiryTime,
      'settlement_time': settlementTime,
      'status_message': statusMessage,
      'merchant_id': merchantId,
      'transaction_type': transactionType,
      'issuer': issuer,
      'acquirer': acquirer,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

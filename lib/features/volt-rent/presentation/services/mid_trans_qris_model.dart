class MidtransResponse {
  final String statusCode;
  final String statusMessage;
  final String transactionId;
  final String orderId;
  final String merchantId;
  final double grossAmount;
  final String currency;
  final String paymentType;
  final DateTime transactionTime;
  final String transactionStatus;
  final String fraudStatus;
  final List<Action> actions;
  final String qrString;
  final String acquirer;
  final DateTime expiryTime;

  MidtransResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.transactionId,
    required this.orderId,
    required this.merchantId,
    required this.grossAmount,
    required this.currency,
    required this.paymentType,
    required this.transactionTime,
    required this.transactionStatus,
    required this.fraudStatus,
    required this.actions,
    required this.qrString,
    required this.acquirer,
    required this.expiryTime,
  });

  factory MidtransResponse.fromJson(Map<String, dynamic> json) {
    return MidtransResponse(
      statusCode: json['status_code'],
      statusMessage: json['status_message'],
      transactionId: json['transaction_id'],
      orderId: json['order_id'],
      merchantId: json['merchant_id'],
      grossAmount: double.parse(json['gross_amount'].toString()),
      currency: json['currency'],
      paymentType: json['payment_type'],
      transactionTime: DateTime.parse(json['transaction_time']),
      transactionStatus: json['transaction_status'],
      fraudStatus: json['fraud_status'],
      actions: List<Action>.from(json['actions'].map((x) => Action.fromJson(x))),
      qrString: json['qr_string'],
      acquirer: json['acquirer'],
      expiryTime: DateTime.parse(json['expiry_time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'status_message': statusMessage,
      'transaction_id': transactionId,
      'order_id': orderId,
      'merchant_id': merchantId,
      'gross_amount': grossAmount,
      'currency': currency,
      'payment_type': paymentType,
      'transaction_time': transactionTime.toIso8601String(),
      'transaction_status': transactionStatus,
      'fraud_status': fraudStatus,
      'actions': List<dynamic>.from(actions.map((x) => x.toJson())),
      'qr_string': qrString,
      'acquirer': acquirer,
      'expiry_time': expiryTime.toIso8601String(),
    };
  }
}

class Action {
  final String name;
  final String method;
  final String url;

  Action({
    required this.name,
    required this.method,
    required this.url,
  });

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
      name: json['name'],
      method: json['method'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'method': method,
      'url': url,
    };
  }
}

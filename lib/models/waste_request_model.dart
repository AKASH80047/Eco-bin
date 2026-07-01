class WasteRequestModel {
  final String requestId;
  final String userId;
  final String imageUrl;
  final String wasteType;
  final double quantity;
  final int amount;
  final double latitude;
  final double longitude;
  final String status;
  final String paymentStatus;
  final String workerId;
  final DateTime createdAt;

  WasteRequestModel({
    required this.requestId,
    required this.userId,
    required this.imageUrl,
    required this.wasteType,
    required this.quantity,
    required this.amount,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.paymentStatus,
    required this.workerId,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'requestId': requestId,
    'userId': userId,
    'imageUrl': imageUrl,
    'wasteType': wasteType,
    'quantity': quantity,
    'amount': amount,
    'latitude': latitude,
    'longitude': longitude,
    'status': status,
    'paymentStatus': paymentStatus,
    'workerId': workerId,
    'createdAt': createdAt.toIso8601String(),
  };

  factory WasteRequestModel.fromJson(Map<String, dynamic> json) {
    return WasteRequestModel(
      requestId: json['requestId'] ?? '',
      userId: json['userId'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      wasteType: json['wasteType'] ?? 'Plastic',
      quantity: (json['quantity'] ?? 0).toDouble(),
      amount: json['amount'] ?? 0,
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      status: json['status'] ?? 'Pending',
      paymentStatus: json['paymentStatus'] ?? 'Pending',
      workerId: json['workerId'] ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}

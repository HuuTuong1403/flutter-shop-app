import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String orderId;
  final String userId;
  final String productId;
  final String title;
  final double price;
  final String imageUrl;
  final int quantity;
  final Timestamp orderDate;

  Order(
      {required this.orderId,
      required this.userId,
      required this.productId,
      required this.title,
      required this.price,
      required this.imageUrl,
      required this.quantity,
      required this.orderDate});

  Order copyWith(
      {String? orderId,
      String? userId,
      String? productId,
      String? title,
      double? price,
      String? imageUrl,
      int? quantity,
      Timestamp? orderDate}) {
    return Order(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'productId': productId,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'orderDate': orderDate,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'],
      userId: map['userId'],
      productId: map['productId'],
      title: map['title'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      quantity: map['quantity'],
      orderDate: map['orderDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(orderId: $orderId, userId: $userId, productId: $productId, title: $title, price: $price, imageUrl: $imageUrl, quantity: $quantity, orderDate: $orderDate';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Order &&
        other.orderId == orderId &&
        other.userId == userId &&
        other.productId == productId &&
        other.title == title &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.quantity == quantity &&
        other.orderDate == orderDate;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        userId.hashCode ^
        productId.hashCode ^
        title.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        quantity.hashCode ^
        orderDate.hashCode;
  }
}

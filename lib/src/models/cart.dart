import 'dart:convert';

class Cart {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  Cart(
      {required this.id,
      required this.productId,
      required this.title,
      required this.quantity,
      required this.price,
      required this.imageUrl});

  Cart copyWith({
    String? id,
    String? productId,
    String? title,
    int? quantity,
    double? price,
    String? imageUrl,
  }) {
    return Cart(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],
      productId: map['productId'],
      title: map['title'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      quantity: map['quantity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, productId: $productId, title: $title, price: $price, imageUrl: $imageUrl, quantity: $quantity';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Cart &&
        other.id == id &&
        other.productId == productId &&
        other.title == title &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        title.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        quantity.hashCode;
  }
}

import 'dart:convert';

class Product {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  final String? productCategoryName;
  final String? brand;
  final int? quantity;
  final bool? isFavorite;
  final bool? isPopular;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.productCategoryName,
      this.brand,
      this.quantity,
      this.isFavorite,
      this.isPopular});

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    String? productCategoryName,
    String? brand,
    int? quantity,
    bool? isFavorite,
    bool? isPopular,
  }) {
    return Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        productCategoryName: productCategoryName ?? this.productCategoryName,
        brand: brand ?? this.brand,
        quantity: quantity ?? this.quantity,
        isFavorite: isFavorite ?? this.isFavorite,
        isPopular: isPopular ?? this.isPopular);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'productCategoryName': productCategoryName,
      'brand': brand,
      'quantity': quantity,
      'isFavorite': isFavorite,
      'isPopular': isPopular
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      productCategoryName: map['productCategoryName'],
      brand: map['brand'],
      quantity: map['quantity'],
      isFavorite: map['isFavorite'],
      isPopular: map['isPopular'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, price: $price, imageUrl: $imageUrl, productCategoryName: $productCategoryName, brand: $brand, quantity: $quantity, isFavorite: $isFavorite, isPopular: $isPopular';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.productCategoryName == productCategoryName &&
        other.brand == brand &&
        other.quantity == quantity &&
        other.isFavorite == isFavorite &&
        other.isPopular == isPopular;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        productCategoryName.hashCode ^
        brand.hashCode ^
        quantity.hashCode ^
        isFavorite.hashCode ^
        isPopular.hashCode;
  }
}

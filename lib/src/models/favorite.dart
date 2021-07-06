import 'dart:convert';

class Favorite {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  Favorite(
      {required this.id,
      required this.title,
      required this.price,
      required this.imageUrl});

  Favorite copyWith({
    String? id,
    String? title,
    double? price,
    String? imageUrl,
  }) {
    return Favorite(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorite.fromJson(String source) =>
      Favorite.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, title: $title, price: $price, imageUrl: $imageUrl';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Favorite &&
        other.id == id &&
        other.title == title &&
        other.price == price &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ price.hashCode ^ imageUrl.hashCode;
  }
}

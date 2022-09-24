import 'dart:ffi';

class Product {
  String title, description, brand, category, thumbnail;
  List<dynamic> images;
  int id;
  num rating, price;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.rating,
      required this.brand,
      required this.category,
      required this.thumbnail,
      required this.images});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      rating: json['rating'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: json['images'],
    );
  }
}

// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

class Category {
  Category({
    this.idCategory,
    this.categoryName,
    this.categoryImage,
    this.categoryNameEn,
  });

  final int idCategory;
  final String categoryName;
  final String categoryImage;
  final String categoryNameEn;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        idCategory: json["idCategory"],
        categoryName: json["categoryName"],
        categoryImage: json["categoryImage"],
        categoryNameEn: json["categoryNameEn"],
      );

  Map<String, dynamic> toMap() => {
        "idCategory": idCategory,
        "categoryName": categoryName,
        "categoryImage": categoryImage,
        "categoryNameEn": categoryNameEn,
      };
}

// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  Product({
    this.idItem,
    this.itemName,
    this.itemDescription,
    this.itemDate,
    this.itemQuality,
    this.itemQuantity,
    this.itemLike,
    this.subName,
    this.categoryName,
    this.categoryNameEn,
    this.images,
  });

  final int idItem;
  final String itemName;
  final String itemDescription;
  final String itemDate;
  final int itemQuality;
  final double itemQuantity;
  final int itemLike;
  final String subName;
  final String categoryName;
  final String categoryNameEn;
  final List<ProductImage> images;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        idItem: json["idItem"],
        itemName: json["itemName"],
        itemDescription: json["itemDescription"],
        itemDate: json["itemDate"],
        itemQuality: json["itemQuality"],
        itemQuantity: json["itemQuantity"].toDouble(),
        itemLike: json["itemLike"],
        subName: json["subName"],
        categoryName: json["categoryName"],
        categoryNameEn: json["categoryNameEn"],
        images: List<ProductImage>.from(
            json["images"].map((x) => ProductImage.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "idItem": idItem,
        "itemName": itemName,
        "itemDescription": itemDescription,
        "itemDate": itemDate,
        "itemQuality": itemQuality,
        "itemQuantity": itemQuantity,
        "itemLike": itemLike,
        "subName": subName,
        "categoryName": categoryName,
        "categoryNameEn": categoryNameEn,
        "images": List<dynamic>.from(images.map((x) => x.toMap())),
      };
}

class ProductImage {
  ProductImage({
    this.idProductImage,
    this.imagePath,
    this.itemId,
  });

  final int idProductImage;
  final String imagePath;
  final int itemId;

  factory ProductImage.fromJson(String str) =>
      ProductImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductImage.fromMap(Map<String, dynamic> json) => ProductImage(
        idProductImage: json["idProductImage"],
        imagePath: json["imagePath"],
        itemId: json["itemId"],
      );

  Map<String, dynamic> toMap() => {
        "idProductImage": idProductImage,
        "imagePath": imagePath,
        "itemId": itemId,
      };
}

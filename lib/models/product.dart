import 'dart:convert';

import 'image.dart';

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

class SubCategoryProduct {
  SubCategoryProduct({
    this.idItem,
    this.itemName,
    this.itemDescription,
    this.itemDate,
    this.itemQuality,
    this.itemQuantity,
    this.itemLike,
    this.itemNameEn,
    this.itemDescriptionEn,
    this.subName,
    this.categoryName,
    this.subNameEn,
    this.categoryNameEn,
    this.foundFavorite,
    this.images,
  });

  final int idItem;
  final String itemName;
  final String itemDescription;
  final String itemDate;
  final int itemQuality;
  final double itemQuantity;
  final int itemLike;
  final String itemNameEn;
  final String itemDescriptionEn;
  final String subName;
  final String categoryName;
  final String subNameEn;
  final String categoryNameEn;
  final bool foundFavorite;
  final List<ProductImage> images;

  factory SubCategoryProduct.fromJson(String str) =>
      SubCategoryProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubCategoryProduct.fromMap(Map<String, dynamic> json) =>
      SubCategoryProduct(
        idItem: json["idItem"],
        itemName: json["itemName"],
        itemDescription: json["itemDescription"],
        itemDate: json["itemDate"],
        itemQuality: json["itemQuality"],
        itemQuantity: json["itemQuantity"].toDouble(),
        itemLike: json["itemLike"],
        itemNameEn: json["itemNameEn"],
        itemDescriptionEn: json["itemDescriptionEn"],
        subName: json["subName"],
        categoryName: json["categoryName"],
        subNameEn: json["subNameEn"],
        categoryNameEn: json["categoryNameEn"],
        foundFavorite: json["foundFavorite"],
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
        "itemNameEn": itemNameEn,
        "itemDescriptionEn": itemDescriptionEn,
        "subName": subName,
        "categoryName": categoryName,
        "subNameEn": subNameEn,
        "categoryNameEn": categoryNameEn,
        "foundFavorite": foundFavorite,
        "images": List<dynamic>.from(images.map((x) => x.toMap())),
      };
}

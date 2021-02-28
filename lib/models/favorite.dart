import 'dart:convert';

import 'package:jewelry_flutter/models/image.dart';

class Favorite {
  Favorite({
    this.itemId,
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
    this.idSub,
    this.macAddress,
    this.idFavorites,
    this.images,
    this.isFavorite,
    this.likes,
  });

  final int itemId;
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
  final int idSub;
  final String macAddress;
  final int idFavorites;
  final List<ProductImage> images;
  bool isFavorite;
  int likes;

  factory Favorite.fromJson(String str) => Favorite.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
        itemId: json["itemId"],
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
        idSub: json["idSub"],
        macAddress: json["macAddress"],
        idFavorites: json["idFavorites"],
        likes: json["likes"],
        isFavorite: json["isFavorite"],
        images: List<ProductImage>.from(
            json["images"].map((x) => ProductImage.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "itemId": itemId,
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
        "idSub": idSub,
        "macAddress": macAddress,
        "idFavorites": idFavorites,
        "likes": likes,
        "isFavorite": isFavorite,
        "images": List<dynamic>.from(images.map((x) => x.toMap())),
      };
}

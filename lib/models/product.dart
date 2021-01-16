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
    this.images,
  });

  final int idItem;
  final String itemName;
  final String itemDescription;
  final String itemDate;
  final int itemQuality;
  final double itemQuantity;
  final int itemLike;
  final List<Image> images;

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
        images: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "idItem": idItem,
        "itemName": itemName,
        "itemDescription": itemDescription,
        "itemDate": itemDate,
        "itemQuality": itemQuality,
        "itemQuantity": itemQuantity,
        "itemLike": itemLike,
        "images": List<dynamic>.from(images.map((x) => x.toMap())),
      };
}

class Image {
  Image({
    this.idImage,
    this.imagePath,
    this.itemId,
  });

  final int idImage;
  final String imagePath;
  final int itemId;

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        idImage: json["idImage"],
        imagePath: json["imagePath"],
        itemId: json["itemId"],
      );

  Map<String, dynamic> toMap() => {
        "idImage": idImage,
        "imagePath": imagePath,
        "itemId": itemId,
      };
}

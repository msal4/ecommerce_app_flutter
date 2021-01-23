import 'dart:convert';

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

import 'dart:convert';

class SubCategory {
  SubCategory({
    this.idSub,
    this.categoryId,
    this.subName,
    this.subImage,
    this.subNameEn,
  });

  final int idSub;
  final int categoryId;
  final String subName;
  final String subImage;
  final String subNameEn;

  factory SubCategory.fromJson(String str) =>
      SubCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
        idSub: json["idSub"],
        categoryId: json["categoryId"],
        subName: json["subName"],
        subImage: json["subImage"],
        subNameEn: json["subNameEn"],
      );

  Map<String, dynamic> toMap() => {
        "idSub": idSub,
        "categoryId": categoryId,
        "subName": subName,
        "subImage": subImage,
        "subNameEn": subNameEn,
      };
}

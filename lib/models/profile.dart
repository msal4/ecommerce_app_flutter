// To parse this JSON data, do
//
//     final profile = profileFromMap(jsonString);

import 'dart:convert';

class Profile {
  Profile({
    this.idProfile,
    this.profileName,
    this.aboutUs,
    this.phoneNumber,
    this.email,
    this.whats,
    this.snapchat,
    this.instagram,
    this.facebook,
    this.dollarPrice,
    this.profileNameEn,
    this.aboutUsEn,
  });

  final int idProfile;
  final String profileName;
  final String aboutUs;
  final String phoneNumber;
  final String email;
  final String whats;
  final String snapchat;
  final String instagram;
  final String facebook;
  final double dollarPrice;
  final String profileNameEn;
  final String aboutUsEn;

  factory Profile.fromJson(String str) => Profile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        idProfile: json["idProfile"],
        profileName: json["profileName"],
        aboutUs: json["aboutUs"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        whats: json["whats"],
        snapchat: json["snapchat"],
        instagram: json["instagram"],
        facebook: json["facebook"],
        dollarPrice: json["dollarPrice"].toDouble(),
        profileNameEn: json["profileNameEn"],
        aboutUsEn: json["aboutUsEn"],
      );

  Map<String, dynamic> toMap() => {
        "idProfile": idProfile,
        "profileName": profileName,
        "aboutUs": aboutUs,
        "phoneNumber": phoneNumber,
        "email": email,
        "whats": whats,
        "snapchat": snapchat,
        "instagram": instagram,
        "facebook": facebook,
        "dollarPrice": dollarPrice,
        "profileNameEn": profileNameEn,
        "aboutUsEn": aboutUsEn,
      };
}

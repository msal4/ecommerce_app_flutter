import 'dart:convert';

class Location {
  Location({
    this.idLocation,
    this.lang,
    this.lat,
    this.storeImage,
    this.note,
    this.noteEn,
  });

  final int idLocation;
  final double lang;
  final double lat;
  final String storeImage;
  final String note;
  final String noteEn;

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        idLocation: json["idLocation"],
        lang: double.parse(json["lang"]),
        lat: double.parse(json["lat"]),
        storeImage: json["storeImage"],
        note: json["note"],
        noteEn: json["noteEn"],
      );

  Map<String, dynamic> toMap() => {
        "idLocation": idLocation,
        "lang": lang,
        "lat": lat,
        "storeImage": storeImage,
        "note": note,
        "noteEn": noteEn,
      };
}

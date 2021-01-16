import 'dart:convert';

class Slide {
  Slide({
    this.idSlider,
    this.sliderImage,
  });

  final int idSlider;
  final String sliderImage;

  factory Slide.fromJson(String str) => Slide.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Slide.fromMap(Map<String, dynamic> json) => Slide(
        idSlider: json["idSlider"],
        sliderImage: json["sliderImage"],
      );

  Map<String, dynamic> toMap() => {
        "idSlider": idSlider,
        "sliderImage": sliderImage,
      };
}

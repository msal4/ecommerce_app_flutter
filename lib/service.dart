import 'package:dio/dio.dart';
import 'package:jewelry_flutter/models/slider.dart';

import 'models/product.dart';

class Service {
  static final dio =
      Dio(BaseOptions(baseUrl: 'http://dashboard.hayderalkhafaje.com/api'));

  Future<List<Product>> getProducts() async {
    final res = await dio.get('/items');
    return List<Product>.from(res.data.map((item) => Product.fromMap(item)));
  }

  Future<List<Slide>> getSliders() async {
    final res = await dio.get('/sliders');
    return List<Slide>.from(res.data.map((item) => Slide.fromMap(item)));
  }
}

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import 'models/Location.dart';
import 'models/category.dart';
import 'models/favorite.dart';
import 'models/product.dart';
import 'models/profile.dart';
import 'models/slider.dart';
import 'models/sub_category.dart';

class DeviceDetails {
  DeviceDetails({this.deviceName, this.deviceVersion, this.identifier});

  String deviceName;
  String deviceVersion;
  String identifier;
}

class Service {
  static final dio =
      Dio(BaseOptions(baseUrl: 'http://dashboard.hayderalkhafaje.com/api'));

  static final deviceInfoPlugin = DeviceInfoPlugin();
  static DeviceDetails _deviceDetails;

  static Future<DeviceDetails> getDeviceDetails() async {
    if (_deviceDetails != null && _deviceDetails.identifier != null) {
      return _deviceDetails;
    }

    _deviceDetails = DeviceDetails();

    try {
      if (Platform.isAndroid) {
        final build = await deviceInfoPlugin.androidInfo;
        _deviceDetails.deviceName = build.model;
        _deviceDetails.deviceVersion = build.version.toString();
        _deviceDetails.identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        final data = await deviceInfoPlugin.iosInfo;
        _deviceDetails.deviceName = data.name;
        _deviceDetails.deviceVersion = data.systemVersion;
        _deviceDetails.identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    return _deviceDetails;
  }

  Future<List<Product>> getProducts({String show = 'all'}) async {
    final res = await dio.get('/items', queryParameters: {'show': show});
    return List<Product>.from(res.data.map((item) => Product.fromMap(item)));
  }

  Future<List<Slide>> getSliders() async {
    final res = await dio.get('/sliders');
    return List<Slide>.from(res.data.map((item) => Slide.fromMap(item)));
  }

  Future<List<Category>> getCategories() async {
    final res = await dio.get('/categories');
    return List<Category>.from(res.data.map((item) => Category.fromMap(item)));
  }

  Future<List<SubCategory>> getSubCategories(int id) async {
    final res = await dio.get('/subCategoryId/$id');
    return List<SubCategory>.from(
      res.data.map((item) => SubCategory.fromMap(item)),
    );
  }

  Future<Profile> getProfile() async {
    final res = await dio.get('/profile/1');
    return Profile.fromMap(res.data);
  }

  Future<List<Favorite>> getFavorites() async {
    final details = await getDeviceDetails();
    final res = await dio.get('/favoriteMac/${details.identifier}');
    return List<Favorite>.from(
        res.data.map(((item) => Favorite.fromMap(item))));
  }

  Future<void> addFavorite(
      {@required int itemId, @required int itemLikes}) async {
    final details = await getDeviceDetails();
    await dio.post('/addFavorites/', data: {
      "macAddress": details.identifier,
      "itemId": itemId,
      "itemLike": itemLikes
    });
  }

  Future<List<Location>> getLocations() async {
    final res = await dio.get('/locations');
    return List<Location>.from(res.data.map((item) => Location.fromMap(item)));
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:project/models/LOGIN_model.dart';
import 'package:project/network/remote/end_points.dart';
import 'package:project/network/remote/local/cachehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_info.dart';

var token = StorageUtil.getString('token');

class diohelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'http://nahe.dhulfiqar.com/',
        contentType: 'application/json',
        responseType: ResponseType.plain,
        headers: {
          'Authorization': 'Bearer ${token}',
        },
        receiveDataWhenStatusError: true));
  }

  static Future<Response?> getData(
      {required String Url,
      required Map<String, dynamic> query,
      required Token}) async {
    print(Token);
    return await dio?.get(Url, queryParameters: query);
  }

  static Future<Response?> postData(
      {required String Url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      Token}) async {
    return await dio?.post(Url, queryParameters: query, data: data);
  }
}

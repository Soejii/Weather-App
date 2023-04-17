import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class ConfigApi {
  static Dio dio = Dio();
  static Response? response;

  static Future<Response?> apiGetPublic({
    required String url,
    Map<String, dynamic>? data, // Optional
  }) async {
    try {
      response = await dio.get(
        url,
        queryParameters: data,
      );
    } on DioError catch (e) {
      print(e.response?.data);
      response = e.response;
    }
    return response;
  }
}

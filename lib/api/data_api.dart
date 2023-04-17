import 'package:dio/dio.dart';
import 'package:weathe_app/api/config_api.dart';
import 'package:weathe_app/model/CuacaModel.dart';
import 'package:weathe_app/model/DaerahModel.dart';

class ApiData {
  static Dio dio = Dio();
  static Response? response;

  static Future<List<DaerahModel>?> GetAllDaerah() async {
    try {
      response = await ConfigApi.apiGetPublic(
        url: "https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json",
      );
      if (response!.statusCode == 200) {
        print('--- Get Daerah ---');
        return (response!.data as List)
            .map((e) => DaerahModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<CuacaModel>?> GetCuacaDaerah(String? id) async {
    try {
      response = await ConfigApi.apiGetPublic(
        url: 'https://ibnux.github.io/BMKG-importer/cuaca/$id.json',
      );
      if (response!.statusCode == 200) {
        print('--- Get Cuaca ---');
        return (response!.data as List)
            .map((e) => CuacaModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future GetCuacaIcon(String? id) async {
    try {
      response = await ConfigApi.apiGetPublic(
        url: 'https://ibnux.github.io/BMKG-importer/icon/$id.png',
      );
      if (response!.statusCode == 200) {
        print('--- Get icon ---');
        return response!.data;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import '../models/pokemon.dart';
import '../models/response_code.dart';
import '../models/validation.dart';
import 'constant_ds.dart';

class ApiClients {
  Map<String, dynamic> datos = Map<String, dynamic>();
  late ResponseCode _response;
  late Response response;

  Dio dio = Dio();
  var apidata;
  bool error = false;
  bool loading = false;
  bool cache = false;
  String errmsg = "";

  get developer => null;

  void setResponse(Map<String, dynamic>? data, String endPoint) {
    datos.clear();
    _response = ResponseCode.fromJson(data![endPoint][Cnstds.KEY_RESPONSCODE]);
    datos.addAll({'response': _response});
    if (_response.code == Cnstds.KEY_GST00001) {
      Validation validation = Validation.fromJson(
          data[endPoint][Cnstds.KEY_RESPONSCODE][Cnstds.KEY_VALIDATIONS][0]);
      datos.addAll({'validation': validation});
    }
  }

  Future<Map<String, dynamic>> getAppHomePokemonList(
      int skip, int limit) async {
    const _endPoint = 'results';
    String _url = Cnstds.API_URL + "?limit=$limit&offset=$skip";
    if (cache)
      dio.interceptors.add(
          DioCacheManager(CacheConfig(baseUrl: Cnstds.API_URL)).interceptor);
    try {
      Response response;
      if (cache) {
        response = await dio.get(_url,
            options: buildCacheOptions(
              Duration(days: 7),
              forceRefresh: true,
              maxStale: Duration(days: 1),
            ));
      } else {
        response = await dio.get(
          _url,
        );
      }
      apidata = response.data;
      if (response.statusCode == 200) {
        if (response.data![_endPoint] != null) {
          List<PokemonListModel> itemsList = (response.data![_endPoint] as List)
              .map((i) => PokemonListModel.fromJson(i))
              .toList();
          datos.addAll({Cnstds.dataPokemonList: itemsList});
        }
      } else {
        error = true;
        errmsg = "Error while fetching data.";
        datos.clear();
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> getAppHomePokemonDetailList(String url) async {
    String _url = url;
    if (cache)
      dio.interceptors.add(
          DioCacheManager(CacheConfig(baseUrl: Cnstds.API_URL)).interceptor);
    try {
      Response response;
      if (cache) {
        response = await dio.get(_url,
            options: buildCacheOptions(
              Duration(days: 7),
              forceRefresh: true,
              maxStale: Duration(days: 1),
            ));
      } else {
        response = await dio.get(
          _url,
        );
      }
      apidata = response.data;
      if (response.statusCode == 200) {
        if (response.data! != null) {
          PokemonModelDetail itemsList =
              PokemonModelDetail.fromJson(response.data!);
          datos.addAll({Cnstds.dataPokemonDetailList: itemsList});
        }
      } else {
        error = true;
        errmsg = "Error while fetching data.";
        datos.clear();
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }
}

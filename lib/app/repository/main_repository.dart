import '../data_source/api_clients.dart';
import '../data_source/rest_data_source.dart';

class MainRepository {
  final ApiClients _api;
  final RestDataSource _apiRest;

  MainRepository(this._api, this._apiRest);

  late Map<String, dynamic> result;
  late Map<String, dynamic> datos;

  Future<Map<String, dynamic>> getAppHomePokemonList(
      int skip, int limit) async {
    return _api.getAppHomePokemonList(skip, limit);
  }

  Future<Map<String, dynamic>> getAppHomePokemonDetailList(String url) async {
    return _api.getAppHomePokemonDetailList(url);
  }
}

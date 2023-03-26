import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:pokemon_heb/app/config/utils.dart';
import 'package:pokemon_heb/app/models/diary/client_detail_sup.dart';
import 'package:pokemon_heb/app/models/anaquelero/home_info.dart';
import 'package:pokemon_heb/app/models/diary/route_sup.dart';
import 'package:pokemon_heb/app/models/profile.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as Gq;
import '../models/anaquelero/client.dart';
import '../models/diary/client_detail_other_route.dart';
import '../models/anaquelero/event.dart';
import '../models/anaquelero/event_client.dart';
import '../models/pokemon.dart';
import '../models/response_code.dart';
import '../models/stores/anaqueleros_to_manage_client.dart';
import '../models/stores/cat_routes_by_supervisor.dart';
import '../models/stores/clients_states_today_by_supervisor.dart';
import '../models/teams/team_list_by_supervisor.dart';
import '../models/validation.dart';
import '../models/stores/clients_list_by_route_supervisor.dart';
import 'api_endpoints.dart';
import 'constant_ds.dart';
import 'api_config.dart';

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

  Future<Map<String, dynamic>> appLogin(
      String employeeId, password, deviceId) async {
    const _endPoint = 'auth_login';
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client =
          graphQLConfiguration.getGraphQLClient(apiUrl: Cnstds.KEY_AUTH_URL);
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document:
              Gq.gql(ApiEndpoints.qmLogin(employeeId, password, deviceId)),
        ),
      );

      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          var data = result.data![_endPoint]['data']['token'];
          datos.addAll({'token': data});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appGetHomeInfo() async {
    const _endPoint = 'app_get_home_info';
    String token = Utils.prefs.token;
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document: Gq.gql(ApiEndpoints.qmHomeInfo()),
        ),
      );

      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          List<HomeInfo> listHomeInfo = [];
          List<Object?> items = result.data![_endPoint][Cnstds.KEY_DATA];
          for (var i = 0; i < items.length; i++) {
            HomeInfo data = HomeInfo.fromJson(
                json: result.data![_endPoint][Cnstds.KEY_DATA][i]);
            listHomeInfo.add(data);
          }
          datos.addAll({Cnstds.dataHomeInfo: listHomeInfo});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appGetClientById(String idClientRoute) async {
    const _endPoint = 'app_get_schedule_client_route_by_id';
    const _endPointEvents = 'events';
    String token = Utils.prefs.token;
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document: Gq.gql(ApiEndpoints.qmClientById(idClientRoute)),
        ),
      );

      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          Client client =
              Client.fromJson(result.data![_endPoint][Cnstds.KEY_DATA]);
          datos.addAll({Cnstds.dataClient: client});
          if (result.data![_endPoint][Cnstds.KEY_DATA][_endPointEvents] !=
              null) {
            List<EventClient> listEvent = [];
            List<Object?> items =
                result.data![_endPoint][Cnstds.KEY_DATA][_endPointEvents];
            for (var i = 0; i < items.length; i++) {
              EventClient event = EventClient.fromJson(
                  result.data![_endPoint][Cnstds.KEY_DATA][_endPointEvents][i]);
              listEvent.add(event);
            }
            if (listEvent.length > 0) {
              datos.addAll({Cnstds.dataEventClient: listEvent});
            }
          }
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appCheckin(String idClientRoute, lat, long,
      deviceDate, deviceGTM, isOnline, b64Photo) async {
    const _endPoint = 'app_checking';
    String token = Utils.prefs.token;
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      Gq.QueryResult result = await _client.mutate(
        Gq.MutationOptions(
          document: Gq.gql(ApiEndpoints.qmAppCheckin(idClientRoute, lat, long,
              deviceDate, deviceGTM, isOnline, b64Photo)), // this
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appCheckout(String idClientRoute, lat, long,
      comment, deviceDate, deviceGTM, isOnline, b64Photo) async {
    const _endPoint = 'app_checkout';
    String token = Utils.prefs.token;
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      Gq.QueryResult result = await _client.mutate(
        Gq.MutationOptions(
          document: Gq.gql(ApiEndpoints.qmAppCheckout(idClientRoute, lat, long,
              comment, deviceDate, deviceGTM, isOnline, b64Photo)), // this
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appManageClientOutFrequencyBySupervisor(
      String idClient, idCellar, idAnaquelero, startTime, endTime) async {
    const _endPoint = 'app_manage_client_out_frequency_by_supervisor';
    String token = Utils.prefs.token;
    try {
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      String query = ApiEndpoints.appManageClientOutFrequencyBySupervisor(
          idClient, idCellar, idAnaquelero, startTime, endTime);
      log(query);
      Gq.QueryResult result = await _client.mutate(
        Gq.MutationOptions(
          document: Gq.gql(query), // this
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appGetEventList() async {
    const _endPoint = 'get_cat_events_list';
    String token = Utils.prefs.token;
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document: Gq.gql(ApiEndpoints.qmEventList()),
        ),
      );

      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          List<Event> listEvent = [];
          List<Object?> items = result.data![_endPoint][Cnstds.KEY_DATA];
          for (var i = 0; i < items.length; i++) {
            Event data =
                Event.fromJson(result.data![_endPoint][Cnstds.KEY_DATA][i]);
            listEvent.add(data);
          }
          datos.addAll({Cnstds.dataEvent: listEvent});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appStartEvent(String idClientRoute,
      idCatalogEvent, lat, long, deviceDate, deviceGTM) async {
    const _endPoint = 'app_start_event';
    String token = Utils.prefs.token;
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      Gq.QueryResult result = await _client.mutate(
        Gq.MutationOptions(
          document: Gq.gql(ApiEndpoints.qmAppStartEvent(idClientRoute,
              idCatalogEvent, lat, long, deviceDate, deviceGTM)), // this
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          var data =
              result.data![_endPoint][Cnstds.KEY_DATA]['id_registered_event'];
          datos.addAll({'id_registered_event': data});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appEndEvent(
      String idRegisteredEvent, deviceDate, deviceGTM) async {
    const _endPoint = 'app_end_event';
    String token = Utils.prefs.token;
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      Gq.QueryResult result = await _client.mutate(
        Gq.MutationOptions(
          document: Gq.gql(ApiEndpoints.qmAppEndEvent(
              idRegisteredEvent, deviceDate, deviceGTM)), // this
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appLogout() async {
    const _endPoint = 'auth_logout';
    String token = Utils.prefs.token;
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_AUTH_URL, accessToken: token);
      Gq.QueryResult result = await _client.mutate(
        Gq.MutationOptions(
          document: Gq.gql(ApiEndpoints.qmLogout()), // this
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appClosingDayBySupervisor() async {
    const _endPoint = 'app_closing_day_by_supervisor';
    String token = Utils.prefs.token;
    try {
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      String query = ApiEndpoints.appClosingDayBySupervisor();
      Gq.QueryResult result = await _client.mutate(
        Gq.MutationOptions(
          document: Gq.gql(query), // this
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> getAppHomeListCurrentScheduleClientsBySupervisor(
      int skip, int limit) async {
    const _endPoint =
        'get_app_home_list_current_schedule_clients_by_supervisor';
    String token = Utils.prefs.token;
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      String query =
          ApiEndpoints.qmGetAppHomeListCurrentScheduleClientsBySupervisor(
              skip, limit);
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(document: Gq.gql(query)),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        var _todayShow = result.data![_endPoint]['today_show'].toString();
        datos.addAll({Cnstds.todayShow: _todayShow});
        if (result.data![_endPoint]['total_records'] != null) {
          var dataRouteSupTotal = result.data![_endPoint]['total_records'];
          datos.addAll({Cnstds.dataRouteSupTotal: dataRouteSupTotal});
        }
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          List<RouteSup> itemsList =
              (result.data![_endPoint][Cnstds.KEY_DATA] as List)
                  .map((i) => RouteSup.fromJson(i))
                  .toList();
          datos.addAll({Cnstds.dataRouteSup: itemsList});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
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
    const _endPoint = 'types';
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
          PokemonModelDetail itemsList = PokemonModelDetail.fromJson(
              response.data!);
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

  Future<Map<String, dynamic>> getAppCatRouteBySupervisor() async {
    const _endPoint = 'get_app_cat_routes_by_supervisor';
    String token = Utils.prefs.token;
    try {
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document: Gq.gql(ApiEndpoints.getAppCatRouteBySupervisor()),
        ),
      );

      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          List<CatRoutesBySupervisor> itemsList =
              (result.data![_endPoint][Cnstds.KEY_DATA] as List)
                  .map((i) => CatRoutesBySupervisor.fromJson(i))
                  .toList();
          datos.addAll({Cnstds.dataAppCatRouteBySupervisor: itemsList});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> getAppAllClientsListByRouteSupervisor(
      String idRoute) async {
    const _endPoint = 'get_app_all_clients_list_by_route_supervisor';
    String token = Utils.prefs.token;
    try {
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      String query =
          ApiEndpoints.getAppAllClientsListByRouteSupervisor(idRoute);
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document: Gq.gql(query),
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          List<ClientsListByRouteSupervisor> itemsList =
              (result.data![_endPoint][Cnstds.KEY_DATA] as List)
                  .map((i) => ClientsListByRouteSupervisor.fromJson(i))
                  .toList();
          datos.addAll({Cnstds.dataClientsListByRouteSupervisor: itemsList});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> getAppAllClientsListByRouteSupervisorToday(
      String idRoute) async {
    const _endPoint = 'get_app_all_clients_list_by_route_supervisor_today';
    String token = Utils.prefs.token;
    try {
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      String query =
          ApiEndpoints.getAppAllClientsListByRouteSupervisorToday(idRoute);
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document: Gq.gql(query),
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          List<ClientsListByRouteSupervisor> itemsList =
              (result.data![_endPoint][Cnstds.KEY_DATA] as List)
                  .map((i) => ClientsListByRouteSupervisor.fromJson(i))
                  .toList();
          datos.addAll(
              {Cnstds.dataClientsListByRouteSupervisorToday: itemsList});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> getAppCatRoutesBySupervisor(bool isToday) async {
    const _endPoint = 'get_app_cat_routes_by_supervisor';
    String token = Utils.prefs.token;
    try {
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      String query = ApiEndpoints.getAppCatRoutesBySupervisor(isToday);
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document: Gq.gql(query),
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          List<CatRoutesBySupervisor> itemsList =
              (result.data![_endPoint][Cnstds.KEY_DATA] as List)
                  .map((i) => CatRoutesBySupervisor.fromJson(i))
                  .toList();
          datos.addAll({Cnstds.dataCatRoutesBySupervisor: itemsList});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appGetTeamListBySupervisor(bool isToday) async {
    const _endPoint = 'app_get_team_list_by_supervisor';
    String token = Utils.prefs.token;
    try {
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      String query = ApiEndpoints.appGetTeamListBySupervisor(isToday);
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document: Gq.gql(query),
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);

        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          TeamListBySupervisor itemsList = TeamListBySupervisor.fromJson(
              result.data![_endPoint][Cnstds.KEY_DATA]);
          datos.addAll({Cnstds.dataTeamListBySupervisor: itemsList});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> getAppClientDetailsBySupervisor(
      String idRoute, idClient, idCellar, idClientRoute) async {
    const _endPoint = 'get_app_client_details_by_supervisor';
    String token = Utils.prefs.token;
    if (idClientRoute == '') idClientRoute = '0';
    if (idClientRoute == null) idClientRoute = '0';
    try {
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      String query = ApiEndpoints.qmClientDetailsBySupervisor(
          idRoute, idClient, idCellar, idClientRoute);
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document: Gq.gql(query),
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          ClientDetailSup item = ClientDetailSup.clientDetailSupfromJson(
              json: result.data![_endPoint][Cnstds.KEY_DATA]);
          datos.addAll({Cnstds.dataClientDetailSup: item});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> getAppClientDetailsOtherRoutesBySupervisor(
      String idRoute, idClient, idCellar) async {
    const _endPoint = 'get_app_client_details_other_routes_by_supervisor';
    String token = Utils.prefs.token;
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document: Gq.gql(ApiEndpoints.qmClientDetailsOtherRoutesBySupervisor(
              idRoute, idClient, idCellar)),
        ),
      );

      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          List<ClientDetailOtherRoute> itemsList =
              (result.data![_endPoint][Cnstds.KEY_DATA] as List)
                  .map((i) => ClientDetailOtherRoute.fromJson(i))
                  .toList();
          datos.addAll({Cnstds.dataClientDetailOtherRoute: itemsList});
        }
      }
      return datos;
    } catch (e) {
      print(e);
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> getAppAnaquelerosToManageClient(
      String id_client_route) async {
    const _endPoint = 'app_get_anaqueleros_to_manage_client';
    String token = Utils.prefs.token;
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document: Gq.gql(
              ApiEndpoints.qmGetAnaquelerosToManageClient(id_client_route)),
        ),
      );

      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          List<AnaquelerosToManage> itemsList =
              (result.data![_endPoint][Cnstds.KEY_DATA] as List)
                  .map((i) => AnaquelerosToManage.fromJson(i))
                  .toList();
          datos.addAll({Cnstds.dataAnaquelerosToManageClient: itemsList});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appMarkAssistanceBySupervisor(
      String idClientRoute,
      idAnaquelero,
      checkinTime,
      checkoutTime,
      deviceGTM) async {
    const _endPoint = 'app_mark_assistance_by_supervisor';
    String token = Utils.prefs.token;
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      Gq.QueryResult result = await _client.mutate(
        Gq.MutationOptions(
          document: Gq.gql(ApiEndpoints.qmMarkAssistanceBySupervisor(
              idClientRoute,
              idAnaquelero,
              checkinTime,
              checkoutTime,
              deviceGTM)),
        ),
      );

      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appReassignReplacementAnaquelero(
      String idClientRoute, idAnaquelero, startTime, endTime) async {
    const _endPoint = 'app_reassign_replacement_anaquelero';
    String token = Utils.prefs.token;
    try {
      // initializing GraphQLConfig
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      Gq.QueryResult result = await _client.mutate(
        Gq.MutationOptions(
          document: Gq.gql(ApiEndpoints.qmReassignReplacementAnaquelero(
              idClientRoute, idAnaquelero, startTime, endTime)),
        ),
      );

      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> getProfileInfoUser() async {
    const _endPoint = 'app_get_profile_info_user';
    String token = Utils.prefs.token;
    try {
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      String query = ApiEndpoints.qmGetProfileInfoUser();
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document: Gq.gql(query),
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          Profile item = Profile.profileFromJson(
              json: result.data![_endPoint][Cnstds.KEY_DATA]);
          datos.addAll({Cnstds.dataProfileUser: item});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>>
      appGetCountClientsStatesTodaySySupervisor() async {
    const _endPoint = 'app_get_count_clients_states_today_by_supervisor';
    String token = Utils.prefs.token;
    try {
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client = graphQLConfiguration.getGraphQLClient(
          apiUrl: Cnstds.KEY_API_URL, accessToken: token);
      String query = ApiEndpoints.appGetCountClientsStatesTodaySySupervisor();
      Gq.QueryResult result = await _client.query(
        Gq.QueryOptions(
          document: Gq.gql(query),
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
        if (result.data![_endPoint][Cnstds.KEY_DATA] != null) {
          CountClientsStates item = CountClientsStates.fromJson(
              json: result.data![_endPoint][Cnstds.KEY_DATA]);
          datos.addAll({Cnstds.dataCountClientsStates: item});
        }
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }

  Future<Map<String, dynamic>> appRegisterUserDummy(
      String name, email, bornDate, password) async {
    const _endPoint = 'app_register_user_dummy';
    try {
      ApiConfig graphQLConfiguration = ApiConfig();
      Gq.GraphQLClient _client =
          graphQLConfiguration.getGraphQLClient(apiUrl: Cnstds.KEY_AUTH_URL);
      String query =
          ApiEndpoints.appRegisterUserDummy(name, email, bornDate, password);
      Gq.QueryResult result = await _client.mutate(
        Gq.MutationOptions(
          document: Gq.gql(query),
        ),
      );
      if (result.hasException) {
        datos.clear();
      } else if (result.data != null) {
        setResponse(result.data, _endPoint);
      }
      return datos;
    } catch (e) {
      datos.clear();
      return datos;
    }
  }
}

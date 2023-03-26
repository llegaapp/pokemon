import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:pokemon_heb/app/models/diary/anaqueleros_to_manage_client_local.dart';
import 'package:pokemon_heb/app/models/diary/client_detail_other_route_local.dart';
import 'package:pokemon_heb/app/models/diary/client_detail_sup_local.dart';
import 'package:pokemon_heb/app/modules/pokemon/stores/stores_anaqueleros_loadData.dart';
import 'package:pokemon_heb/app/modules/pokemon/stores/stores_binding.dart';
import 'package:pokemon_heb/app/modules/pokemon/stores/stores_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokemon_heb/app/models/diary/client_detail_sup.dart';
import 'package:pokemon_heb/app/global_widgets/button2.dart';
import 'package:pokemon_heb/main.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../config/constant.dart';
import '../../config/hexcolor.dart';
import '../../config/responsive_app.dart';
import '../../config/string_app.dart';
import '../../config/utils.dart';
import '../../data_source/constant_ds.dart';
import '../../global_widgets/app/view_address_store.dart';
import '../../models/diary/client_detail_other_route.dart';
import '../../global_widgets/button1.dart';
import '../../global_widgets/data_table/src/data_table_2.dart';
import '../../global_widgets/data_table/src/paginated_data_table_2.dart';
import '../../global_widgets/dropdown2.dart';
import '../../global_widgets/empty_table.dart';
import '../../models/paginator.dart';
import '../../models/pokemon.dart';
import '../../models/response_code.dart';
import '../../models/diary/route_sup.dart';
import '../../models/stores/anaqueleros_to_manage_client.dart';
import '../../models/stores/cat_routes_by_supervisor.dart';
import '../../models/stores/clients_list_by_route_supervisor.dart';
import '../../models/stores/clients_states_today_by_supervisor.dart';
import '../../models/teams/team_list_by_supervisor.dart';
import '../../repository/main_repository.dart';
import 'diary/client_detail_page.dart';
import 'diary/diary_anaqueleros_loadData.dart';
import 'pokemon_binding.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path/path.dart';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import 'teams/teams_anaquelero_page.dart';

class PokemonController extends GetxController {
  bool loading = false;
  Dio dio = Dio();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RefreshController refreshControllerSupervisor =
      RefreshController(initialRefresh: false);
  RefreshController refreshControllerSupervisorItem =
      RefreshController(initialRefresh: false);
  RefreshController refreshControllerSupervisorItemDetail =
      RefreshController(initialRefresh: false);
  RefreshController refreshControllerAgendaDetail =
      RefreshController(initialRefresh: false);
  List<RouteSup> itemsRouteSup = [];
  List<PokemonListModel> itemsPokemon = [];

  late List<CatRoutesBySupervisor> itemsRoutes = [];
  late List<AnaquelerosToManage> itemsAnaqueleros = [];
  late List<ClientsListByRouteSupervisor> itemsStores = [];
  late List<ClientsListByRouteSupervisor> itemsStoresAux = [];
  late List<ClientsListByRouteSupervisor> itemsStoresToday = [];
  late List<ClientsListByRouteSupervisor> itemsStoresAll = [];
  late int totalItemsStores = 0;
  late Team teamCurrent;
  bool _error = false;
  late DiaryClient diaryClientCurrent = DiaryClient();
  String routeStoresSelected = '';
  bool activeSwitch = false;
  String hourCheckinSelect = '';
  String minuteCheckinSelect = '';
  String hourCheckoutSelect = '';
  String minuteCheckoutSelect = '';
  String hourDeSelect = '';
  String hourASelect = '';
  File? fileImage;
  String b64Image = '';
  String dateb64Image = '';
  String timeb64Image = '';
  bool imageUpdate = false;
  bool anaqueleroUpdate = false;
  bool checkinUpdate = false;
  bool checkoutUpdate = false;
  List<AnaquelerosToManage> listAnaqueleros = [];
  String idUniqueSelectedTmp = '0';
  String nameUniqueSelectedTmp = '';
  bool isDetailUpdate = false;
  int indexDiaryClientCurrent = -1;
  int indexRouteSupCurrent = -1;
  int indexTeamCurrentDetails = -1;
  int indexTeamAnaquelero = -1;
  int indexStoreCurrentDetails = -1;

  late List<CatRoutesBySupervisor> itemsRoutesTeamAll = [];
  late List<CatRoutesBySupervisor> itemsRoutesTeamToday = [];

  late TeamListBySupervisor itemsTeams = TeamListBySupervisor();
  late TeamListBySupervisor itemsTeamsAux = TeamListBySupervisor();
  late TeamListBySupervisor itemsTeamsToday = TeamListBySupervisor();
  late TeamListBySupervisor itemsTeamsAll = TeamListBySupervisor();

  late int totalItemsFiltredTeams = 0;
  late int totalItemsTeams = 0;
  bool isTodayTeams = false;
  bool isSearchStore = false;

  String routeTeamsSelected = '';

  List<ClientDetailOtherRoute> itemsClientDetailOtherRoute = [];
  late Map<String, dynamic> result;
  String _code = '';
  String dateCurrentStr = '';
  int indexPage = 1;
  String titleStore = tiendasStr;
  String titleTeams = equiposStr;
  String currentStoreList = '';
  String currentTeamList = '';
  int subIndexPage = 0;
  ClientDetailSup? itemClientDetailSup;
  bool timeToEat = false;
  String idRouteAgendaCurrent = '';
  bool enabledButton = false;
  bool visibleButton = false;
  bool _sortAscending = true;
  int? sortColumnIndex;
  final searchController = TextEditingController();
  final searchTeamController = TextEditingController();

  int teamRadioVal = -1;

  //paginator
  List<PokemonListModel> itemsPokemonPaginator = [];
  List<RouteSup> itemsRouteSupPaginator = [];
  int totalItemsRouteSupPaginator = 0;
  final _paginationFilter = PaginationFilter().obs;
  final _lastPage = false.obs;
  int _limitPagination = 10;
  int? get limit => _paginationFilter.value.limit;
  int? get skip => _paginationFilter.value.skip;
  bool get lastPage => _lastPage.value;
  final ScrollController scrollController = ScrollController();
  void changeTotalPerPage(int limitValue) {
    _lastPage.value = false;
    _changePaginationFilter(1, limitValue);
  }

  void _changePaginationFilter(int skip, int limit) {
    _paginationFilter.update((val) {
      val?.skip = skip;
      val?.limit = limit;
    });
  }

  void loadNextPage() => _changePaginationFilter(skip! + 1, limit!);
  //paginator

  @override
  void onInit() async {
    super.onInit();

    await getCountClientsStates();

    //paginator

    ever(_paginationFilter, (_) => loadListPokemon());
    _changePaginationFilter(0, _limitPagination);
    //paginator
  }

  loadTeamsData() async {
    if (loading) return;
    loading = true;
    routeTeamsSelected = todas;

    if (Constant.ALL_TEAMS_VALUE == currentTeamList) {
      isTodayTeams = false;
    }
    if (Constant.TEAMS_TODAY_VALUE == currentTeamList) {
      isTodayTeams = true;
    }

    if (await Utils.hasInternet()) {
      result =
          await Get.find<MainRepository>().getAppCatRoutesBySupervisor(false);
      if (result[Cnstds.dataCatRoutesBySupervisor] != null) {
        itemsRoutesTeamAll = await result[Cnstds.dataCatRoutesBySupervisor];
        List<Map<String, dynamic>>? routes =
            itemsRoutesTeamAll.map((i) => i.toJson(i)).toList();
        String dataCatRoutesBySupervisorAll = jsonEncode(routes);
        Utils.prefs.dataCatRoutesBySupervisorAll = dataCatRoutesBySupervisorAll;
      } else
        itemsRoutesTeamAll = [];
    } else {
      String dataCatRoutesBySupervisorAll =
          Utils.prefs.dataCatRoutesBySupervisorAll;
      if (dataCatRoutesBySupervisorAll.isNotEmpty) {
        dynamic jsonData = jsonDecode(dataCatRoutesBySupervisorAll);
        itemsRoutesTeamAll = (jsonData as List)
            .map((i) => CatRoutesBySupervisor.fromJson(i))
            .toList();
      }
    }

    if (await Utils.hasInternet()) {
      result =
          await Get.find<MainRepository>().getAppCatRoutesBySupervisor(true);
      if (result[Cnstds.dataCatRoutesBySupervisor] != null) {
        itemsRoutesTeamToday = await result[Cnstds.dataCatRoutesBySupervisor];
        List<Map<String, dynamic>>? routes =
            itemsRoutesTeamToday.map((i) => i.toJson(i)).toList();

        String dataCatRoutesBySupervisorToday = jsonEncode(routes);
        Utils.prefs.dataCatRoutesBySupervisorToday =
            dataCatRoutesBySupervisorToday;
      } else
        itemsRoutesTeamToday = [];
    } else {
      String dataCatRoutesBySupervisorToday =
          Utils.prefs.dataCatRoutesBySupervisorToday;
      if (dataCatRoutesBySupervisorToday.isNotEmpty) {
        dynamic jsonData = jsonDecode(dataCatRoutesBySupervisorToday);
        itemsRoutesTeamToday = (jsonData as List)
            .map((i) => CatRoutesBySupervisor.fromJson(i))
            .toList();
      }
    }

    if (await Utils.hasInternet()) {
      result =
          await Get.find<MainRepository>().appGetTeamListBySupervisor(true);
      if (result[Cnstds.dataTeamListBySupervisor] != null) {
        itemsTeamsToday = await result[Cnstds.dataTeamListBySupervisor];
        Map<String, dynamic>? items = itemsTeamsToday.toJson(itemsTeamsToday);
        String dataTeamListBySupervisorToday = jsonEncode(items);
        Utils.prefs.dataTeamListBySupervisorToday =
            dataTeamListBySupervisorToday;
      }
    } else {
      String dataTeamListBySupervisorToday =
          Utils.prefs.dataTeamListBySupervisorToday;
      if (dataTeamListBySupervisorToday.isNotEmpty) {
        dynamic jsonData = jsonDecode(dataTeamListBySupervisorToday);
        itemsTeamsToday = TeamListBySupervisor.fromJson(jsonData);
      }
    }

    if (await Utils.hasInternet()) {
      result =
          await Get.find<MainRepository>().appGetTeamListBySupervisor(false);
      if (result[Cnstds.dataTeamListBySupervisor] != null) {
        itemsTeamsAll = await result[Cnstds.dataTeamListBySupervisor];
        Map<String, dynamic>? items = itemsTeamsAll.toJson(itemsTeamsAll);
        String dataTeamListBySupervisorAll = jsonEncode(items);
        Utils.prefs.dataTeamListBySupervisorAll = dataTeamListBySupervisorAll;
      }
    } else {
      String dataTeamListBySupervisorAll =
          Utils.prefs.dataTeamListBySupervisorAll;
      if (dataTeamListBySupervisorAll.isNotEmpty) {
        dynamic jsonData = jsonDecode(dataTeamListBySupervisorAll);
        itemsTeamsAll = TeamListBySupervisor.fromJson(jsonData);
      }
    }
    itemsTeams = TeamListBySupervisor.copy((itemsTeamsAll));

    if (itemsTeams.absence_list != null) {
      for (var _item in itemsTeams.absence_list!) {
        itemsTeams.attendance_list?.add(_item);
      }
    }

    itemsTeamsAux = TeamListBySupervisor.copy((itemsTeams));
    print('itemsTeams.attendance_count.toString()');
    print(itemsTeams.attendance_count.toString());
    totalItemsTeams = int.parse(itemsTeams.attendance_count.toString()) +
        int.parse(itemsTeams.absence_count.toString());
    totalItemsFiltredTeams = totalItemsTeams;
    titleTeams = equiposTodosStr + " [$totalItemsTeams]";
    currentTeamList = Constant.ALL_TEAMS_VALUE;

    setFilterTeams(Constant.TEAMS_TODAY_VALUE);
    loading = false;
    update();
  }

  changeTeamRadioVal(value) {
    teamRadioVal = int.parse(value.toString());
    searchTeamController.clear();
    routeTeamsSelected = todas;
    log(itemsTeams.toString());
    // filteritemsTeams();
    update();
    refresh();
  }

  loadStoresData() async {
    loading = true;
    routeStoresSelected = todas;
    if (await Utils.hasInternet()) {
      result = await Get.find<MainRepository>().getAppCatRouteBySupervisor();
      if (result[Cnstds.dataAppCatRouteBySupervisor] != null) {
        itemsRoutes = await result[Cnstds.dataAppCatRouteBySupervisor];
        List<Map<String, dynamic>>? routesBySupervisor =
            itemsRoutes.map((i) => i.toJson(i)).toList();
        String dataAppCatRouteBySupervisor = jsonEncode(routesBySupervisor);
        Utils.prefs.dataAppCatRouteBySupervisor = dataAppCatRouteBySupervisor;
      } else
        itemsRoutes = [];
    } else {
      String dataAppCatRouteBySupervisor =
          Utils.prefs.dataAppCatRouteBySupervisor;
      if (dataAppCatRouteBySupervisor.isNotEmpty) {
        dynamic jsonData = jsonDecode(dataAppCatRouteBySupervisor);
        itemsRoutes = (jsonData as List)
            .map((i) => CatRoutesBySupervisor.fromJson(i))
            .toList();
      }
    }

    if (await Utils.hasInternet()) {
      result =
          await Get.find<MainRepository>().getAppAnaquelerosToManageClient('0');
      if (result[Cnstds.dataAnaquelerosToManageClient] != null) {
        itemsAnaqueleros = await result[Cnstds.dataAnaquelerosToManageClient];
        List<Map<String, dynamic>>? anaquelerosToManage =
            itemsAnaqueleros.map((i) => i.toJson(i)).toList();

        String dataAnaquelerosToManageClient = jsonEncode(anaquelerosToManage);
        Utils.prefs.dataAnaquelerosToManageClient =
            dataAnaquelerosToManageClient;
      } else
        itemsAnaqueleros = [];
    } else {
      String dataAnaquelerosToManageClient =
          Utils.prefs.dataAnaquelerosToManageClient;
      if (dataAnaquelerosToManageClient.isNotEmpty) {
        dynamic jsonData = jsonDecode(dataAnaquelerosToManageClient);
        itemsAnaqueleros = (jsonData as List)
            .map((i) => AnaquelerosToManage.fromJson(i))
            .toList();
      }
    }

    if (await Utils.hasInternet()) {
      result = await Get.find<MainRepository>()
          .getAppAllClientsListByRouteSupervisor('');
      if (result[Cnstds.dataClientsListByRouteSupervisor] != null) {
        itemsStoresAll = await result[Cnstds.dataClientsListByRouteSupervisor];

        List<Map<String, dynamic>>? clientsListByRouteSupervisor =
            itemsStoresAll.map((i) => i.toJson(i)).toList();

        String dataClientsListByRouteSupervisor =
            jsonEncode(clientsListByRouteSupervisor);
        Utils.prefs.dataClientsListByRouteSupervisor =
            dataClientsListByRouteSupervisor;
      } else
        itemsStoresAll = [];
    } else {
      String dataClientsListByRouteSupervisor =
          Utils.prefs.dataClientsListByRouteSupervisor;
      if (dataClientsListByRouteSupervisor.isNotEmpty) {
        dynamic jsonData = jsonDecode(dataClientsListByRouteSupervisor);
        itemsStoresAll = (jsonData as List)
            .map((i) => ClientsListByRouteSupervisor.fromJson(i))
            .toList();
      }
    }
    if (await Utils.hasInternet()) {
      result = await Get.find<MainRepository>()
          .getAppAllClientsListByRouteSupervisorToday('');
      if (result[Cnstds.dataClientsListByRouteSupervisorToday] != null) {
        itemsStoresToday =
            await result[Cnstds.dataClientsListByRouteSupervisorToday];

        List<Map<String, dynamic>>? clientsListByRouteSupervisorToday =
            itemsStoresToday.map((i) => i.toJson(i)).toList();

        String dataClientsListByRouteSupervisorToday =
            jsonEncode(clientsListByRouteSupervisorToday);
        Utils.prefs.dataClientsListByRouteSupervisorToday =
            dataClientsListByRouteSupervisorToday;
      } else
        itemsStoresToday = [];
    } else {
      String dataClientsListByRouteSupervisorToday =
          Utils.prefs.dataClientsListByRouteSupervisorToday;
      if (dataClientsListByRouteSupervisorToday.isNotEmpty) {
        dynamic jsonData = jsonDecode(dataClientsListByRouteSupervisorToday);
        itemsStoresToday = (jsonData as List)
            .map((i) => ClientsListByRouteSupervisor.fromJson(i))
            .toList();
      }
    }
    itemsStores = itemsStoresAll;
    itemsStoresAux = itemsStores;
    loading = false;
    totalItemsStores = itemsStores.length;
    titleStore = tiendasTodasStr + " [$totalItemsStores]";
    currentStoreList = Constant.ALL_STORES_VALUE;

    update();
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      loadAnaquelerosManage()
  Propósito:   Proceso que carga la lista de anaqueleros asignados a un supervisor
  Entradas:    NA
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha          HU          Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        01/08/2022   [SUP] HU04      Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  loadAnaquelerosToManage(String id_client_route) async {
    listAnaqueleros = [];

    AnaquelerosToManageClientLocal? data = await Get.find<MainRepository>()
        .getOneAnaquelerosToManageClientLocal(id_client_route);
    if (data != null) {
      dynamic jsonData = jsonDecode(data.content);
      listAnaqueleros = (jsonData as List)
          .map((i) => AnaquelerosToManage.fromJson(i))
          .toList();
    }
    update();
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      getClientOtherRoute
  Propósito:   Evento que manda llamar la ventana de diálogo donde se muestran las otras rutas que atienden a la tienda
  Entradas:    _: BuildContext
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha          HU          Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU02      Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  getClientOtherRoute(BuildContext _) {
    openBottomSheetClientOtherRoute(_);
    update();
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      loadListRoute
  Propósito:   Procedimiento que carga la información de las rutas de un supervisor y sus tiendas
  Entradas:    NA
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha          HU          Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU02      Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  loadListPokemon() async {
    if (loading) return;
    loading = true;
    Utils.syncDialog(obteniendoDatosStr);
    itemsRouteSupPaginator.clear();
    int skip = int.parse(_paginationFilter.value.skip.toString());
    int limit = int.parse(_paginationFilter.value.limit.toString());
    result =
        await Get.find<MainRepository>().getAppHomePokemonList(skip, limit);

    if (result[Cnstds.dataPokemonList] != null) {
      itemsPokemonPaginator =
          result[Cnstds.dataPokemonList] as List<PokemonListModel>;
      itemsPokemon.addAll(itemsPokemonPaginator);
      for (var _item in itemsPokemon) {
        var splitUtl;
        splitUtl = _item.url?.split("/");
        _item.id = splitUtl[6];
        _item.img = Cnstds.IMG_URL_SOURCE + splitUtl[6] + '.png';
        result = await Get.find<MainRepository>()
            .getAppHomePokemonDetailList(_item.url.toString());
        if (result[Cnstds.dataPokemonDetailList] != null) {
          _item.detail = result[Cnstds.dataPokemonDetailList];
        }
      }
    }

    //pagination
    if (itemsPokemonPaginator.isEmpty) {
      _lastPage.value = true;
    }
    //pagination
    Utils.withoutSending =
        await Get.find<MainRepository>().pendingShippingAgenda();
    loading = false;
    Get.back();
    update();
    if (skip! > 0) {
      scrollController.animateTo((itemsPokemon.length - _limitPagination) * 45,
          duration: const Duration(microseconds: 100), curve: Curves.linear);
    }
    update();
  }

  List<DropdownMenuItem<dynamic>> get _hours {
    List<DropdownMenuItem<dynamic>> menuItems = [];
    for (int _hora = 0; _hora < 24; _hora++) {
      String hora = _hora.toString();
      if (hora.length == 1) hora = "0" + hora;
      menuItems.add(
          DropdownMenuItem(child: Text(hora + ':00'), value: hora + ':00'));
    }
    return menuItems;
  }

  List<DropdownMenuItem<dynamic>> get _hoursEmpty {
    List<DropdownMenuItem<dynamic>> menuItems = [];
    menuItems.add(DropdownMenuItem(child: Text(''), value: ''));
    return menuItems;
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      hoursList
  Propósito:   Método que obtiene el listado de horas
  Entradas:    NA
  Salida:      List<DropdownMenuItem<dynamic>>

  * Historia de Revisiones
  * Implementador                 Fecha          HU          Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU03      Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  List<DropdownMenuItem<dynamic>> get hoursList {
    List<DropdownMenuItem<dynamic>> menuItems = [];
    for (int _hora = 1; _hora <= 23; _hora++) {
      String hora = _hora.toString();
      if (hora.length == 1) hora = "0" + hora;
      menuItems.add(DropdownMenuItem(child: Text(hora), value: hora));
    }
    return menuItems;
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      minutesList
  Propósito:   Método que obtiene el listado de minutos
  Entradas:    NA
  Salida:      List<DropdownMenuItem<dynamic>>

  * Historia de Revisiones
  * Implementador                 Fecha          HU          Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU03      Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  List<DropdownMenuItem<dynamic>> get minutesList {
    List<DropdownMenuItem<dynamic>> menuItems = [];
    for (int _min = 0; _min <= 59; _min++) {
      String minutos = _min.toString();
      if (minutos.length == 1) minutos = "0" + minutos;
      menuItems.add(DropdownMenuItem(child: Text(minutos), value: minutos));
    }
    return menuItems;
  }

  List<DropdownMenuItem<dynamic>> get routesStores {
    List<DropdownMenuItem<dynamic>> menuItems = [];
    menuItems.add(DropdownMenuItem(child: Text(todas), value: todas));
    for (var _item in itemsRoutes) {
      menuItems.add(DropdownMenuItem(
          child: Text(
            _item.idRoute!.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          value: _item.idRoute!.toString()));
    }
    return menuItems;
  }

  List<DropdownMenuItem<dynamic>> get routesTeams {
    List<DropdownMenuItem<dynamic>> menuItems = [];
    menuItems.add(DropdownMenuItem(child: Text(todas), value: todas));

    List<CatRoutesBySupervisor> itemsRoutes = [];

    itemsRoutes = itemsRoutesTeamAll;

    for (var _item in itemsRoutes) {
      menuItems.add(DropdownMenuItem(
          child: Text(
            _item.idRoute!.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          value: _item.idRoute!.toString()));
    }
    return menuItems;
  }

  setButtonRoute(int index) {
    if (loading) return;
    loading = true;
    for (var i = 0; i < itemsRouteSup.length; i++)
      itemsRouteSup[i].selected = false;
    itemsRouteSup[index].selected = true;
    loading = false;
    update();
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      ShowStoreDetailSup
  Propósito:   Procedimiento que muestra la pantalla del detalle de la tienda
  Entradas:    idRoute: Id de la ruta
               diaryClient: Valores de la tienda
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha          HU          Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU02      Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  ShowStoreDetailSup(String idRoute, DiaryClient diaryClient,
      RefreshController controller, int i, int index) async {
    visibleButton = i >= 0 && int.parse(diaryClient.id_status.toString()) < 3;
    idRouteAgendaCurrent = idRoute;
    diaryClientCurrent = DiaryClient.Copy(diaryClient);
    isDetailUpdate = false;
    indexDiaryClientCurrent = i;
    indexRouteSupCurrent = index;

    // Si entra a esta condición es porque viene de tiendas
    if (index == -1) {
      indexRouteSupCurrent = -1;
      indexDiaryClientCurrent = -1;
      for (var i = 0; i < itemsRouteSup.length; i++) {
        if (itemsRouteSup[i].id_route == idRoute) {
          indexRouteSupCurrent = i;
          for (var j = 0; j < itemsRouteSup[i].diary_client_list!.length; j++) {
            if (itemsRouteSup[i].diary_client_list![j].id_client_route ==
                diaryClient.id_client_route) {
              indexDiaryClientCurrent = j;
              break;
            }
          }
        }
      }
      indexStoreCurrentDetails = i;
      subIndexPage = 1;
    }

    await loadStoreDetailSup();
    await loadAnaquelerosToManage(
        diaryClientCurrent.id_client_route.toString());

    if (itemClientDetailSup != null) {
      Get.to(
        () => ClientDetailPage(controller),
        binding: PokemonBinding(),
      );
    } else {
      Utils.snackErrorMessagge('Warning', errorDetailStoreInfo);
    }
    update();
  }

  showDetailStoreTeamsAnaquelero(int index) async {
    indexTeamCurrentDetails = index;
    int? count = await Get.find<MainRepository>().existClientDetailSupLocal(
        teamCurrent.details![index].id_client,
        teamCurrent.details![index].id_cellar,
        teamCurrent.details![index].id_client_route);
    if (count! > 0) {
      ClientDetailSupLocal itemLocal = await Get.find<MainRepository>()
          .getOneClientDetailSupLocal(
              teamCurrent.details![index].id_client,
              teamCurrent.details![index].id_cellar,
              teamCurrent.details![index].id_client_route);
      String? valor = itemLocal.content;
      if (valor!.isNotEmpty) {
        dynamic jsonData = jsonDecode(valor);
        ClientDetailSup data = ClientDetailSup.clientDetailSupfromJson(
            json: jsonData, source: noapiStr);
        itemClientDetailSup = ClientDetailSup.Copy(data);
      }
    }
    DiaryClient diaryClient = DiaryClient(
      id_client: itemClientDetailSup!.client_id.toString(),
      name_client: itemClientDetailSup!.client_name.toString(),
      id_cellar: itemClientDetailSup!.cellar_id.toString(),
      name_cellar: itemClientDetailSup!.cellar_name.toString(),
      start_time: itemClientDetailSup!.start_time.toString(),
      end_time: itemClientDetailSup!.end_time.toString(),
      hours: itemClientDetailSup!.diff_time_show.toString(),
      id_status: itemClientDetailSup!.status_id.toString(),
      name_status: itemClientDetailSup!.status_name.toString(),
      color_status: itemClientDetailSup!.status_color.toString(),
      id_client_route: itemClientDetailSup!.id_client_route.toString(),
    );
    indexRouteSupCurrent = -1;
    indexDiaryClientCurrent = -1;
    for (var i = 0; i < itemsRouteSup.length; i++) {
      if (itemsRouteSup[i].id_route == teamCurrent.details![index].id_route) {
        indexRouteSupCurrent = i;
        for (var j = 0; j < itemsRouteSup[i].diary_client_list!.length; j++) {
          if (itemsRouteSup[i].diary_client_list![j].id_client_route ==
              itemClientDetailSup!.id_client_route) {
            indexDiaryClientCurrent = j;
            break;
          }
        }
      }
    }
    subIndexPage = 2;
    update();
    if (indexRouteSupCurrent >= 0 && indexDiaryClientCurrent >= 0) {
      ShowStoreDetailSup(
          teamCurrent.details![index].id_route.toString(),
          diaryClient,
          refreshControllerSupervisorItemDetail,
          indexDiaryClientCurrent,
          indexRouteSupCurrent);
    }
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      loadStoreDetailSup
  Propósito:   Procedimiento que carga la información detallada de la tienda
  Entradas:    NA
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha          HU          Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU02      Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  loadStoreDetailSup() async {
    if (loading) return;
    loading = true;
    ResponseCode response;
    itemClientDetailSup = null;
    itemsClientDetailOtherRoute.clear();
    if (await Utils.hasInternet()) {
      // Antes de traer la información, revisar si hay algo sin enviar para aprovechar enviarlo
      await checkPendingShippingAgenda();
      // Después de actualizar lo que no está enviado se procede a bajar la información
      result = await Get.find<MainRepository>().getAppClientDetailsBySupervisor(
          idRouteAgendaCurrent,
          diaryClientCurrent.id_client,
          diaryClientCurrent.id_cellar,
          diaryClientCurrent.id_client_route);
      if (result.length > 0) {
        response = result[Cnstds.KEY_RESPONSE];
        _code = response.code;
        if (_code == Cnstds.KEY_GST00000) {
          itemClientDetailSup = ClientDetailSup.Copy(
              result[Cnstds.dataClientDetailSup] as ClientDetailSup);
          if (subIndexPage == 0) subIndexPage = 1;
          // Esta parte es cuando se guarda de forma local
          Map<String, dynamic>? itemClientDetailSupMap =
              itemClientDetailSup!.toJson(itemClientDetailSup!);

          String jsonString = jsonEncode(itemClientDetailSupMap);

          int? count = await Get.find<MainRepository>()
              .existClientDetailSupLocal(
                  diaryClientCurrent.id_client,
                  diaryClientCurrent.id_cellar,
                  diaryClientCurrent.id_client_route);
          if (count! == 0) {
            await Get.find<MainRepository>().insertClientDetailSupLocal(
                ClientDetailSupLocal(
                    id_client: int.parse(diaryClientCurrent.id_client!),
                    id_cellar: int.parse(diaryClientCurrent.id_cellar!),
                    id_client_route:
                        int.parse(diaryClientCurrent.id_client_route!),
                    content: jsonString,
                    enviadoAnaquelero: 1,
                    enviadoAsistencia: 1));
          } else {
            await Get.find<MainRepository>().updateClientDetailSupLocal(
                diaryClientCurrent.id_client!,
                diaryClientCurrent.id_cellar!,
                diaryClientCurrent.id_client_route!,
                jsonString);
          }
        }
      }
    } else {
      subIndexPage = 1;
      int? count = await Get.find<MainRepository>().existClientDetailSupLocal(
          diaryClientCurrent.id_client,
          diaryClientCurrent.id_cellar,
          diaryClientCurrent.id_client_route);
      if (count! > 0) {
        ClientDetailSupLocal itemLocal = await Get.find<MainRepository>()
            .getOneClientDetailSupLocal(
                diaryClientCurrent.id_client,
                diaryClientCurrent.id_cellar,
                diaryClientCurrent.id_client_route);
        String? valor = itemLocal.content;
        if (valor!.isNotEmpty) {
          dynamic jsonData = jsonDecode(valor);
          ClientDetailSup data = ClientDetailSup.clientDetailSupfromJson(
              json: jsonData, source: noapiStr);
          itemClientDetailSup = ClientDetailSup.Copy(data);
        }
      }
    }

    if (await Utils.hasInternet()) {
      result = await Get.find<MainRepository>()
          .getAppClientDetailsOtherRoutesBySupervisor(idRouteAgendaCurrent,
              diaryClientCurrent.id_client, diaryClientCurrent.id_cellar);
      if (result.length > 0) {
        response = result[Cnstds.KEY_RESPONSE];
        _code = response.code;
        if (_code == Cnstds.KEY_GST00000) {
          itemsClientDetailOtherRoute =
              result[Cnstds.dataClientDetailOtherRoute]
                  as List<ClientDetailOtherRoute>;
          if (itemsClientDetailOtherRoute.length > 0) {
            List<Map<String, dynamic>>? clientDetailOtherRouteMap =
                itemsClientDetailOtherRoute.map((i) => i.toJson(i)).toList();

            String jsonString = jsonEncode(clientDetailOtherRouteMap);
            int? count = await Get.find<MainRepository>()
                .existClientDetailOtherRouteLocal(idRouteAgendaCurrent,
                    diaryClientCurrent.id_client, diaryClientCurrent.id_cellar);
            if (count == 0) {
              await Get.find<MainRepository>()
                  .insertClientDetailOtherRouteLocal(
                      ClientDetailOtherRouteLocal(
                          id_route: idRouteAgendaCurrent,
                          id_client: int.parse(
                              diaryClientCurrent.id_client.toString()),
                          id_cellar: int.parse(
                              diaryClientCurrent.id_cellar.toString()),
                          content: jsonString));
            } else {
              await Get.find<MainRepository>()
                  .updateClientDetailOtherRouteLocal(
                      idRouteAgendaCurrent,
                      diaryClientCurrent.id_client.toString(),
                      diaryClientCurrent.id_cellar.toString(),
                      jsonString);
            }
          }
        }
      }
    } else {
      int? count = await Get.find<MainRepository>()
          .existClientDetailOtherRouteLocal(idRouteAgendaCurrent,
              diaryClientCurrent.id_client, diaryClientCurrent.id_cellar);
      if (count! > 0) {
        ClientDetailOtherRouteLocal data = await Get.find<MainRepository>()
            .getOneClientDetailOtherRouteLocal(idRouteAgendaCurrent,
                diaryClientCurrent.id_client, diaryClientCurrent.id_cellar);
        dynamic jsonData = jsonDecode(data.content);
        itemsClientDetailOtherRoute = (jsonData as List)
            .map((i) => ClientDetailOtherRoute.fromJson(i))
            .toList();
      }
    }
    Utils.withoutSending =
        await Get.find<MainRepository>().pendingShippingAgenda();
    loading = false;
    update();
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      setFilterStatus
  Propósito:   Procedimiento donde filtra las tiendas del home del supervisor en base al estatus
  Entradas:    value: Indica el id del status de la tienda para filtrar
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha          HU          Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU01      Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  setFilterStatus(String value) {
    for (var i = 0; i < itemsRouteSup.length; i++)
      for (var j = 0; j < itemsRouteSup[i].diary_client_list!.length; j++)
        itemsRouteSup[i].diary_client_list![j].visible = true;
    if (Constant.ID_STATUS_ALL != value) {
      for (var i = 0; i < itemsRouteSup.length; i++)
        for (var j = 0; j < itemsRouteSup[i].diary_client_list!.length; j++)
          if (itemsRouteSup[i].diary_client_list![j].id_status != value)
            itemsRouteSup[i].diary_client_list![j].visible = false;
    }
    update();
  }

  setFilterSores(String value) {
    searchController.text = '';
    routeStoresSelected = todas;
    if (value == Constant.ALL_STORES_VALUE) {
      itemsStores = itemsStoresAll;
      totalItemsStores = itemsStores.length;
      titleStore = tiendasTodasStr + " [$totalItemsStores]";
    }
    if (value == Constant.AGENDS_TODAY_VALUE) {
      itemsStores = itemsStoresToday;
      totalItemsStores = itemsStores.length;
      titleStore = tiendasHoyStr + " [$totalItemsStores]";
    }
    currentStoreList = value;
    update();
  }

  setFilterTeams(String value) {
    searchTeamController.clear();
    routeTeamsSelected = todas;
    if (value == Constant.ALL_TEAMS_VALUE) {
      itemsTeams = itemsTeamsAll;
      totalItemsTeams = int.parse(itemsTeams.attendance_count.toString()) +
          int.parse(itemsTeams.absence_count.toString());
      titleTeams = equiposTodosStr + " [$totalItemsTeams]";
      teamRadioVal = -1;
    }
    if (value == Constant.TEAMS_TODAY_VALUE) {
      itemsTeams = itemsTeamsToday;
      totalItemsTeams = int.parse(itemsTeams.attendance_count.toString()) +
          int.parse(itemsTeams.absence_count.toString());
      titleTeams = equiposHoyStr + " [$totalItemsTeams]";
    }
    itemsTeamsAux = TeamListBySupervisor.copy((itemsTeams));
    currentTeamList = value;
    update();
  }

  void filteritemsStores() async {
    if (loading) return;
    loading = true;
    String _routeStoresSelected = routeStoresSelected;
    String valueFilter = searchController.text.trim();
    if (_routeStoresSelected == todas) _routeStoresSelected = '';
    itemsStores = itemsStoresAux;
    update();

    List<ClientsListByRouteSupervisor> result = itemsStores.where((item) {
      return ((item.nameClient!
                  .trim()
                  .toLowerCase()
                  .contains(valueFilter.trim().toLowerCase()) ||
              item.nameCellar!
                  .trim()
                  .toLowerCase()
                  .contains(valueFilter.trim().toLowerCase()) ||
              item.nameStatus!
                  .trim()
                  .toLowerCase()
                  .contains(valueFilter.trim().toLowerCase()) ||
              item.nameRoute!
                  .trim()
                  .toLowerCase()
                  .contains(valueFilter.trim().toLowerCase())) &&
          item.idRoute!
              .trim()
              .toLowerCase()
              .contains(_routeStoresSelected.trim().toLowerCase()));
    }).toList();
    itemsStores = result;
    loading = false;
    update();
    return;
  }

  void filteritemsTeams() async {
    totalItemsFiltredTeams = 0;
    String _rrouteTeamsSelected = routeTeamsSelected;
    String valueFilter = searchTeamController.text.trim();
    if (_rrouteTeamsSelected == todas) _rrouteTeamsSelected = '';
    itemsTeams = TeamListBySupervisor.copy((itemsTeamsAux));
    log(itemsTeams.toString());
    List<Team>? seachList = teamRadioVal == -1
        ? itemsTeams.attendance_list
        : itemsTeams.absence_list;
    await Future.delayed(const Duration(milliseconds: 300));
    List<Team> result = seachList!.where((item) {
      return ((item.search_field!
              .trim()
              .toLowerCase()
              .contains(valueFilter.trim().toLowerCase())) &&
          item.search_field!
              .trim()
              .toLowerCase()
              .contains(_rrouteTeamsSelected.trim().toLowerCase()));
    }).toList();
    if (teamRadioVal == -1) {
      itemsTeams.attendance_list = result;
      totalItemsFiltredTeams = result.length;
    }
    if (teamRadioVal == 1) {
      itemsTeams.absence_list = result;
      totalItemsFiltredTeams = result.length;
    }
    update();
    return;
  }

  onRefreshSupervisor(RefreshController controller) async {
    bool isSameDay = Utils.isSameDay();
    if (await Utils.hasInternet()) {
      await getCountClientsStates();
      await loadStoresData();
      await loadTeamsData();
      await checkPendingShippingAgenda();
      await dropDetailStoreSupLocal();
      await loadListPokemon();
      Utils.withoutSending = false;
      Utils.withoutSendingStores = false;
      Utils.withoutSendingTeams = false;
      if (!isSameDay) Utils.setCurrentDate();
      controller.refreshCompleted();
    } else {
      await Future.delayed(Duration(milliseconds: 1000));
      controller.refreshFailed();
    }

    update();
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      setIndexPage
  Propósito:   Procedimiento que actualiza el indexpage
  Entradas:    index: Valor de la página a actualizar
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha          HU          Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU02      Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  setIndexPage(int index) {
    indexPage = index;
    update();
  }

  void sortAnaqueleros<T>(
    Comparable<T> Function(AnaquelerosToManage d) getField,
    int columnIndex,
    bool ascending,
    _loadData,
  ) {
    bool asc = !_sortAscending;
    _loadData.sorts<T>(getField, asc);
    sortColumnIndex = columnIndex;
    _sortAscending = asc;
    update();
  }

  _confirmAttendanceTeams(BuildContext _) async {
    await Jiffy.locale('es');
    String day = Jiffy().EEEE.toString();
    day = day.replaceFirst(day[0], day[0].toUpperCase());

    String numDay = Jiffy().date.toString();
    String hour = Jiffy().hour.toString();
    String minute = Jiffy().minute.toString();
    String today = day + " " + numDay + ', $hour:$minute';
    showDialog(
      context: _,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        child: SizedBox(
          height: 281,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  SvgPicture.asset(
                    Constant.ICON_CHECK,
                    width: 50,
                    color: themeApp.colorSecundaryGreen,
                  ),
                  SizedBox(height: 20),
                  Text(
                    confirmacionDeAsistenciaStr,
                    style: themeApp.text18boldBlack600,
                  ),
                  SizedBox(height: 5),
                  Text(
                    hemosRecibidoTuReporteStr,
                    style: themeApp.text16400Black,
                  ),
                  Text(
                    today,
                    style: themeApp.text16400Blue,
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Button1(
                      label: textAceptar,
                      style: themeApp.text18boldWhite,
                      background: themeApp.colorPrimaryBlue,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ).then((v) {
      if (v != null) {}
    });
  }

  _drawAnaqueleroListItem(Team team, bool time) {
    return BootstrapRow(
      children: <BootstrapCol>[
        BootstrapCol(
          sizes: 'col-10',
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              team.id_anaquelero.toString() +
                  ' - ' +
                  team.name_anaquelero.toString(),
              style: themeApp.text16400Black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        BootstrapCol(
          sizes: 'col-2',
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              time == true ? team.time_start.toString() : '',
              style: themeApp.text16400Blue,
            ),
          ),
        ),
      ],
    );
  }

  _drawAnaqueleroAbsenceList() {
    List<BootstrapRow> w = [];
    if (itemsTeams.absence_list != null) {
      for (var data in itemsTeams.absence_list!) {
        w.add(_drawAnaqueleroListItem(data, false));
      }
    }
    return w;
  }

  _drawAnaqueleroAttendanceList() {
    List<BootstrapRow> w = [];
    if (itemsTeams.attendance_list != null) {
      for (var data in itemsTeams.attendance_list!) {
        w.add(_drawAnaqueleroListItem(data, true));
      }
    }
    return w;
  }

  void stores_openBottomSheetConfirmAttendanceTeams(BuildContext _) async {
    ResponsiveApp responsiveApp = ResponsiveApp(_);
    Size size = MediaQuery.of(_).size;

    bootstrapGridParameters(gutterSize: 10);
    _submit() async {
      //
      result = await Get.find<MainRepository>().appClosingDayBySupervisor();
      ResponseCode response = result[Cnstds.KEY_RESPONSE];
      _code = response.code;
      if (_code == Cnstds.KEY_GST00000) {
        Get.back();
        _confirmAttendanceTeams(_);
        await loadTeamsData();
        update();
        refresh();
      } else {
        Utils.snackErrorMessagge('Error', response.message);
      }
    }

    Get.bottomSheet(
      Container(
          height: size.height < 600 ? size.height * 0.83 : size.height * 0.70,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: BootstrapContainer(fluid: true, children: [
            Column(
              children: [
                SizedBox(height: 10),
                BootstrapRow(
                  children: <BootstrapCol>[
                    BootstrapCol(
                      sizes: 'col-10',
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(finalizarJornadaStr,
                            style: themeApp.text20700Black),
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-2',
                      child: Container(
                        //width: 30.0,
                        //height: 30.0,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.clear_rounded),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 10),
                    BootstrapRow(
                      children: <BootstrapCol>[
                        BootstrapCol(
                          sizes: 'col-2',
                          child: Container(
                            //height: 40,
                            //width: 40,
                            child: Center(
                              child: SvgPicture.asset(
                                  Constant.ICON_GROUP_GROUPS186),
                            ),
                          ),
                        ),
                        BootstrapCol(
                          sizes: 'col-10',
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(asistenciaStr,
                                          style: themeApp.text18boldBlack600),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(_).size.height * 0.20,
                  child: SingleChildScrollView(
                    child: Column(
                      children: _drawAnaqueleroAttendanceList(),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
                    BootstrapRow(
                      children: <BootstrapCol>[
                        BootstrapCol(
                          sizes: 'col-12',
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: themeApp.colorGenericBox,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
                    BootstrapRow(
                      children: <BootstrapCol>[
                        BootstrapCol(
                          sizes: 'col-2',
                          child: Container(
                            height: 40,
                            width: 40,
                            child: Center(
                              child: SvgPicture.asset(
                                  Constant.ICON_GROUP_GROUPS219),
                            ),
                          ),
                        ),
                        BootstrapCol(
                          sizes: 'col-10',
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(inasistenciaStr,
                                          overflow: TextOverflow.ellipsis,
                                          style: themeApp.text18boldBlack600),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(_).size.height * 0.20,
                  child: SingleChildScrollView(
                    child: Column(
                      children: _drawAnaqueleroAbsenceList(),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
                    BootstrapRow(
                      children: <BootstrapCol>[
                        BootstrapCol(
                          sizes: 'col-12',
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: themeApp.colorGenericBox,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
                    BootstrapRow(
                      children: <BootstrapCol>[
                        BootstrapCol(
                          sizes: 'col-12',
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Button1(
                              label: confirmarAsistenciaStr,
                              style: themeApp.text18boldWhite,
                              background: themeApp.colorPrimaryBlue,
                              onPressed: () {
                                _submit();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ])),
      backgroundColor: Colors.white,
      elevation: 0,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(responsiveApp.buttonRadius),
          topLeft: Radius.circular(responsiveApp.buttonRadius),
        ),
      ),
    );
  }

  void _Stores_openBottomSheetFormStore(
      BuildContext _,
      ClientsListByRouteSupervisor item,
      int index,
      String currentStoreList) async {
    ResponsiveApp responsiveApp = ResponsiveApp(_);
    bootstrapGridParameters(gutterSize: 10);
    bool submit = false;
    bool enable = false;

    void checkBotonPass() {
      submit = (item.startTime != null && item.startTime.toString() != '') &&
          (item.endTime != null && item.endTime.toString() != '') &&
          enable == true &&
          _error == false;
      update();
    }

    _enable(bool value) {
      item.forToday = value;
      enable = value;
      checkBotonPass();
      update();
    }

    _enable(item.forToday);
    _submit(int index, String currentStoreList) async {
      FormState form = formKey.currentState!;
      if (!form.validate()) {
        return;
      }
      String stringSplit1 = item.startTime.toString();
      List splitArray1 = stringSplit1.split(':');
      int startTime = int.parse(splitArray1[0].toString().trim());

      String stringSplit2 = item.endTime.toString();
      List splitArray2 = stringSplit2.split(':');
      int endTime = int.parse(splitArray2[0].toString().trim());
      _error = false;
      if (endTime <= startTime) {
        _error = true;
        return;
      }

      List<ClientsListByRouteSupervisor> itemsStoresLocal = [];
      if (Constant.ALL_STORES_VALUE == currentStoreList) {
        itemsStoresLocal = itemsStoresAll;
      }
      if (Constant.AGENDS_TODAY_VALUE == currentStoreList) {
        itemsStoresLocal = itemsStoresToday;
      }
      item.enviado = '0';
      itemsStoresLocal[index] = item;
      List<Map<String, dynamic>>? itemsStores =
          itemsStoresLocal.map((i) => i.toJson(i)).toList();

      String dataItemsLocal = jsonEncode(itemsStores);

      if (Constant.ALL_STORES_VALUE == currentStoreList) {
        Utils.prefs.dataClientsListByRouteSupervisor = dataItemsLocal;
      }
      if (Constant.AGENDS_TODAY_VALUE == currentStoreList) {
        Utils.prefs.dataClientsListByRouteSupervisorToday = dataItemsLocal;
      }
      update();
      setManageClientOutFrequencyBySupervisor(_);

      Get.back();
      loadStoresData();
      _confirmAttendanceTeams(_);
    }

    _errorTimes() {
      String stringSplit1 = item.startTime.toString();
      List splitArray1 = stringSplit1.split(':');
      int startTime = int.parse(splitArray1[0].toString().trim());

      String stringSplit2 = item.endTime.toString();
      List splitArray2 = stringSplit2.split(':');
      int endTime = int.parse(splitArray2[0].toString().trim());
      _error = false;
      if (endTime <= startTime) {
        _error = true;
      }
    }

    _endTime(v) {
      item.textTime = '';
      item.endTime = v;
      item.textTime =
          item.startTime.toString() + text_ + item.endTime.toString();
      _errorTimes();
      checkBotonPass();
      update();
    }

    _startTime(v) {
      item.textTime = '';
      item.startTime = v;
      item.textTime =
          item.startTime.toString() + text_ + item.endTime.toString();
      _errorTimes();
      checkBotonPass();
      update();
    }

    _error = false;
    Get.bottomSheet(
      StatefulBuilder(builder: (context, setState) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              //height: MediaQuery.of(_).size.height * 0.6,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: BootstrapContainer(fluid: true, children: [
                Column(children: [
                  Container(
                    // color: Colors.yellow,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        BootstrapRow(
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-10',
                              child: Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(gestionarTiendaStr,
                                    style: themeApp.text20700Black),
                              ),
                            ),
                            BootstrapCol(
                              sizes: 'col-2',
                              child: Container(
                                width: 30.0,
                                height: 30.0,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: Icon(Icons.clear_rounded),
                                    onPressed: () {
                                      Get.back();
                                      if (enable) {
                                        openBottomSheetExitStore(
                                            _, item, index, currentStoreList);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.green,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 20),
                            BootstrapRow(
                              children: <BootstrapCol>[
                                BootstrapCol(
                                  sizes: 'col-2',
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                      child: SvgPicture.asset(
                                          Constant.ICON_HAPPY_FACE),
                                    ),
                                  ),
                                ),
                                BootstrapCol(
                                  sizes: 'col-8',
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: Text(
                                                  item.anaqueleroAnaquelero
                                                      .toString(),
                                                  style: item.anaqueleroAnaquelero
                                                              .toString() !=
                                                          textVacant
                                                      ? themeApp.text16400Black
                                                      : themeApp
                                                          .textParagraphSecondaryOrange),
                                            )),
                                      ),
                                      Container(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: Text(
                                                  item.anaqueleroTypeAssign
                                                      .toString(),
                                                  style: item
                                                          .anaqueleroTypeAssign
                                                          .toString()
                                                          .contains(
                                                              reemplazoStr)
                                                      ? themeApp
                                                          .textNoteSecondaryBlue
                                                      : themeApp.text16400Gray),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                BootstrapCol(
                                  sizes: 'col-2',
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: SvgPicture.asset(
                                            Constant.ICON_EDIT),
                                        onPressed: () {
                                          if (enable) {
                                            Get.back();
                                            _Stores_openBottomSheetTableStore(_,
                                                item, index, currentStoreList);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(height: 15),
                            BootstrapRow(
                              children: <BootstrapCol>[
                                BootstrapCol(
                                  sizes: 'col-12',
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: themeApp.colorGenericBox,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(height: 15),
                            BootstrapRow(
                              children: <BootstrapCol>[
                                BootstrapCol(
                                  sizes: 'col-6',
                                  child: Container(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text(atenderHoyStr,
                                              style:
                                                  themeApp.text18boldBlack600),
                                        )),
                                  ),
                                ),
                                BootstrapCol(
                                  sizes: 'col-6',
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SwitchListTile(
                                        activeColor: themeApp.colorPrimaryBlue,
                                        contentPadding: EdgeInsets.all(0),
                                        value: item.forToday,
                                        onChanged: (v) {
                                          setState(() {
                                            _enable(v);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(height: 15),
                            BootstrapRow(
                              children: <BootstrapCol>[
                                BootstrapCol(
                                  sizes: 'col-2',
                                  child: Container(),
                                ),
                                BootstrapCol(
                                  sizes: 'col-4',
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Select(
                                        label: deStr,
                                        value: enable ? item.startTime : '',
                                        dataList: enable ? _hours : _hoursEmpty,
                                        validator: (value) =>
                                            value == null ? requeridoStr : null,
                                        onChange: (v) {
                                          setState(() {
                                            enable ? _startTime(v) : null;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                BootstrapCol(
                                  sizes: 'col-4',
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Select(
                                        label: aStr,
                                        value: enable ? item.endTime : '',
                                        dataList: enable ? _hours : _hoursEmpty,
                                        validator: (value) =>
                                            value == null ? requeridoStr : null,
                                        onChange: (v) {
                                          setState(() {
                                            enable ? _endTime(v) : null;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                BootstrapCol(
                                  sizes: 'col-2',
                                  child: Container(),
                                ),
                                BootstrapCol(
                                  sizes: 'col-12',
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                          _error == true
                                              ? seleccioneHorasCorrectasStr
                                              : '',
                                          style:
                                              themeApp.textFloatinglabelError),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //color: Colors.blue,
                    child: Column(children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 30),
                              BootstrapRow(
                                children: <BootstrapCol>[
                                  BootstrapCol(
                                    sizes: 'col-12',
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: themeApp.colorGenericBox,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(height: 15),
                              BootstrapRow(
                                children: <BootstrapCol>[
                                  BootstrapCol(
                                    sizes: 'col-6',
                                    child: Text(
                                      nuevaAsignacionStr,
                                      style: themeApp.text16400Black,
                                    ),
                                  ),
                                  BootstrapCol(
                                    sizes: 'col-6',
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        enable ? item.textTime : '',
                                        style: themeApp.text16400Blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(height: 20),
                              BootstrapRow(
                                children: <BootstrapCol>[
                                  BootstrapCol(
                                    sizes: 'col-12',
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Button1(
                                        label: confirmarCambiosStr,
                                        style: themeApp.text18boldWhite,
                                        background: submit == true
                                            ? themeApp.colorPrimaryBlue
                                            : themeApp.colorButtonDisable,
                                        onPressed: () {
                                          setState(() {
                                            submit
                                                ? _submit(
                                                    index, currentStoreList)
                                                : null;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          )
                        ],
                      )
                    ]),
                  ),
                ]),
              ]),
            ),
          ),
        );
      }),
      backgroundColor: Colors.white,
      elevation: 0,
      enableDrag: false,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(responsiveApp.buttonRadius),
          topLeft: Radius.circular(responsiveApp.buttonRadius),
        ),
      ),
    );
  }

  void openBottomSheetExitStore(BuildContext _,
      ClientsListByRouteSupervisor item, int index, String currentStoreList) {
    ResponsiveApp responsiveApp = ResponsiveApp(_);
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(gestionarTiendaStr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xFF000000),
                                  )),
                            ),
                          ),
                          Container(
                            width: 30.0,
                            height: 30.0,
                            child: IconButton(
                              icon: Icon(Icons.clear_rounded),
                              onPressed: () {
                                Get.back();
                                _Stores_openBottomSheetFormStore(
                                    _, item, index, currentStoreList);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: ListView(
                    children: [
                      Container(
                        //height: 120,
                        //width: 120,
                        child: Center(
                          child: SvgPicture.asset(Constant.ICON_ALERTS),
                        ),
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            questionSalirStr,
                            style: themeApp.textSubheader,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            cambioSalirStr,
                            style: themeApp.textParagraph,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )),
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: responsiveApp
                            .edgeInsetsApp!.onlyLargeLeftRightEdgeInsets,
                        child: Button2(
                          title: seguirEditandoStr,
                          color: themeApp.colorPrimaryBlue,
                          onPressed: () {
                            Get.back();
                            _Stores_openBottomSheetFormStore(
                                _, item, index, currentStoreList);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: (() => Get.back()),
                            child: Text(
                              titleSalirStr,
                              style: themeApp.textCTAButtonlink,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      enableDrag: false,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(responsiveApp.buttonRadius),
          topLeft: Radius.circular(responsiveApp.buttonRadius),
        ),
      ),
    );
  }

  setManageClientOutFrequencyBySupervisor(BuildContext _) async {
    List<ClientsListByRouteSupervisor> itemsStoresToSend = [];
    List<ClientsListByRouteSupervisor> itemsStoresToSendAll = [];
    List<ClientsListByRouteSupervisor> itemsStoresToSendToday = [];
    String dataClientsListByRouteSupervisor =
        Utils.prefs.dataClientsListByRouteSupervisor;
    if (dataClientsListByRouteSupervisor.isNotEmpty) {
      dynamic jsonData = jsonDecode(dataClientsListByRouteSupervisor);
      itemsStoresToSendAll = (jsonData as List)
          .map((i) => ClientsListByRouteSupervisor.fromLocalJson(i))
          .toList();
    }
    String dataClientsListByRouteSupervisorToday =
        Utils.prefs.dataClientsListByRouteSupervisorToday;
    if (dataClientsListByRouteSupervisorToday.isNotEmpty) {
      dynamic jsonData = jsonDecode(dataClientsListByRouteSupervisorToday);
      itemsStoresToSendToday = (jsonData as List)
          .map((i) => ClientsListByRouteSupervisor.fromLocalJson(i))
          .toList();
    }
    for (var data in itemsStoresToSendAll) {
      if (data.enviado == '0') {
        itemsStoresToSend.add(data);
      }
    }
    Utils.withoutSendingStores = false;
    for (var data in itemsStoresToSendToday) {
      if (data.enviado == '0') {
        itemsStoresToSend.add(data);
      }
    }
    if (itemsStoresToSend.length > 0) {
      Utils.withoutSendingStores = true;
    }
    if (await Utils.hasInternet()) {
      for (var item in itemsStoresToSend) {
        if (item.enviado == '0') {
          result = await Get.find<MainRepository>()
              .appManageClientOutFrequencyBySupervisor(
                  item.idClient.toString(),
                  item.idCellar.toString(),
                  item.anaqueleroIdAnaquelero.toString(),
                  item.startTime.toString(),
                  item.endTime.toString());

          ResponseCode response = result[Cnstds.KEY_RESPONSE];

          _code = response.code;
          if (_code == Cnstds.KEY_GST00000) {
            Utils.withoutSendingStores = false;
          } else {
            Get.snackbar(
              response.message,
              response.description,
              icon: Icon(Icons.error, color: Colors.red),
              borderRadius: 20,
              margin: EdgeInsets.all(15),
              isDismissible: true,
              dismissDirection: DismissDirection.horizontal,
              snackPosition: SnackPosition.TOP,
            );
            Utils.withoutSendingStores = true;
          }
        }
      }
    }
    update();
  }

  void _Stores_openBottomSheetTableStore(
      BuildContext _,
      ClientsListByRouteSupervisor item,
      int index,
      String currentStoreList) async {
    var mediaQuery = MediaQuery.of(_);
    Size size = mediaQuery.size;
    ResponsiveApp responsiveApp = ResponsiveApp(_);
    String anaqueleroNameAnaquelero = '';
    String stringSplit = item.anaqueleroAnaquelero.toString();
    if (stringSplit.trim().isNotEmpty) {
      List splitArray = stringSplit.split('-');
      anaqueleroNameAnaquelero = splitArray[1].toString().trim();
    }

    AnaquelerosToManage? selectedAnaqueleros = AnaquelerosToManage(
        id: item.anaqueleroIdAnaquelero, name: anaqueleroNameAnaquelero);

    _selectAnaqueleros(AnaquelerosToManage item) async {
      selectedAnaqueleros = item;
    }

    DataTableSource _LoadData = StoresAnaquelerosLoadData(
        context: _,
        itemsAnaqueleros: itemsAnaqueleros,
        selectAnaqueleros: _selectAnaqueleros,
        idUniqueSelected: item.anaqueleroIdAnaquelero.toString());
    List<DataColumn> columns = [
      DataColumn2(
        size: ColumnSize.SX,
        label: Text(''),
      ),
      DataColumn2(
        size: ColumnSize.S,
        label: Text(idStr, style: themeApp.text16400Blue),
        onSort: (columnIndex, ascending) => sortAnaqueleros<String>(
            (d) => d.id.toString(), columnIndex, ascending, _LoadData),
      ),
      DataColumn2(
        size: ColumnSize.L,
        label: Text(nombreStr, style: themeApp.text16400Blue),
        onSort: (columnIndex, ascending) => sortAnaqueleros<String>(
            (d) => d.name.toString(), columnIndex, ascending, _LoadData),
      ),
    ];

    bootstrapGridParameters(gutterSize: 10);
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: BootstrapContainer(fluid: true, children: [
            Column(
              children: [
                SizedBox(height: 20),
                BootstrapRow(
                  children: <BootstrapCol>[
                    BootstrapCol(
                      sizes: 'col-2',
                      child: Container(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: SvgPicture.asset(Constant.ICON_BACK),
                            onPressed: () {
                              Get.back();
                              _Stores_openBottomSheetFormStore(
                                  _, item, index, currentStoreList);
                            },
                          ),
                        ),
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-10',
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                            anaquelerosStr + itemsAnaqueleros.length.toString(),
                            style: themeApp.text20700Black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            BootstrapRow(
              children: <BootstrapCol>[
                BootstrapCol(
                  sizes: 'col-12',
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: size.height < 600 ? 180 : 280,
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: PaginatedDataTable2(
                                initialFirstRowIndex: 0,
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => themeApp.colorGenericBox),
                                border: TableBorder(
                                    horizontalInside: BorderSide(
                                        color: themeApp.colorBlue2Opacity,
                                        width: 1)),
                                onPageChanged: (rowIndex) {},
                                source: _LoadData,
                                columns: columns,
                                hidePaginator: true,
                                empty: EmptyTable(),
                                wrapInCard: false,
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-12',
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Button1(
                        label: confirmarCambiosStr,
                        style: themeApp.text18boldWhite,
                        background: themeApp.colorPrimaryBlue,
                        onPressed: () {
                          item.anaqueleroIdAnaquelero =
                              selectedAnaqueleros!.id.toString();
                          item.anaqueleroAnaquelero =
                              selectedAnaqueleros!.id.toString() +
                                  text_ +
                                  selectedAnaqueleros!.name.toString();
                          item.anaqueleroTypeAssign = reemplazoStr;
                          Get.back();
                          _Stores_openBottomSheetFormStore(
                              _, item, index, currentStoreList);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )
          ])),
      backgroundColor: Colors.white,
      elevation: 0,
      enableDrag: false,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(responsiveApp.buttonRadius),
          topLeft: Radius.circular(responsiveApp.buttonRadius),
        ),
      ),
    );
  }

  showStore(
      ClientsListByRouteSupervisor item, int index, String currentStoreList) {
    Get.to(
      () => StoreDetailPage(
          item, _Stores_openBottomSheetFormStore, index, currentStoreList),
      binding: StoresBinding(),
    );
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      setSubIndexPage
  Propósito:   Procedimiento que actualiza el subindexpage
  Entradas:    index: Valor de la subpágina a actualizar
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha          HU          Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU02      Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  setSubIndexPage(int index) {
    subIndexPage = index;
    update();
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      openBottomSheetClientOtherRoute
  Propósito:   Procedimiento que abre la ventana de dialogo para mostrar las otras rutas a las que pertenece la tienda
  Entradas:    _: BuildContext
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha          HU          Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU02.1    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  openBottomSheetClientOtherRoute(BuildContext _) {
    ResponsiveApp responsiveApp = ResponsiveApp(_);
    Get.bottomSheet(
      Padding(
        padding: responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding:
                  responsiveApp.edgeInsetsApp!.onlySmallLeftRightEdgeInsets,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(textOtrasRutas,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xFF000000),
                          )),
                    ),
                  ),
                  Container(
                    width: 30.0,
                    height: 30.0,
                    child: IconButton(
                      icon: Icon(Icons.clear_rounded),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: ListView.builder(
                    itemCount: itemsClientDetailOtherRoute.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return itemsClientDetailOtherRoute.length == 0
                          ? Container()
                          : Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                ViewAddressStore(
                                  address: itemsClientDetailOtherRoute[index]
                                      .route_show
                                      .toString(),
                                  detail: itemsClientDetailOtherRoute[index]
                                      .anaquelero
                                      .toString(),
                                  icon: Constant.ICON_ROUTE,
                                )
                              ],
                            );
                    }),
              ), //ShowListEvent()),
            ),
            SizedBox(height: 20),
            Padding(
              padding:
                  responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    textOtherRoute,
                    style: themeApp.textNote,
                  )),
            ),
            SizedBox(height: 20),
            Padding(
              padding:
                  responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Button2(
                  title: textAceptar,
                  color: themeApp.colorPrimaryBlue,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(responsiveApp.buttonRadius),
          topLeft: Radius.circular(responsiveApp.buttonRadius),
        ),
      ),
    );
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      isEditManageClient
  Propósito:   Función que valida si hubo alguna actualización en gestionar tienda
  Entradas:    NA
  Salida:      Boolean

  * Historia de Revisiones
  * Implementador                 Fecha         HU         Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU03    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  bool isEditManageClient() {
    return anaqueleroUpdate == true ||
        checkinUpdate == true ||
        checkoutUpdate == true;
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      openBottomSheetManageClient
  Propósito:   Procedimiento que abre la ventana de dialogo para gestionar la tienda
  Entradas:    _: BuildContext
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha         HU         Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU03    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  openBottomSheetManageClient(BuildContext _) {
    validateEnabledButton();
    ResponsiveApp responsiveApp = ResponsiveApp(_);
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: responsiveApp
                            .edgeInsetsApp!.onlySmallLeftRightEdgeInsets,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Text(gestionarTiendaStr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    )),
                              ),
                            ),
                            Container(
                              width: 30.0,
                              height: 30.0,
                              child: IconButton(
                                icon: Icon(Icons.clear_rounded),
                                onPressed: () {
                                  Get.back();
                                  if (isEditManageClient())
                                    openBottomSheetExitManageClient(_);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      child: ListView(
                    children: [
                      Padding(
                        padding: responsiveApp
                            .edgeInsetsApp!.onlySmallLeftRightEdgeInsets,
                        child: Row(
                          children: [
                            Container(
                              height: responsiveApp.setHeight(50),
                              width: responsiveApp.setWidth(50),
                              child: SvgPicture.asset(Constant.ICON_HAPPY_FACE),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      anaqueleroUpdate == true
                                          ? idUniqueSelectedTmp +
                                              ' - ' +
                                              nameUniqueSelectedTmp
                                          : itemClientDetailSup!.anaquelero
                                              .toString(),
                                      style: itemClientDetailSup!.anaquelero
                                                  .toString() !=
                                              textVacant
                                          ? themeApp.textParagraph14
                                          : themeApp
                                              .textParagraphSecondaryOrange,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      anaqueleroUpdate == true
                                          ? reemplazoStr +
                                              ' (' +
                                              hourDeSelect +
                                              ' a ' +
                                              hourASelect +
                                              ')'
                                          : itemClientDetailSup!
                                              .type_assign_anaq
                                              .toString(),
                                      style: anaqueleroUpdate == true
                                          ? themeApp.textNoteSecondaryBlue
                                          : itemClientDetailSup!
                                                  .type_assign_anaq
                                                  .toString()
                                                  .contains(reemplazoStr)
                                              ? themeApp.textNoteSecondaryBlue
                                              : themeApp.textNote,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: anaqueleroUpdate == true
                                  ? SvgPicture.asset(Constant.ICON_DOTS)
                                  : SvgPicture.asset(Constant.ICON_EDIT),
                              onPressed: () {
                                if (anaqueleroUpdate == true) {
                                  Get.dialog(
                                    Container(
                                        child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                          side: BorderSide(
                                              color: themeApp.colorGenericBox)),
                                      contentPadding: EdgeInsets.all(10.0),
                                      content: Container(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                anaqueleroUpdate = false;
                                                validateEnabledButton();
                                                setState(() {});
                                                Get.back();
                                              },
                                              child: Container(
                                                child: itemPopUp(
                                                    Constant.ICON_TRASH_BLUE,
                                                    restablecerStr),
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            Divider(
                                              color: themeApp.colorGenericBox,
                                            ),
                                            SizedBox(height: 2),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                Get.back();
                                                agendaOpenBottomSheetTableStore(
                                                    _);
                                              },
                                              child: Container(
                                                child: itemPopUp(
                                                    Constant.ICON_EDIT,
                                                    editarStr),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                  );
                                } else {
                                  if ((activeSwitch == true) &&
                                      (itemClientDetailSup!.status_id !=
                                          Constant.ID_STATUS_TERMINADA)) {
                                    Get.back();
                                    agendaOpenBottomSheetTableStore(_);
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: themeApp.colorGenericBox,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          child: SwitchListTile(
                            title: Text(
                              asistenciaStr,
                              style: themeApp.textSubheader,
                            ),
                            value: activeSwitch,
                            onChanged: (bool value) {
                              setState(() => activeSwitch = value);
                              updateValueSwitch();
                              validateEnabledButton();
                            },
                            activeTrackColor: themeApp.colorPrimaryBlue,
                            inactiveTrackColor: themeApp.colorGenericBox,
                          ),
                        ), //SwitchWidget(title: asistenciaStr),
                      ),
                      SizedBox(height: 15),
                      Activity(
                        type: textCheckin,
                        onPressed: () {
                          Get.back();
                          imageUpdate = false;
                          hourCheckinSelect = '';
                          minuteCheckinSelect = '';
                          update();
                          setCheckAttendance(textCheckin, _);
                        },
                        update: checkinUpdate,
                        widgetUpdate: checkinUpdate == true
                            ? Row(
                                children: [
                                  Text(
                                    supervisorStr,
                                    style: themeApp.textParagraph,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    hourCheckinSelect +
                                        ':' +
                                        minuteCheckinSelect,
                                    style: themeApp.textParagraphSecondaryBlue,
                                  )
                                ],
                              )
                            : Container(),
                      ),
                      SizedBox(height: 15),
                      Activity(
                        type: textComida,
                        update: false,
                        widgetUpdate: Container(),
                      ),
                      SizedBox(height: 15),
                      Activity(
                        type: textCheckout,
                        onPressed: () {
                          Get.back();
                          imageUpdate = false;
                          hourCheckoutSelect = '';
                          minuteCheckoutSelect = '';
                          update();
                          setCheckAttendance(textCheckout, _);
                        },
                        update: checkoutUpdate,
                        widgetUpdate: checkoutUpdate == true
                            ? Row(
                                children: [
                                  Text(
                                    supervisorStr,
                                    style: themeApp.textParagraph,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    hourCheckoutSelect +
                                        ':' +
                                        minuteCheckoutSelect,
                                    style: themeApp.textParagraphSecondaryBlue,
                                  )
                                ],
                              )
                            : Container(),
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: themeApp.colorGenericBox,
                      ),
                      Padding(
                        padding: responsiveApp
                            .edgeInsetsApp!.onlySmallLeftRightEdgeInsets,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                horasActividadStr,
                                style: themeApp.textParagraph,
                              ),
                            ),
                            Text(
                              itemClientDetailSup!.activity_hours_show
                                  .toString(),
                              style: themeApp.textParagraph,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              itemClientDetailSup!.diff_activity_hours_show
                                  .toString(),
                              style: themeApp.textParagraphSecondaryBlue,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
                ),
                Container(
                    child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Padding(
                      padding: responsiveApp
                          .edgeInsetsApp!.onlyLargeLeftRightEdgeInsets,
                      child: Button2(
                        title: guardarCambiosStr,
                        color: enabledButton
                            ? themeApp.colorPrimaryBlue
                            : themeApp.colorButtonDisable,
                        onPressed: () {
                          if (enabledButton) saveChangeManageClient();
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ))
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      isDismissible: false,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(responsiveApp.buttonRadius),
          topLeft: Radius.circular(responsiveApp.buttonRadius),
        ),
      ),
    );
  }

  openPokemonList(BuildContext _) {
    Get.dialog(
      Container(
          height: 400,
          child: AlertDialog(
            contentPadding: EdgeInsets.all(10.0),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      child:
                          itemPopUp(Constant.ICON_TRASH_BLUE, restablecerStr),
                    ),
                  ),
                  SizedBox(height: 2),
                  Divider(
                    color: themeApp.colorGenericBox,
                  ),
                  SizedBox(height: 2),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.back();
                      agendaOpenBottomSheetTableStore(_);
                    },
                    child: Container(
                      child: itemPopUp(Constant.ICON_EDIT, editarStr),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  /* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      setCheckAttendance
  Propósito:   Procedimiento que abre la ventana de dialogo para dar asistencia de inicio o termino de tareas
  Entradas:    type: Párametro que indica si es tipo checkin o checkout
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha         HU         Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU03    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  setCheckAttendance(String type, BuildContext _) {
    ResponsiveApp responsiveApp = ResponsiveApp(_);
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: responsiveApp
                      .edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          IconButton(
                            iconSize: 50,
                            icon: Image.asset(Constant.ICON_BACK_PNG),
                            onPressed: () {
                              Get.back();
                              openBottomSheetManageClient(_);
                            },
                          ),
                          Text(
                            type == textCheckin ? checkinStr : checkoutStr,
                            style: themeApp.textHeaderH2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView(children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: responsiveApp
                          .edgeInsetsApp!.onlyLargeLeftRightEdgeInsets,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              horaEstimadaStr,
                              style: themeApp.textParagraph,
                            ),
                          ),
                          Text(
                            type == textCheckin
                                ? itemClientDetailSup!.start_time.toString()
                                : itemClientDetailSup!.end_time.toString(),
                            style: themeApp.textParagraphSecondaryBlue,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: themeApp.colorGenericBox,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BootstrapContainer(fluid: true, children: [
                      Column(
                        children: [
                          SizedBox(height: 15),
                          BootstrapRow(
                            children: <BootstrapCol>[
                              BootstrapCol(
                                sizes: 'col-2',
                                child: Container(),
                              ),
                              BootstrapCol(
                                sizes: 'col-4',
                                child: Select(
                                  label: horaStr,
                                  value: type == textCheckin
                                      ? hourCheckinSelect
                                      : hourCheckoutSelect,
                                  dataList: hoursList,
                                  onChange: (v) {
                                    type == textCheckin
                                        ? hourCheckinSelect = v
                                        : hourCheckoutSelect = v;
                                    update();
                                    setState(() {});
                                  },
                                ),
                              ),
                              BootstrapCol(
                                sizes: 'col-4',
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Select(
                                      label: minutosStr,
                                      value: type == textCheckin
                                          ? minuteCheckinSelect
                                          : minuteCheckoutSelect,
                                      dataList: minutesList,
                                      onChange: (v) {
                                        type == textCheckin
                                            ? minuteCheckinSelect = v
                                            : minuteCheckoutSelect = v;
                                        update();
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              BootstrapCol(
                                sizes: 'col-2',
                                child: Container(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          type == textCheckin
                              ? hourCheckinSelect + ':' + minuteCheckinSelect
                              : hourCheckoutSelect + ':' + minuteCheckoutSelect,
                          style: themeApp.textHeaderH2SecondaryBlue,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ]),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: responsiveApp
                          .edgeInsetsApp!.onlyLargeLeftRightEdgeInsets,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Button2(
                          title: confirmarCambiosStr,
                          color: //imageUpdate == true &&  // Valida la captura de la evidencia
                              (type == textCheckin
                                      ? hourCheckinSelect != '' &&
                                          minuteCheckinSelect != ''
                                      : hourCheckoutSelect != '' &&
                                          minuteCheckoutSelect != '')
                                  ? themeApp.colorPrimaryBlue
                                  : themeApp.colorButtonDisable,
                          onPressed: () {
                            type == textCheckin
                                ? checkinUpdate = true
                                : checkoutUpdate = true;
                            Get.back();
                            openBottomSheetManageClient(_);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(responsiveApp.buttonRadius),
          topLeft: Radius.circular(responsiveApp.buttonRadius),
        ),
      ),
    );
  }

  /* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      opcionesFileImage
  Propósito:   Procedimiento que abre la ventana de dialogo para seleccionar la opción de la cámara o la galeria de archivos
  Entradas:    type: Párametro que indica si es tipo checkin o checkout
               _: BuildContext
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha         HU         Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU04    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  opcionesFileImage(String type, BuildContext _) {
    Get.bottomSheet(
      Container(
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            )),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () async {
                await selImagen(1);
                imageUpdate = b64Image != '';
                update();
                Get.back();
                setCheckAttendance(type, _);
              },
              child: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: themeApp.colorPrimaryBlue,
                    ),
                    SizedBox(
                      width: 13.0,
                    ),
                    Expanded(
                      child: Text(tomarFotoStr, style: themeApp.textParagraph),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await selImagen(2);
                imageUpdate = b64Image != '';
                update();
                Get.back();
                setCheckAttendance(type, _);
              },
              child: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(Icons.photo_library, color: themeApp.colorPrimaryBlue),
                    SizedBox(
                      width: 13.0,
                    ),
                    Expanded(
                      child: Text(
                        seleccionarFotoStr,
                        style: themeApp.textParagraph,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      selImagen
  Propósito:   Procedimiento selecciona la imagen ya sea por la cámara o por la galeria de imágenes
  Entradas:    option: Párametro que indica si la seleccón de la imagen fué por la cámara o por la galería de imágenes
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha         HU         Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU04    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  selImagen(int option) async {
    b64Image = '';
    dateb64Image = '';
    timeb64Image = '';
    fileImage = (await Utils.seleccionaImagen(option))!;
    if (fileImage == null) return;
    final bytes = fileImage!.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    String thumbnail = basename(fileImage!.path);
    var arr = thumbnail.split('.');
    var formato = Utils.getFormatoImage(arr[1]);
    b64Image = formato + base64Image;
    dateb64Image = Utils.getDateCurrentPicture();
    timeb64Image = Utils.getTimeCurrentPicture();
    update();
  }

  /* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      openBottomSheetExitManageClient
  Propósito:   Procedimiento que abre la ventana de dialogo para confirmar la salida desde gestionar tienda
  Entradas:    _: BuildContext
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha         HU         Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU03    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  openBottomSheetExitManageClient(BuildContext _) {
    ResponsiveApp responsiveApp = ResponsiveApp(_);
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(gestionarTiendaStr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xFF000000),
                                  )),
                            ),
                          ),
                          Container(
                            width: 30.0,
                            height: 30.0,
                            child: IconButton(
                              icon: Icon(Icons.clear_rounded),
                              onPressed: () {
                                Get.back();
                                openBottomSheetManageClient(_);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: ListView(
                    children: [
                      Container(
                        child: Center(
                          child: SvgPicture.asset(Constant.ICON_ALERTS),
                        ),
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            questionSalirStr,
                            style: themeApp.textSubheader,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            cambioSalirStr,
                            style: themeApp.textParagraph,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )),
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: responsiveApp
                            .edgeInsetsApp!.onlyLargeLeftRightEdgeInsets,
                        child: Button2(
                          title: seguirEditandoStr,
                          color: themeApp.colorPrimaryBlue,
                          onPressed: () {
                            Get.back();
                            openBottomSheetManageClient(_);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: (() => Get.back()),
                            child: Text(
                              titleSalirStr,
                              style: themeApp.textCTAButtonlink,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(responsiveApp.buttonRadius),
          topLeft: Radius.circular(responsiveApp.buttonRadius),
        ),
      ),
    );
  }

  /* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      _updateUniqueSelectedTmp
  Propósito:   Procedimiento que actualiza la selección del anaquelero de la lista 
  Entradas:    idUniqueSelected: Id del anaquelero seleccionado
               nameUniqueSelected: Nombre del anaquelero seleccionado
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha         HU           Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU03.1    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  _updateUniqueSelectedTmp(
      String idUniqueSelected, String nameUniqueSelected) async {
    idUniqueSelectedTmp = idUniqueSelected;
    nameUniqueSelectedTmp = nameUniqueSelected;
    update();
  }

  /* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      agendaOpenBottomSheetTableStore
  Propósito:   Procedimiento que abre la ventana de dialogo con el listado de anaqueleros para seleccionar el reemplazo
  Entradas:    _: BuildContext
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha           HU         Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU03.1    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  agendaOpenBottomSheetTableStore(BuildContext _) async {
    ResponsiveApp responsiveApp = ResponsiveApp(_);

    if (listAnaqueleros.length > 0) {
      idUniqueSelectedTmp = listAnaqueleros[0].id.toString();
      nameUniqueSelectedTmp = listAnaqueleros[0].name.toString();
    }

    DataTableSource _LoadData = DiaryAnaquelerosLoadData(
      context: _,
      itemsAnaqueleros: listAnaqueleros,
      idUniqueSelected: idUniqueSelectedTmp,
      nameUniqueSelected: nameUniqueSelectedTmp,
      updateUniqueSelectedTmp: _updateUniqueSelectedTmp,
    );
    List<DataColumn> columns = [
      DataColumn2(
        size: ColumnSize.SX,
        label: Text(''),
      ),
      DataColumn2(
        size: ColumnSize.S,
        label: Text(idStr, style: themeApp.text16400Blue),
        onSort: (columnIndex, ascending) => sortAnaqueleros<String>(
            (d) => d.id.toString(), columnIndex, ascending, _LoadData),
      ),
      DataColumn2(
        size: ColumnSize.L,
        label: Text(nombreStr, style: themeApp.text16400Blue),
        onSort: (columnIndex, ascending) => sortAnaqueleros<String>(
            (d) => d.name.toString(), columnIndex, ascending, _LoadData),
      ),
    ];

    bootstrapGridParameters(gutterSize: 10);
    Get.bottomSheet(
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              child: BootstrapRow(
                children: <BootstrapCol>[
                  BootstrapCol(
                    sizes: 'col-2',
                    child: Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          iconSize: 30,
                          icon: Image.asset(Constant.ICON_BACK_PNG),
                          onPressed: () {
                            Get.back();
                            openBottomSheetManageClient(_);
                          },
                        ),
                      ),
                    ),
                  ),
                  BootstrapCol(
                    sizes: 'col-10',
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                          anaquelerosStr + listAnaqueleros.length.toString(),
                          style: themeApp.text20700Black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: BootstrapRow(
                  children: <BootstrapCol>[
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            height: 300,
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  child: PaginatedDataTable2(
                                    initialFirstRowIndex: 0,
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) =>
                                                themeApp.colorGenericBox),
                                    border: TableBorder(
                                        horizontalInside: BorderSide(
                                            color: themeApp.colorBlue2Opacity,
                                            width: 1)),
                                    onPageChanged: (rowIndex) {},
                                    source: _LoadData,
                                    columns: columns,
                                    hidePaginator: true,
                                    empty: EmptyTable(),
                                    wrapInCard: false,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: BootstrapRow(
                children: <BootstrapCol>[
                  BootstrapCol(
                    sizes: 'col-12',
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Button1(
                          label: siguienteStr,
                          style: themeApp.text18boldWhite,
                          background: themeApp.colorPrimaryBlue,
                          onPressed: () {
                            Get.back();
                            openBottomSheetReassignment(_);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      isDismissible: false,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(responsiveApp.buttonRadius),
          topLeft: Radius.circular(responsiveApp.buttonRadius),
        ),
      ),
    );
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      openBottomSheetReassignment
  Propósito:   Procedimiento que abre la ventana de dialogo para completar los datos de la reasignación del anaquelero
  Entradas:    _: BuildContext
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha           HU         Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU03.1    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  openBottomSheetReassignment(BuildContext _) {
    hourDeSelect = '';
    hourASelect = '';
    update();
    ResponsiveApp responsiveApp = ResponsiveApp(_);
    if (itemClientDetailSup != null) {
      Get.bottomSheet(
        StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding:
                  responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: responsiveApp
                              .edgeInsetsApp!.onlySmallLeftRightEdgeInsets,
                          child: Row(
                            children: [
                              IconButton(
                                iconSize: 50,
                                icon: Image.asset(Constant.ICON_BACK_PNG),
                                onPressed: () {
                                  Get.back();
                                  agendaOpenBottomSheetTableStore(_);
                                },
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(reasignacionStr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: responsiveApp
                              .edgeInsetsApp!.onlySmallLeftRightEdgeInsets,
                          child: Row(
                            children: [
                              Container(
                                height: responsiveApp.setHeight(50),
                                width: responsiveApp.setWidth(50),
                                child:
                                    SvgPicture.asset(Constant.ICON_HAPPY_FACE),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        idUniqueSelectedTmp +
                                            ' - ' +
                                            nameUniqueSelectedTmp,
                                        style: themeApp.textParagraph14,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        reemplazo24Str,
                                        style: themeApp.textNoteSecondaryBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(
                          color: themeApp.colorGenericBox,
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: responsiveApp
                              .edgeInsetsApp!.onlySmallLeftRightEdgeInsets,
                          child: Row(
                            children: [
                              Text(
                                horarioServicioStr,
                                style: themeApp.textSubheader,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            Utils.getFechaHoy(),
                            style: themeApp.textParagraph,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        BootstrapContainer(fluid: true, children: [
                          Column(
                            children: [
                              SizedBox(height: 15),
                              BootstrapRow(
                                children: <BootstrapCol>[
                                  BootstrapCol(
                                    sizes: 'col-2',
                                    child: Container(),
                                  ),
                                  BootstrapCol(
                                    sizes: 'col-4',
                                    child: Select(
                                      label: 'De',
                                      value: hourDeSelect,
                                      dataList: _hours,
                                      onChange: (v) {
                                        hourDeSelect = v;
                                        update();
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  BootstrapCol(
                                    sizes: 'col-4',
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Select(
                                          label: 'A',
                                          value: hourASelect,
                                          dataList: _hours,
                                          onChange: (v) {
                                            hourASelect = v;
                                            update();
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  BootstrapCol(
                                    sizes: 'col-2',
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              hourDeSelect + ' - ' + hourASelect,
                              style: themeApp.textHeaderH2SecondaryBlue,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )),
                  Container(
                    child: Column(children: [
                      Padding(
                        padding: responsiveApp
                            .edgeInsetsApp!.onlyLargeLeftRightEdgeInsets,
                        child: Button2(
                          title: agregaAnaqueleroStr,
                          color: (hourDeSelect != '' && hourASelect != '') &&
                                  validateSchedule()
                              ? themeApp.colorPrimaryBlue
                              : themeApp.colorButtonDisable,
                          onPressed: () {
                            if (validateSchedule()) {
                              anaqueleroUpdate = true;
                              update();
                              Get.back();
                              openBottomSheetManageClient(_);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      )
                    ]),
                  ),
                ],
              ),
            );
          },
        ),
        backgroundColor: Colors.white,
        isDismissible: false,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(responsiveApp.buttonRadius),
            topLeft: Radius.circular(responsiveApp.buttonRadius),
          ),
        ),
      );
    }
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      validateSchedule
  Propósito:   Función que valida la hora inicial vs la hora final
  Entradas:    NA
  Salida:      boolean

  * Historia de Revisiones
  * Implementador                 Fecha           HU         Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU03.1    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  bool validateSchedule() {
    return int.parse(hourDeSelect.substring(0, 2)) <
        int.parse(hourASelect.substring(0, 2));
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      itemPopUp
  Propósito:   Función que regresa un widget para el popup menu
  Entradas:    txtIcon: Nombre del icono a mostrar
               txtTitle: Texto de la etiqueta a mostrar como titulo
  Salida:      Widget

  * Historia de Revisiones
  * Implementador                 Fecha           HU         Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU03    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  Widget itemPopUp(String txtIcon, txtTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              child: SvgPicture.asset(txtIcon),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              txtTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      validateEnabledButton
  Propósito:   Procedimiento que actualiza la variable enabledButton que a su vez valida el botón de guardar cambios
  Entradas:    NA
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha           HU         Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        25/07/2022   [SUP] HU03    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  validateEnabledButton() {
    bool checkAsistencia = false;
    bool checkAnaquelero = false;
    if (hourCheckinSelect.isEmpty) hourCheckinSelect = '0';
    if (hourCheckoutSelect.isEmpty) hourCheckoutSelect = '0';
    if (int.parse(hourCheckinSelect) > 0 && int.parse(hourCheckoutSelect) > 0) {
      if (int.parse(hourCheckinSelect + minuteCheckinSelect) <
          int.parse(hourCheckoutSelect + minuteCheckoutSelect))
        checkAsistencia = true;
    } else {
      checkAsistencia = (int.parse(hourCheckinSelect) > 0) ||
          (int.parse(hourCheckoutSelect) > 0);
    }
    if (anaqueleroUpdate) {
      checkAnaquelero = true;
    } else if (itemClientDetailSup!.anaquelero.toString() != textVacant) {
      checkAnaquelero = true;
    }

    if (checkAsistencia) {
      enabledButton = checkAnaquelero;
    } else
      enabledButton = checkAnaquelero;

    update();
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      updateValueSwitch
  Propósito:   Procedimiento que limpia la información generada por los registros de asistencia
  Entradas:    NA
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha           HU         Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        25/07/2022   [SUP] HU03    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  updateValueSwitch() async {
    hourCheckinSelect = '';
    minuteCheckinSelect = '';
    hourCheckoutSelect = '';
    minuteCheckoutSelect = '';
    checkinUpdate = false;
    checkoutUpdate = false;
    update();
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      saveChangeManageClient
  Propósito:   Evento que guarda los cambios de gestionar tienda en la agenda del supervisor
  Entradas:    NA
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha          HU          Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        01/08/2022   [SUP] HU04      Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  saveChangeManageClient() async {
    bool succesAttendance = false;
    bool succesReassignment = false;
    String strCheckinTime = '';
    String strCheckoutTime = '';
    String deviceGTM = '';

    if (anaqueleroUpdate) {
      succesReassignment = true;
      if (await Utils.hasInternet()) {
        result = await Get.find<MainRepository>()
            .appReassignReplacementAnaquelero(
                itemClientDetailSup!.id_client_route.toString(),
                idUniqueSelectedTmp,
                hourDeSelect,
                hourASelect);
        if (result.length > 0) {
          ResponseCode response = result[Cnstds.KEY_RESPONSE];
          if (response.code != Cnstds.KEY_GST00000) {
            succesReassignment = false;
            Utils.snackErrorMessagge('Error', response.message);
          }
        } else {
          succesReassignment = false;
          Utils.snackErrorMessagge('Error', errorEndPointServer);
        }
      } //else {
      itemClientDetailSup!.id_anaquelero = idUniqueSelectedTmp;
      itemClientDetailSup!.anaquelero =
          idUniqueSelectedTmp + ' - ' + nameUniqueSelectedTmp;
      itemClientDetailSup!.start_time = hourDeSelect;
      itemClientDetailSup!.end_time = hourASelect;
      itemClientDetailSup!.time_show = hourDeSelect + ' - ' + hourASelect;
      itemClientDetailSup!.id_team_type = Constant.ID_TEAM_TYPE_REEMPLAZO;
      itemClientDetailSup!.team_type = reemplazoStr;
      Map<String, dynamic>? itemClientDetailSupMap =
          itemClientDetailSup!.toJson(itemClientDetailSup!);

      String jsonString = jsonEncode(itemClientDetailSupMap);
      await Get.find<MainRepository>().reassignReplacementAnaqueleroDB(
          itemClientDetailSup!.client_id.toString(),
          itemClientDetailSup!.cellar_id.toString(),
          itemClientDetailSup!.id_client_route.toString(),
          jsonString);
      //}
    } else
      succesReassignment = true;

    if (checkinUpdate || checkoutUpdate) {
      deviceGTM = Utils.getTimeZone();
      if (checkinUpdate) {
        strCheckinTime = hourCheckinSelect + ':' + minuteCheckinSelect;
        strCheckinTime = Utils.getChcekToDateTimeToUTC(strCheckinTime);
      }
      if (checkoutUpdate) {
        strCheckoutTime = hourCheckoutSelect + ':' + minuteCheckoutSelect;
        strCheckoutTime = Utils.getChcekToDateTimeToUTC(strCheckoutTime);
      }
      if (await Utils.hasInternet()) {
        result = await Get.find<MainRepository>().appMarkAssistanceBySupervisor(
            itemClientDetailSup!.id_client_route.toString(),
            anaqueleroUpdate
                ? idUniqueSelectedTmp
                : itemClientDetailSup!.id_anaquelero,
            strCheckinTime,
            strCheckoutTime,
            deviceGTM);
        if (result.length > 0) {
          ResponseCode response = result[Cnstds.KEY_RESPONSE];
          if (response.code != Cnstds.KEY_GST00000) {
            succesAttendance = false;
            Utils.snackErrorMessagge('Error', response.message);
          } else {
            succesAttendance = true;
          }
        } else {
          succesAttendance = false;
          Utils.snackErrorMessagge('Error', errorEndPointServer);
        }
      } //else {
      succesAttendance = true;
      if (anaqueleroUpdate) {
        itemClientDetailSup!.id_anaquelero = idUniqueSelectedTmp;
        itemClientDetailSup!.anaquelero =
            idUniqueSelectedTmp + ' - ' + nameUniqueSelectedTmp;
      }
      if (checkinUpdate) {
        itemClientDetailSup!.status_id = Constant.ID_STATUS_ENCURSO;
        itemClientDetailSup!.status_name = Constant.NAME_STATUS_ENCURSO;
        itemClientDetailSup!.status_color = Constant.COLOR_STATUS_ENCURSO;
        Checkin? _checkin = Checkin(
            time_start: strCheckinTime,
            diff: '',
            distance: supervisorStr,
            color: '');
        itemClientDetailSup!.checkin = _checkin;
      }
      if (checkoutUpdate) {
        itemClientDetailSup!.status_id = Constant.ID_STATUS_TERMINADA;
        itemClientDetailSup!.status_name = Constant.NAME_STATUS_TERMINADA;
        itemClientDetailSup!.status_color = Constant.COLOR_STATUS_TERMINADA;
        Checkout? _checkout = Checkout(
            time_start: strCheckoutTime,
            diff: '',
            distance: supervisorStr,
            color: '');
        itemClientDetailSup!.checkout = _checkout;
      }
      Map<String, dynamic>? itemClientDetailSupMap =
          itemClientDetailSup!.toJson(itemClientDetailSup!);

      String jsonString = jsonEncode(itemClientDetailSupMap);
      await Get.find<MainRepository>().markAssistanceBySupervisorDB(
          itemClientDetailSup!.client_id.toString(),
          itemClientDetailSup!.cellar_id.toString(),
          itemClientDetailSup!.id_client_route.toString(),
          jsonString);
      //}
    } else
      succesAttendance = true;

    if (succesAttendance && succesReassignment) {
      itemsRouteSup[indexRouteSupCurrent]
          .diary_client_list![indexDiaryClientCurrent]
          .start_time = itemClientDetailSup!.start_time;
      itemsRouteSup[indexRouteSupCurrent]
          .diary_client_list![indexDiaryClientCurrent]
          .end_time = itemClientDetailSup!.end_time;
      itemsRouteSup[indexRouteSupCurrent]
          .diary_client_list![indexDiaryClientCurrent]
          .id_status = itemClientDetailSup!.status_id;
      itemsRouteSup[indexRouteSupCurrent]
          .diary_client_list![indexDiaryClientCurrent]
          .name_status = itemClientDetailSup!.status_name;
      itemsRouteSup[indexRouteSupCurrent]
          .diary_client_list![indexDiaryClientCurrent]
          .color_status = itemClientDetailSup!.status_color;
      // Guardar con Getstorage permanente
      List<Map<String, dynamic>>? routeSupMap =
          itemsRouteSup.map((i) => i.toJson(i)).toList();
      String jsonString = jsonEncode(routeSupMap);
      Utils.prefs.routeSup = jsonString;
      //

      // Esta actualización es para el listado en teams
      if (indexPage == 2 && subIndexPage == 2) {
        if (teamRadioVal == -1) {
          itemsTeams
              .attendance_list![indexTeamAnaquelero]
              .details![indexTeamCurrentDetails]
              .status_id = itemClientDetailSup!.status_id;
          itemsTeams
              .attendance_list![indexTeamAnaquelero]
              .details![indexTeamCurrentDetails]
              .status_desc = itemClientDetailSup!.status_name;
          itemsTeams
              .attendance_list![indexTeamAnaquelero]
              .details![indexTeamCurrentDetails]
              .status_color = itemClientDetailSup!.status_color;
        } else {
          itemsTeams
              .absence_list![indexTeamAnaquelero]
              .details![indexTeamCurrentDetails]
              .status_id = itemClientDetailSup!.status_id;
          itemsTeams
              .absence_list![indexTeamAnaquelero]
              .details![indexTeamCurrentDetails]
              .status_desc = itemClientDetailSup!.status_name;
          itemsTeams
              .absence_list![indexTeamAnaquelero]
              .details![indexTeamCurrentDetails]
              .status_color = itemClientDetailSup!.status_color;
        }
        teamCurrent.details![indexTeamCurrentDetails].status_id =
            itemClientDetailSup!.status_id;
        teamCurrent.details![indexTeamCurrentDetails].status_desc =
            itemClientDetailSup!.status_name;
        teamCurrent.details![indexTeamCurrentDetails].status_color =
            itemClientDetailSup!.status_color;
        update();
      }

      // Esta actualización es para el listado en tiendas
      if (indexPage == 0 && subIndexPage == 1) {
        itemsStores[indexStoreCurrentDetails].idStatus =
            itemClientDetailSup!.status_id;
        itemsStores[indexStoreCurrentDetails].nameStatus =
            itemClientDetailSup!.status_name;
        itemsStores[indexStoreCurrentDetails].colorStatus =
            itemClientDetailSup!.status_color;
        update();
      }

      Get.back();
      updateValueSwitch();
      if (await Utils.hasInternet()) {
        await loadStoreDetailSup();
      } else {
        Utils.withoutSending =
            await Get.find<MainRepository>().pendingShippingAgenda();
      }
      isDetailUpdate = true;
      update();
    }
  }

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      checkPendingShippingAgenda
  Propósito:   Procedimiento que actualiza la información local a la nube
  Entradas:    NA
  Salida:      NA

  * Historia de Revisiones
  * Implementador                 Fecha          HU          Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        01/08/2022   [SUP] HU04      Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
  checkPendingShippingAgenda() async {
    bool pendiente = await Get.find<MainRepository>().pendingShippingAgenda();
    if (pendiente) {
      List<ClientDetailSupLocal> list = await Get.find<MainRepository>()
          .getListClientDetailSupLocalSinEnviar();
      for (var item in list) {
        String? valor = item.content;
        if (valor!.isNotEmpty) {
          dynamic jsonData = jsonDecode(valor);
          ClientDetailSup data = ClientDetailSup.clientDetailSupfromJson(
              json: jsonData, source: noapiStr);
          if (item.enviadoAnaquelero == 0) {
            try {
              await Get.find<MainRepository>().appReassignReplacementAnaquelero(
                  data.id_client_route.toString(),
                  data.id_anaquelero,
                  data.start_time,
                  data.end_time);
            } catch (e) {
              print(e);
            }
          }
          if (item.enviadoAsistencia == 0) {
            try {
              String strCheckinTime = '';
              String strCheckoutTime = '';
              String deviceGTM = Utils.getTimeZone();
              if (data.checkin != null) {
                strCheckinTime = data.checkin!.time_start.toString();
              }
              if (data.checkout != null) {
                strCheckoutTime = data.checkout!.time_start.toString();
              }
              await Get.find<MainRepository>().appMarkAssistanceBySupervisor(
                  data.id_client_route.toString(),
                  data.id_anaquelero.toString(),
                  strCheckinTime,
                  strCheckoutTime,
                  deviceGTM);
            } catch (e) {
              print(e);
            }
          }
          await Get.find<MainRepository>().updateClientDetailSupLocal(
              item.id_client.toString(),
              item.id_cellar.toString(),
              item.id_client_route.toString(),
              item.content);
        }
      }
    }
  }

  dropDetailStoreSupLocal() async {
    await Get.find<MainRepository>().dropClientDetailSupLocal();
    await Get.find<MainRepository>().dropClientDetailOtherRouteLocal();
    await Get.find<MainRepository>().dropAnaquelerosToManageClientLocal();
  }

  getDetailStoreSupLocal() async {
    ResponseCode response;
    ClientDetailSup _itemClientDetailSup;
    List<ClientDetailOtherRoute> _itemsClientDetailOtherRoute;
    List<AnaquelerosToManage> _itemsAnaquelerosToManage;
    String _id_client;
    String _id_cellar;
    String _id_client_route;

    for (var item in itemsRouteSupPaginator) {
      int len = item.diary_client_list!.length;
      String _id_route = item.id_route ?? '0';
      for (int i = 0; i <= len - 1; i++) {
        _id_client = item.diary_client_list![i].id_client ?? '0';
        _id_cellar = item.diary_client_list![i].id_cellar ?? '0';
        _id_client_route = item.diary_client_list![i].id_client_route ?? '0';

        // Se obtiene el detalle de cada tienda
        result = await Get.find<MainRepository>()
            .getAppClientDetailsBySupervisor(
                _id_route, _id_client, _id_cellar, _id_client_route);
        if (result.length > 0) {
          response = result[Cnstds.KEY_RESPONSE];
          _code = response.code;
          if (_code == Cnstds.KEY_GST00000) {
            _itemClientDetailSup = ClientDetailSup.Copy(
                result[Cnstds.dataClientDetailSup] as ClientDetailSup);
            // Esta parte es cuando se guarda de forma local
            Map<String, dynamic>? _itemClientDetailSupMap =
                _itemClientDetailSup.toJson(_itemClientDetailSup);

            String jsonString = jsonEncode(_itemClientDetailSupMap);

            int? count = await Get.find<MainRepository>()
                .existClientDetailSupLocal(
                    _id_client, _id_cellar, _id_client_route);
            if (count! == 0) {
              await Get.find<MainRepository>().insertClientDetailSupLocal(
                  ClientDetailSupLocal(
                      id_client: int.parse(_id_client),
                      id_cellar: int.parse(_id_cellar),
                      id_client_route: int.parse(_id_client_route),
                      content: jsonString,
                      enviadoAnaquelero: 1,
                      enviadoAsistencia: 1));
            } else {
              await Get.find<MainRepository>().updateClientDetailSupLocal(
                  _id_client, _id_cellar, _id_client_route, jsonString);
            }
          }
        }

        // Se obtiene la lista de otras rutas
        result = await Get.find<MainRepository>()
            .getAppClientDetailsOtherRoutesBySupervisor(
                _id_route, _id_client, _id_cellar);
        if (result.length > 0) {
          response = result[Cnstds.KEY_RESPONSE];
          _code = response.code;
          if (_code == Cnstds.KEY_GST00000) {
            _itemsClientDetailOtherRoute =
                result[Cnstds.dataClientDetailOtherRoute]
                    as List<ClientDetailOtherRoute>;
            if (_itemsClientDetailOtherRoute.length > 0) {
              List<Map<String, dynamic>>? _clientDetailOtherRouteMap =
                  _itemsClientDetailOtherRoute.map((i) => i.toJson(i)).toList();
              String jsonString = jsonEncode(_clientDetailOtherRouteMap);
              int? count = await Get.find<MainRepository>()
                  .existClientDetailOtherRouteLocal(
                      _id_route, _id_client, _id_cellar);
              if (count == 0) {
                await Get.find<MainRepository>()
                    .insertClientDetailOtherRouteLocal(
                        ClientDetailOtherRouteLocal(
                            id_route: _id_route,
                            id_client: int.parse(_id_client),
                            id_cellar: int.parse(_id_cellar),
                            content: jsonString));
              } else {
                await Get.find<MainRepository>()
                    .updateClientDetailOtherRouteLocal(
                        _id_route, _id_client, _id_cellar, jsonString);
              }
            }
          }
        }

        // Se obtiene la lista de anaqueleros de cada client_route
        result = await Get.find<MainRepository>()
            .getAppAnaquelerosToManageClient(_id_client_route);
        if (result.length > 0) {
          response = result[Cnstds.KEY_RESPONSE];
          _code = response.code;
          if (_code == Cnstds.KEY_GST00000) {
            _itemsAnaquelerosToManage =
                result[Cnstds.dataAnaquelerosToManageClient]
                    as List<AnaquelerosToManage>;
            if (_itemsAnaquelerosToManage.length > 0) {
              List<Map<String, dynamic>>? _itemsAnaquelerosToManageMap =
                  _itemsAnaquelerosToManage.map((i) => i.toJson(i)).toList();

              String jsonString = jsonEncode(_itemsAnaquelerosToManageMap);
              var res = await Get.find<MainRepository>()
                  .insertAnaquelerosToManageClientLocal(
                      AnaquelerosToManageClientLocal(
                          id_client_route: int.parse(_id_client_route),
                          content: jsonString));
            }
          }
        }
      }
    }
  }

  getCountClientsStates() async {
    result = await Get.find<MainRepository>()
        .appGetCountClientsStatesTodaySySupervisor();
    if (result.isNotEmpty) {
      ResponseCode response = result['response'];
      if (response.code == Cnstds.KEY_GST00000) {
        CountClientsStates itemCountClientsStates =
            result[Cnstds.dataCountClientsStates] as CountClientsStates;
        Utils.prefs.count_states_all = itemCountClientsStates.all.toString();
        Utils.prefs.count_states_finished =
            itemCountClientsStates.finished.toString();
        Utils.prefs.count_states_in_progress =
            itemCountClientsStates.inProgress.toString();
        Utils.prefs.count_states_pending =
            itemCountClientsStates.pending.toString();
      }
    }
  }

  showAnaqueleroPage(Team item, int index) {
    if (item.details != null) {
      subIndexPage = 1;
      indexTeamAnaquelero = index;
      teamCurrent = Team.copy(item);
      update();
      Get.to(
        () => TeamsAnaqueleroPage(),
        binding: PokemonBinding(),
      );
    }
  }

  itemCountStores(String txtIcon, String txtTitle, String txtCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            BootstrapContainer(fluid: true, children: [
              BootstrapRow(
                children: <BootstrapCol>[
                  BootstrapCol(
                    sizes: 'col-5',
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: SvgPicture.asset(txtIcon),
                        )),
                  ),
                  BootstrapCol(
                    sizes: 'col-1',
                    child: Align(child: Container()),
                  ),
                  BootstrapCol(
                    sizes: 'col-5',
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        txtCount,
                        style: themeApp.text16400Black,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
            BootstrapContainer(fluid: true, children: [
              BootstrapRow(
                children: <BootstrapCol>[
                  BootstrapCol(
                    sizes: 'col-12',
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                txtTitle,
                                style: themeApp.text14,
                              ),
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            ]),
          ],
        )
      ],
    );
  }
}

/* ------------------------------------------------------------------------------------------------------------------------
  Nombre:      Activity
  Propósito:   Clase que implementa el widget de los apartados de asistencia 
  Entradas:    type: Indica si es de tipo checkin, comida o checkout
               onPressed: Función que ejecuta el widget 
               update: Indica si los valores del widget fueron actualizados
               widgetUpdate: Widget que se va a mostrar en caso de ser actualizado
  Salida:      StatelessWidget

  * Historia de Revisiones
  * Implementador                 Fecha           HU         Descripción
  * ----------------------------------------------------------------------------------------------------------------------
  * Ing. Gerardo Aguilar        24/07/2022   [SUP] HU04    Implementación inicial
  ----------------------------------------------------------------------------------------------------------------------- */
class Activity extends StatelessWidget {
  final String type;
  final VoidCallback? onPressed;
  final bool update;
  final Widget widgetUpdate;

  const Activity({
    required this.type,
    this.onPressed,
    required this.update,
    required this.widgetUpdate,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return GetBuilder<PokemonController>(
      builder: (_) => Container(
        padding: responsiveApp.edgeInsetsApp!.onlySmallLeftRightEdgeInsets,
        child: _.loading
            ? Container()
            : Row(children: [
                Expanded(
                  child: Text(
                    type == textCheckin
                        ? checkinStr
                        : type == textCheckout
                            ? checkoutStr
                            : textComida,
                    style: themeApp.textParagraph,
                  ),
                ),
                if (type == textCheckin)
                  update == true && _.hourCheckinSelect != ''
                      ? widgetUpdate
                      : _.itemClientDetailSup!.checkin == null
                          ? GestureDetector(
                              onTap: _.activeSwitch == true ? onPressed : null,
                              child: Text(
                                pendienteStr,
                                style: themeApp.textCTAlink,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _.itemClientDetailSup!.checkin!.distance
                                      .toString(),
                                  style: themeApp.textParagraph,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  child: CircleAvatar(
                                    backgroundColor: HexColor(_
                                        .itemClientDetailSup!.checkin!.color
                                        .toString()),
                                    radius: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  _.itemClientDetailSup!.checkin!.time_start
                                      .toString(),
                                  style: themeApp.textParagraphSecondaryBlue,
                                ),
                              ],
                            ),
                if (type == textComida)
                  _.itemClientDetailSup!.comida == null
                      ? Text(
                          text_,
                          style: themeApp.textParagraph,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _.itemClientDetailSup!.comida!.time_start
                                      .toString() +
                                  ' - ',
                              style: themeApp.textParagraphSecondaryBlue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              _.itemClientDetailSup!.comida!.time_end != 'null'
                                  ? _.itemClientDetailSup!.comida!.time_end
                                      .toString()
                                  : '',
                              style: themeApp.textParagraphSecondaryBlue,
                            ),
                          ],
                        ),
                if (type == textCheckout)
                  update == true && _.hourCheckoutSelect != ''
                      ? widgetUpdate
                      : _.itemClientDetailSup!.checkout == null
                          ? GestureDetector(
                              onTap: _.activeSwitch == true ? onPressed : null,
                              child: Text(
                                pendienteStr,
                                style: themeApp.textCTAlink,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _.itemClientDetailSup!.checkout!.distance
                                      .toString(),
                                  style: themeApp.textParagraph,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  child: CircleAvatar(
                                    backgroundColor: HexColor(_
                                        .itemClientDetailSup!.checkout!.color
                                        .toString()),
                                    radius: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  _.itemClientDetailSup!.checkout!.time_start
                                      .toString(),
                                  style: themeApp.textParagraphSecondaryBlue,
                                ),
                              ],
                            ),
              ]),
      ),
    );
  }
}

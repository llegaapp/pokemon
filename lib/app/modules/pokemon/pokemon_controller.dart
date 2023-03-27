import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokemon_heb/app/global_widgets/button2.dart';
import 'package:pokemon_heb/main.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../config/constant.dart';
import '../../config/responsive_app.dart';
import '../../config/string_app.dart';
import '../../config/utils.dart';
import '../../data_source/constant_ds.dart';
import '../../global_widgets/app/view_address_store.dart';
import '../../global_widgets/button1.dart';
import '../../models/paginator.dart';
import '../../models/pokemon.dart';
import '../../repository/main_repository.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path/path.dart';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class PokemonController extends GetxController {
  bool loading = false;
  Dio dio = Dio();
  List<PokemonListModel> itemsPokemon = [];
  List<PokemonListModel> itemsPokemonSelected = [];
  List<PokemonListModel> itemsPokemonPaginator = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RefreshController refreshControllerSupervisor =
      RefreshController(initialRefresh: false);
  RefreshController refreshControllerSupervisorItem =
      RefreshController(initialRefresh: false);
  RefreshController refreshControllerSupervisorItemDetail =
      RefreshController(initialRefresh: false);
  RefreshController refreshControllerAgendaDetail =
      RefreshController(initialRefresh: false);

  late int totalItemsStores = 0;
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
  String idUniqueSelectedTmp = '0';
  String nameUniqueSelectedTmp = '';
  bool isDetailUpdate = false;
  int indexDiaryClientCurrent = -1;
  int indexRouteSupCurrent = -1;
  int indexTeamCurrentDetails = -1;
  int indexTeamAnaquelero = -1;
  int indexStoreCurrentDetails = -1;

  late int totalItemsFiltredTeams = 0;
  late int totalItemsTeams = 0;
  bool isTodayTeams = false;
  bool isSearchStore = false;

  String routeTeamsSelected = '';

  late Map<String, dynamic> result;
  String _code = '';
  String dateCurrentStr = '';
  int indexPage = 1;
  String titleStore = tiendasStr;
  String titleTeams = equiposStr;
  String currentStoreList = '';
  String currentTeamList = '';
  int subIndexPage = 0;
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
    //paginator
    ever(_paginationFilter, (_) => loadListPokemon());
    _changePaginationFilter(0, _limitPagination);
    //paginator
  }

  loadListPokemon() async {
    if (loading) return;
    loading = true;
    Utils.syncDialog(obteniendoDatosStr);
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

    loading = false;
    Get.back();
    update();
    if (skip! > 0) {
      scrollController.animateTo((itemsPokemon.length - _limitPagination) * 45,
          duration: const Duration(microseconds: 100), curve: Curves.linear);
    }
    update();
  }

  addPokemon(PokemonListModel item) {
    if (itemsPokemonSelected.length < 5) {
      itemsPokemonSelected!.add(item);
      item.selected = true;
      // Utils.prefs.itemsPokemonSelected = [];
      Utils.prefs.itemsPokemonSelected.addAll(itemsPokemonSelected);
      log(itemsPokemonSelected.toString());
    }

    update();
  }

  removePokemon(PokemonListModel item) {
    for (var _item in itemsPokemon) {
      if (item.id == _item.id) {
        _item.selected = false;
        break;
      }
    }
    itemsPokemonSelected!.remove(item);
    // Utils.prefs.itemsPokemonSelected = [];
    Utils.prefs.itemsPokemonSelected.addAll(itemsPokemonSelected);
    log(itemsPokemonSelected.toString());
    update();
  }

  openPokemonList(BuildContext _) {
    Get.dialog(
      barrierDismissible: false,
      Container(
          child: AlertDialog(
        contentPadding: EdgeInsets.all(10.0),
        content: Container(
          height: 450,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, bottom: 10, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                for (var _item in itemsPokemonSelected)
                  Container(
                    color: themeApp.colorPrimary,
                    height: 70,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 40, // 15%
                            child: Container(
                              color: themeApp.colorWhite,
                              width: 40,
                              child: Image.network(_item.img.toString()),
                            ),
                          ),
                          Flexible(
                            flex: 150, // 15%
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    _item.name.toString(),
                                    style: themeApp.text14boldBlack400,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Flexible(
                                      child: Button1(
                                    height: 10,
                                    label: eliminarDeMiEquipoStr,
                                    // padding: EdgeInsets.all( 0),
                                    style: themeApp.text12dWhite,
                                    background: themeApp.colorPrimaryRed,
                                    onPressed: () {
                                      removePokemon(_item);
                                      Get.back();
                                    },
                                  )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                Flexible(
                    child: Button1(
                  height: 20,
                  label: cerrarStr,
                  // padding: EdgeInsets.all( 0),
                  style: themeApp.text12dWhite,
                  background: themeApp.colorPrimaryGeen,
                  onPressed: () {
                    Get.back();
                  },
                ))
              ],
            ),
          ),
        ),
      )),
    );
  }
}

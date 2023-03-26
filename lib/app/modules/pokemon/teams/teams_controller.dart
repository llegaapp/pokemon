import 'dart:async';
import 'package:pokemon_heb/app/models/diary/route_sup.dart';
import 'package:pokemon_heb/app/models/stores/anaqueleros_to_manage_client.dart';
import 'package:pokemon_heb/app/modules/pokemon/stores/stores_binding.dart';
import 'package:pokemon_heb/app/modules/pokemon/stores/stores_detail_page.dart';
import '../../../global_widgets/data_table/data_table_2.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../config/constant.dart';
import '../../../config/responsive_app.dart';
import '../../../config/string_app.dart';
import '../../../config/utils.dart';
import '../../../data_source/constant_ds.dart';
import '../../../global_widgets/button1.dart';
import '../../../global_widgets/dropdown2.dart';
import '../../../models/anaquelero/event.dart';
import '../../../models/stores/cat_routes_by_supervisor.dart';
import '../../../models/response_code.dart';
import '../../../models/stores/clients_list_by_route_supervisor.dart';
import '../../../repository/main_repository.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'stores_anaqueleros_loadData.dart';

class TeamsController extends GetxController {
  bool loading = false;
  bool withoutSending = false;
  late Map<String, dynamic> result;
  List<RouteSup> itemsRouteSup = [];
  List<Event> itemsEvent = [];
  late List<CatRoutesBySupervisor> itemsRoutes = [];
  late List<ClientsListByRouteSupervisor> itemsStores = [];

  bool _sortAscending = true;
  int? _sortColumnIndex;

  final searchController = TextEditingController();
  String dateCurrentStr = '';
  String _code = '';
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  List<DropdownMenuItem<dynamic>> get _hours {
    List<DropdownMenuItem<dynamic>> menuItems = [];
    for (int _hora = 1; _hora <= 24; _hora++) {
      String hora = _hora.toString();
      if (hora.length == 1) hora = "0" + hora;
      menuItems.add(
          DropdownMenuItem(child: Text(hora + ':00'), value: hora + ':00'));
    }
    return menuItems;
  }

  void loadData() async {
    loading = true;

    // result = await Get.find<MainRepository>().bo_get_cat_regions();
    // if (result[Constant.dataRegions] != null)
    //   itemsRoutes = await result[Constant.dataRegions];
    // else
    itemsRoutes = [];

    // result = await Get.find<MainRepository>()
    //     .bo_get_clients_sio_list_find(find, skip, limit);
    // if (result[Constant.dataTiendasSio] != null)
    //   itemsStores = await result[Constant.dataTiendasSio];
    // else
    itemsStores = [];

    itemsStores.add(ClientsListByRouteSupervisor(
        nameClient: 'tienda1', idRoute: '100', nameRoute: 'Walmart Centro'));
    itemsStores.add(ClientsListByRouteSupervisor(
        nameClient: 'tienda1', idRoute: '101', nameRoute: 'Walmart Norte'));
    itemsStores.add(ClientsListByRouteSupervisor(
        nameClient: 'tienda1', idRoute: '102', nameRoute: 'Walmart Sur'));
    itemsStores.add(ClientsListByRouteSupervisor(
        nameClient: 'tienda1', idRoute: '103', nameRoute: 'Walmart Este'));

    loading = false;
    update();
  }

  List<DropdownMenuItem<dynamic>> get routes {
    List<DropdownMenuItem<dynamic>> menuItems = [];
    menuItems.add(DropdownMenuItem(child: Text(rutaStr), value: rutaStr));
    for (var _item in itemsRoutes) {
      menuItems.add(DropdownMenuItem(
          child: Text(
            '_item.name!.toString()',
            overflow: TextOverflow.ellipsis,
          ),
          value: '_item.id!.toString()'));
    }
    return menuItems;
  }

  void sortAnaqueleros<T>(
    Comparable<T> Function(AnaquelerosToManage d) getField,
    int columnIndex,
    bool ascending,
    _loadData,
  ) {
    bool asc = !_sortAscending;
    _loadData.sorts<T>(getField, asc);

    _sortColumnIndex = columnIndex;
    _sortAscending = asc;
    update();
  }

  onRefresh() async {
    //await Future.delayed(Duration(milliseconds: 3000));
    if (await Utils.hasInternet(sendMessage: false)) {
      if (withoutSending == true) {
        // Se actualizan los envios de Eventos
        await Get.find<MainRepository>().syncUpdateEventClient();
        // Se actualizan los envios de Check
        await Get.find<MainRepository>().syncUpdateCheckClient();
        // Se actualiza la vartiable de syncronización
        withoutSending = await Get.find<MainRepository>().pendingShippingDB();
      }

      // Syncroniza event list
      await Get.find<MainRepository>().syncEventList();
      // Actualiza event list
      itemsEvent = await Get.find<MainRepository>().getEventDB();

      // Syncroniza HomeInfo
      await Get.find<MainRepository>().syncHomeInfo();
      // itemsHomeInfo.clear();
      // itemsHomeInfo = await Get.find<MainRepository>().getHomeInfoDB();
      // Utils.userDayNotWorking = itemsHomeInfo.length == 0;
      // Utils.idClientCurrent = '0';
      // dateCurrentStr = '';
      // for (var i = 0; i < itemsHomeInfo.length; i++) {
      //   if (dateCurrentStr == '') {
      //     dateCurrentStr =
      //         Utils.getFechaStr(itemsHomeInfo[i].today_show.toString());
      //   }
      //   if (itemsHomeInfo[i].status_id_schedule == Constant.ID_STATUS_ENCURSO) {
      //     Utils.idClientCurrent = itemsHomeInfo[i].id_client_route.toString();
      //     break;
      //   }
      // }
      Utils.setCurrentDate();
      refreshController.refreshCompleted();
    } else {
      await Future.delayed(Duration(milliseconds: 1000));
      refreshController.refreshFailed();
    }
    update();
  }
}

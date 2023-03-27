import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import '../models/pokemon.dart';

class PreferedController extends GetxController {
  final prefs = GetStorage();

  void erasePrefered() {
    prefs.erase();
  }

  //get set para token
  String get token => prefs.read('token') ?? '';
  set token(String val) => prefs.write('token', val);

  //get set para usercode
  String get usercode => prefs.read('usercode') ?? '';
  set usercode(String val) => prefs.write('usercode', val);

  //get set para currentDate
  String get currentDate => prefs.read('currentDate') ?? '';
  set currentDate(String val) => prefs.write('currentDate', val);

  //get set para deviceId
  String get deviceId => prefs.read('deviceId') ?? '';
  set deviceId(String val) => prefs.write('deviceId', val);

  //get set para grouper
  String get grouper => prefs.read('grouper') ?? '';
  set grouper(String val) => prefs.write('grouper', val);

  //get set para expire
  String get expire => prefs.read('expire') ?? '';
  set expire(String val) => prefs.write('expire', val);

  //get set para userGuest
  bool get userGuest => prefs.read('userGuest') ?? false;
  set userGuest(bool val) => prefs.write('userGuest', val);

  // Datos del perfil supervisor
  String get user_id => prefs.read('user_id') ?? '';
  set user_id(String val) => prefs.write('user_id', val);
  String get user_name => prefs.read('user_name') ?? '';
  set user_name(String val) => prefs.write('user_name', val);
  String get profile => prefs.read('profile') ?? '';
  set profile(String val) => prefs.write('profile', val);
  String get manager_type => prefs.read('manager_type') ?? '';
  set manager_type(String val) => prefs.write('manager_type', val);
  String get manager_name => prefs.read('manager_name') ?? '';
  set manager_name(String val) => prefs.write('manager_name', val);
  String get active_since => prefs.read('active_since') ?? '';
  set active_since(String val) => prefs.write('active_since', val);

  //get set para RouteSup
  String get routeSup => prefs.read('routeSup') ?? '';
  set routeSup(String val) => prefs.write('routeSup', val);

  String get dataCatRoutesBySupervisorAll =>
      prefs.read('dataCatRoutesBySupervisorAll') ?? '';
  set dataCatRoutesBySupervisorAll(String val) =>
      prefs.write('dataCatRoutesBySupervisorAll', val);

  String get dataCatRoutesBySupervisorToday =>
      prefs.read('dataCatRoutesBySupervisorToday') ?? '';
  set dataCatRoutesBySupervisorToday(String val) =>
      prefs.write('dataCatRoutesBySupervisorToday', val);

  String get dataTeamListBySupervisorToday =>
      prefs.read('dataTeamListBySupervisorToday') ?? '';
  set dataTeamListBySupervisorToday(String val) =>
      prefs.write('dataTeamListBySupervisorToday', val);

  String get dataTeamListBySupervisorAll =>
      prefs.read('dataTeamListBySupervisorAll') ?? '';
  set dataTeamListBySupervisorAll(String val) =>
      prefs.write('dataTeamListBySupervisorAll', val);

  String get dataAppCatRouteBySupervisor =>
      prefs.read('dataAppCatRouteBySupervisor') ?? '';
  set dataAppCatRouteBySupervisor(String val) =>
      prefs.write('dataAppCatRouteBySupervisor', val);

  String get dataAnaquelerosToManageClient =>
      prefs.read('dataAnaquelerosToManageClient') ?? '';
  set dataAnaquelerosToManageClient(String val) =>
      prefs.write('dataAnaquelerosToManageClient', val);

  String get dataClientsListByRouteSupervisor =>
      prefs.read('dataClientsListByRouteSupervisor') ?? '';
  set dataClientsListByRouteSupervisor(String val) =>
      prefs.write('dataClientsListByRouteSupervisor', val);

  String get dataClientsListByRouteSupervisorToday =>
      prefs.read('dataClientsListByRouteSupervisorToday') ?? '';
  set dataClientsListByRouteSupervisorToday(String val) =>
      prefs.write('dataClientsListByRouteSupervisorToday', val);

  //get set para dateCurrentStr
  String get dateCurrentStr => prefs.read('dateCurrentStr') ?? '';
  set dateCurrentStr(String val) => prefs.write('dateCurrentStr', val);

  //get set para clientDetailOtherRoute
  String get clientDetailOtherRoute =>
      prefs.read('clientDetailOtherRoute') ?? '';
  set clientDetailOtherRoute(String val) =>
      prefs.write('clientDetailOtherRoute', val);

  //get set para clientDetailSup
  String get clientDetailSup => prefs.read('clientDetailSup') ?? '';
  set clientDetailSup(String val) => prefs.write('clientDetailSup', val);

  //get set para AnaquelerosToManage
  String get dataAnaquelerosToManage =>
      prefs.read('dataAnaquelerosToManage') ?? '';
  set dataAnaquelerosToManage(String val) =>
      prefs.write('dataAnaquelerosToManage', val);

  //get set para ItemsHomeInfo
  String get dataItemsHomeInfo => prefs.read('dataItemsHomeInfo') ?? '';
  set dataItemsHomeInfo(String val) => prefs.write('dataItemsHomeInfo', val);

  // Datos set CountClientsStates
  String get count_states_all => prefs.read('count_states_all') ?? '';
  set count_states_all(String val) => prefs.write('count_states_all', val);
  String get count_states_finished => prefs.read('count_states_finished') ?? '';
  set count_states_finished(String val) =>
      prefs.write('count_states_finished', val);
  String get count_states_in_progress =>
      prefs.read('count_states_in_progress') ?? '';
  set count_states_in_progress(String val) =>
      prefs.write('count_states_in_progress', val);
  String get count_states_pending => prefs.read('count_states_pending') ?? '';
  set count_states_pending(String val) =>
      prefs.write('count_states_pending', val);

  List<PokemonListModel> get itemsPokemonSelected =>
      prefs.read('itemsPokemonSelected') ?? [];
  set itemsPokemonSelected(List<PokemonListModel> val) =>
      prefs.write('itemsPokemonSelected', val);



}

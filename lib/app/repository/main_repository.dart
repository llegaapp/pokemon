import 'dart:convert';
import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/config/string_app.dart';
import 'package:pokemon_heb/app/config/utils.dart';
import 'package:pokemon_heb/app/models/anaquelero/back_check.dart';
import 'package:pokemon_heb/app/models/anaquelero/back_event.dart';
import 'package:pokemon_heb/app/models/diary/anaqueleros_to_manage_client_local.dart';
import 'package:pokemon_heb/app/models/diary/client_detail_other_route_local.dart';
import 'package:pokemon_heb/app/models/diary/client_detail_sup_local.dart';
import '../data_source/api_clients.dart';
import '../data_source/constant_ds.dart';
import '../data_source/local_data_source.dart';
import '../data_source/rest_data_source.dart';
import '../models/anaquelero/client.dart';
import '../models/anaquelero/event.dart';
import '../models/anaquelero/event_client.dart';
import '../models/anaquelero/home_info.dart';
import '../models/news.dart';
import '../models/response_code.dart';

class MainRepository {
  final ApiClients _api;
  final RestDataSource _apiRest;

  MainRepository(this._api, this._apiRest);

  late Map<String, dynamic> result;
  late Map<String, dynamic> datos;

  Future<Map<String, dynamic>> appLogin(
      String employeeId, password, deviceId) async {
    return _api.appLogin(employeeId, password, deviceId);
  }

  Future<Map<String, dynamic>> appGetHomeInfo() async {
    return _api.appGetHomeInfo();
  }

  Future<List<Client>> getClientDB() async {
    return LocalDB.getClientDB();
  }

  Future<int?> getCountClientDB() async {
    return LocalDB.getCountClient();
  }

  Future<int> insertClientDB(Client item) async {
    return LocalDB.insertClient(item);
  }

  Future<void> dropClientDB() async {
    return LocalDB.dropClient();
  }

  Future<int> insertEventClientDB(EventClient item) async {
    return LocalDB.insertEventClient(item);
  }

  Future<int> insertEventDB(Event item) async {
    return LocalDB.insertEvent(item);
  }

  Future<void> insertEventsClientDB(
      String id_client_route, List<EventClient> items) async {
    return LocalDB.insertEvents(id_client_route, items);
  }

  Future<Map<String, dynamic>> appGetClientById(String idClientRoute) async {
    return _api.appGetClientById(idClientRoute);
  }

  Future<Map<String, dynamic>> appCheckin(String idClientRoute, lat, long,
      deviceDate, deviceGTM, isOnline, b64Photo) async {
    return _api.appCheckin(
        idClientRoute, lat, long, deviceDate, deviceGTM, isOnline, b64Photo);
  }

  Future<Map<String, dynamic>> appCheckout(String idClientRoute, lat, long,
      comment, deviceDate, deviceGTM, isOnline, b64Photo) async {
    return _api.appCheckout(idClientRoute, lat, long, comment, deviceDate,
        deviceGTM, isOnline, b64Photo);
  }

  Future<Map<String, dynamic>> appManageClientOutFrequencyBySupervisor(
      String idClient, idCellar, idAnaquelero, startTime, endTime) async {
    return _api.appManageClientOutFrequencyBySupervisor(
        idClient, idCellar, idAnaquelero, startTime, endTime);
  }

  Future<void> dropHomeInfoDB() async {
    return LocalDB.dropHomeInfo();
  }

  Future<void> dropClient() async {
    return LocalDB.dropClient();
  }

  Future<void> dropEventClientDB() async {
    return LocalDB.dropEventClient();
  }

  Future<void> dropEventDB() async {
    return LocalDB.dropEvent();
  }

  Future<void> dropBackEventDB() async {
    return LocalDB.dropBackEvent();
  }

  Future<void> dropBackCheckDB() async {
    return LocalDB.dropBackCheck();
  }

  Future<String> loadEventDB() async {
    List<Event> items = [];
    String code = '';
    await LocalDB.dropEvent();
    result = await _api.appGetEventList();
    if (result.length > 0) {
      ResponseCode response = result[Cnstds.KEY_RESPONSE];
      code = response.code;
      if (code == Cnstds.KEY_GST00000) {
        items = result[Cnstds.dataEvent] as List<Event>;
        for (var i = 0; i < items.length; i++) {
          LocalDB.insertEvent(items[i]);
        }
      }
    }
    return code;
  }

  Future<List<Event>> grapListEvent() async {
    List<Event> items = [];
    result = await _api.appGetEventList();
    if (result.length > 0) {
      ResponseCode response = result[Cnstds.KEY_RESPONSE];
      if (response.code == Cnstds.KEY_GST00000)
        items = result[Cnstds.dataEvent] as List<Event>;
    }
    return items;
  }

  Future<String> loadHomeInfoDB() async {
    int value = 0;
    String code = '';
    List<HomeInfo> items = [];
    await LocalDB.dropHomeInfo();
    await LocalDB.dropClient();
    result = await _api.appGetHomeInfo();
    if (result.length > 0) {
      ResponseCode response = result[Cnstds.KEY_RESPONSE];
      code = response.code;
      if (response.code == Cnstds.KEY_GST00000) {
        items = result[Cnstds.dataHomeInfo] as List<HomeInfo>;
        for (var i = 0; i < items.length; i++) {
          await LocalDB.insertHomeInfo(items[i]);
          final idStatus =
              await getStatusClientDB(items[i].id_client_route.toString());
          if (value == 0) {
            if (idStatus == '1') {
              value = await LocalDB.updateActiveHomeInfo(
                  items[i].id_client_route.toString());
            } else if (idStatus == '2') {
              value = await LocalDB.updateActiveHomeInfo(
                  items[i].id_client_route.toString());
            }
          }
          result = await appGetClientById(items[i].id_client_route.toString());
          if (result.length > 0) {
            if (result[Cnstds.dataClient] != null)
              LocalDB.insertClient(result[Cnstds.dataClient] as Client);
            if (result[Cnstds.dataEventClient] != null) {
              LocalDB.insertEvents(items[i].id_client_route.toString(),
                  result[Cnstds.dataEventClient] as List<EventClient>);
            }
          }
        }
      }
    }
    return code;
  }

  Future<List<HomeInfo>> getHomeInfoDB() async {
    return LocalDB.getHomeInfoDB();
  }

  Future<List<HomeInfo>> grapHomeInfo() async {
    List<HomeInfo> items = [];
    result = await _api.appGetHomeInfo();
    if (result.length > 0) {
      ResponseCode response = result[Cnstds.KEY_RESPONSE];
      if (response.code == Cnstds.KEY_GST00000)
        items = result[Cnstds.dataHomeInfo] as List<HomeInfo>;
    }
    return items;
  }

  Future<List<Event>> getEventDB() async {
    return LocalDB.getEventDB();
  }

  Future<int?> getCountHomeInfoDB() async {
    return LocalDB.getCountHomeInfo();
  }

  Future<bool> getSinAccesoDB() async {
    int? numInfo = await LocalDB.getCountHomeInfo();
    int? numCurso = await LocalDB.getCountEncurso();
    int? numPendiente = await LocalDB.getCountPendiente();
    int? numTerminada = await LocalDB.getCountTerminada();
    return (numCurso! > 0) ||
        !(numPendiente == numInfo || numTerminada == numInfo);
  }

  Future<Client> getOneClientDB(String idClientRoute) async {
    return LocalDB.getOneClientDB(idClientRoute);
  }

  Future<HomeInfo> getOneHomeInfoDB(String idClientRoute) async {
    return LocalDB.getOneHomeInfoDB(idClientRoute);
  }

  Future<int> updateCheckin(
      String idClientRoute, x, y, day, hour, idStatus, nameStatus) async {
    return LocalDB.updateCheckin(
        idClientRoute, x, y, day, hour, idStatus, nameStatus);
  }

  Future<int> updateCheckoutDB(String idClientRoute, x, y, day, hour, comment,
      idStatus, nameStatus) async {
    return LocalDB.updateCheckout(
        idClientRoute, x, y, day, hour, comment, idStatus, nameStatus);
  }

  Future<String> getStatusClientDB(String idClientRoute) async {
    return LocalDB.getStatusClientDB(idClientRoute);
  }

  Future<int> updateActiveHomeInfoDB(String idClientRoute) async {
    return LocalDB.updateActiveHomeInfo(idClientRoute);
  }

  Future<Map<String, dynamic>> appGetEventList() async {
    return _api.appGetEventList();
  }

  Future<int?> getCountEventDB() async {
    return LocalDB.getCountEvent();
  }

  Future<Map<String, dynamic>> appStartEvent(String idClientRoute,
      idCatalogEvent, lat, long, deviceDate, deviceGTM) async {
    return _api.appStartEvent(
        idClientRoute, idCatalogEvent, lat, long, deviceDate, deviceGTM);
  }

  Future<bool> getEventClientActive(String idClientRoute) async {
    int? num = await LocalDB.getEventClient(idClientRoute);
    return (num! > 0);
  }

  Future<Map<String, dynamic>> appEndEvent(
      String idRegisteredEvent, device_date, device_gtm) async {
    return _api.appEndEvent(idRegisteredEvent, device_date, device_gtm);
  }

  Future<Map<String, dynamic>> getIdRegisteredEvent(
      String idClientRoute) async {
    return LocalDB.getIdRegisteredEventDB(idClientRoute);
  }

  Future<int> updateEventClient(
      String idRegisteredEvent, deviceDate, deviceGTM) async {
    return LocalDB.updateEventClient(idRegisteredEvent, deviceDate, deviceGTM);
  }

  Future<int> updateIncEvent(String idCatalogEvent) async {
    return LocalDB.updateIncEvent(idCatalogEvent);
  }

  Future<Map<String, dynamic>> appLogout() async {
    return _api.appLogout();
  }

  Future<Map<String, dynamic>> appClosingDayBySupervisor() async {
    return _api.appClosingDayBySupervisor();
  }

  Future<Map<String, dynamic>> getAppHomeListCurrentScheduleClientsBySupervisor(
      int skip, int limit) async {
    return _api.getAppHomeListCurrentScheduleClientsBySupervisor(skip, limit);
  }

  Future<Map<String, dynamic>> getAppHomePokemonList(
      int skip, int limit) async {
    return _api.getAppHomePokemonList(skip, limit);
  }

  Future<Map<String, dynamic>> getAppHomePokemonDetailList(String url) async {
    return _api.getAppHomePokemonDetailList(url);
  }

  Future<Map<String, dynamic>> getAppAllClientsListByRouteSupervisor(
      String idRoute) async {
    return _api.getAppAllClientsListByRouteSupervisor(idRoute);
  }

  Future<Map<String, dynamic>> getAppCatRouteBySupervisor() async {
    return _api.getAppCatRouteBySupervisor();
  }

  Future<Map<String, dynamic>> getAppAllClientsListByRouteSupervisorToday(
      String idRoute) async {
    return _api.getAppAllClientsListByRouteSupervisorToday(idRoute);
  }

  Future<Map<String, dynamic>> getAppCatRoutesBySupervisor(bool isToday) async {
    return _api.getAppCatRoutesBySupervisor(isToday);
  }

  Future<Map<String, dynamic>> appGetTeamListBySupervisor(bool isToday) async {
    return _api.appGetTeamListBySupervisor(isToday);
  }

  Future<int> insertBackEventDB(
      EventClient item, String typeEvent, enviado) async {
    return LocalDB.insertBackEvent(item, typeEvent, enviado);
  }

  Future<Map<String, dynamic>> getBackEventStartDB() async {
    return LocalDB.getBackEventStartDB();
  }

  Future<Map<String, dynamic>> getBackCheckInDB(String idClient) async {
    return LocalDB.getBackCheckInDB(idClient);
  }

  Future<int> deleteBackEvent(String folio) async {
    return LocalDB.deleteBackEvent(folio);
  }

  Future<int> updateCheckEventEnviadoDB(String folio, idRegisteredEvent) async {
    return LocalDB.updateCheckEventEnviado(folio, idRegisteredEvent);
  }

  Future<int> updateCheckEnviadoDB(String idClient, typeCheck) async {
    return LocalDB.updateCheckEnviado(idClient, typeCheck);
  }

  Future<int> insertBackCheckDB(
      String id_client_route,
      x_coordinate,
      y_coordinate,
      device_date,
      device_gtm,
      description,
      type_check,
      image,
      enviado) async {
    return LocalDB.insertBackCheck(id_client_route, x_coordinate, y_coordinate,
        device_date, device_gtm, description, type_check, image, enviado);
  }

  Future<bool> pendingShippingDB() async {
    return LocalDB.pendingShipping();
  }

  Future<List<BackEvent>> getBackEventSendDB() async {
    return LocalDB.getBackEventSendDB();
  }

  Future<List<BackCheck>> getBackCheckWithoutSendDB() async {
    return LocalDB.getBackCheckWithoutSendDB();
  }

  Future<int> updateEventListDB(
      String idCatalogEvent, name, description) async {
    return LocalDB.updateEventList(idCatalogEvent, name, description);
  }

  Future<void> syncEventList() async {
    List<Event> grapItemsEvent = await grapListEvent();
    List<Event> itemsEvent = await getEventDB();
    bool found;
    for (var i = 0; i < grapItemsEvent.length; i++) {
      found = false;
      for (var j = 0; j < itemsEvent.length; j++) {
        if (grapItemsEvent[i].id_catalog_event ==
            itemsEvent[j].id_catalog_event) {
          found = true;
          // Se actualiza el event
          await updateEventListDB(itemsEvent[j].id_catalog_event.toString(),
              grapItemsEvent[i].name, grapItemsEvent[i].description);
          break;
        }
      }
      if (found == false) // Si hay un event nuevo se inserta en la tabla local
        await insertEventDB(grapItemsEvent[i]);
    }
  }

  Future<void> syncUpdateEventClient() async {
    String idRegisteredEvent = '';
    List<BackEvent> itemsBackEvent = await getBackEventSendDB();
    for (var _item in itemsBackEvent) {
      if (_item.type_event == Cnstds.startEvent) {
        // Se envia el StartEvent para obtener el id_registered_event
        if (_item.enviado == '0') {
          result = await appStartEvent(
            _item.id_client_route.toString(),
            _item.id_catalog_event,
            _item.x_coordinate,
            _item.y_coordinate,
            _item.device_date,
            _item.device_gtm,
          );
          ResponseCode response = result[Cnstds.KEY_RESPONSE];
          if (response.code == Cnstds.KEY_GST00000) {
            idRegisteredEvent = result['id_registered_event'].toString();
            // Se actualiza el appStartEvent
            await updateCheckEventEnviadoDB(
                _item.folio.toString(), idRegisteredEvent);
          }
        } else {
          // Si el evento ya se envió, sólo se obtiene el idRegisteredEvent, para el endEvent
          idRegisteredEvent = _item.id_registered_event.toString();
        }
      }
      if (_item.type_event == Cnstds.endEvent) {
        if (idRegisteredEvent != '') {
          if (_item.enviado == '0') {
            result = await appEndEvent(
                idRegisteredEvent, _item.device_date, _item.device_gtm);
            ResponseCode response = result[Cnstds.KEY_RESPONSE];
            if (response.code == Cnstds.KEY_GST00000) {
              // Se actualiza el appEndEvent
              await updateCheckEventEnviadoDB(
                  _item.folio.toString(), idRegisteredEvent);
            }
          }
          idRegisteredEvent = '';
        }
      }
    }
    itemsBackEvent.clear();
  }

  Future<void> syncUpdateCheckClient() async {
    List<BackCheck> itemsBackCheck = await getBackCheckWithoutSendDB();
    for (var _item in itemsBackCheck) {
      if (_item.type_check == Cnstds.checkIn) {
        result = await appCheckin(
            _item.id_client_route.toString(),
            _item.x_coordinate,
            _item.y_coordinate,
            _item.device_date,
            _item.device_gtm,
            Constant.STR_FALSE,
            _item.b64Photo);
        ResponseCode response = result[Cnstds.KEY_RESPONSE];
        if (response.code == Cnstds.KEY_GST00000) {
          // Actualizamos el envio del checkin
          await updateCheckEnviadoDB(
              _item.id_client_route.toString(), Cnstds.checkIn);
        }
      } else {
        // Es un envío de checkout
        result = await appCheckout(
            _item.id_client_route.toString(),
            _item.x_coordinate,
            _item.y_coordinate,
            _item.description,
            _item.device_date,
            _item.device_gtm,
            Constant.STR_FALSE,
            _item.b64Photo);
        ResponseCode response = result[Cnstds.KEY_RESPONSE];
        if (response.code == Cnstds.KEY_GST00000) {
          // Actualizamos el envio del checkout
          await updateCheckEnviadoDB(
              _item.id_client_route.toString(), Cnstds.checkOut);
        }
      }
    }
    itemsBackCheck.clear();
  }

  Future<void> syncHomeInfo() async {
    List<HomeInfo> grapItemsHomeInfo = await grapHomeInfo();
    late List<HomeInfo> itemsHomeInfo;
    String valor = Utils.prefs.dataItemsHomeInfo;
    if (valor.isNotEmpty) {
      dynamic jsonData = jsonDecode(valor);
      itemsHomeInfo = (jsonData as List)
          .map((i) => HomeInfo.fromJson(json: i, source: noapiStr))
          .toList();
    }
    bool found;
    for (var i = 0; i < grapItemsHomeInfo.length; i++) {
      found = false;
      for (var j = 0; j < itemsHomeInfo.length; j++) {
        if (grapItemsHomeInfo[i].id_client_route ==
            itemsHomeInfo[j].id_client_route) {
          found = true;
          break;
        }
      }
      if (!found) {
        //await LocalDB.insertHomeInfo(grapItemsHomeInfo[i]);
        itemsHomeInfo.add(grapItemsHomeInfo[i]);
        // Se guarda localmente
        List<Map<String, dynamic>>? itemsHomeInfoMap = itemsHomeInfo != null
            ? itemsHomeInfo.map((i) => i.toJson(i)).toList()
            : null;
        String jsonString = jsonEncode(itemsHomeInfoMap);
        Utils.prefs.dataItemsHomeInfo = jsonString;

        result = await appGetClientById(
            grapItemsHomeInfo[i].id_client_route.toString());
        if (result.length > 0) {
          if (result[Cnstds.dataClient] != null)
            LocalDB.insertClient(result[Cnstds.dataClient] as Client);
          if (result[Cnstds.dataEventClient] != null) {
            LocalDB.insertEvents(
                grapItemsHomeInfo[i].id_client_route.toString(),
                result[Cnstds.dataEventClient] as List<EventClient>);
          }
        }
      }
    }
  }

  Future<Map<String, dynamic>> getAppClientDetailsBySupervisor(
      String idRoute, idClient, idCellar, idClientRoute) async {
    return _api.getAppClientDetailsBySupervisor(
        idRoute, idClient, idCellar, idClientRoute);
  }

  Future<Map<String, dynamic>> getAppClientDetailsOtherRoutesBySupervisor(
      String idRoute, idClient, idCellar) async {
    return _api.getAppClientDetailsOtherRoutesBySupervisor(
        idRoute, idClient, idCellar);
  }

  Future<Map<String, dynamic>> getAppAnaquelerosToManageClient(
      String id_client_route) async {
    return _api.getAppAnaquelerosToManageClient(id_client_route);
  }

  Future<Map<String, dynamic>> appMarkAssistanceBySupervisor(
      String idClientRoute,
      idAnaquelero,
      checkinTime,
      checkoutTime,
      deviceGTM) async {
    return _api.appMarkAssistanceBySupervisor(
        idClientRoute, idAnaquelero, checkinTime, checkoutTime, deviceGTM);
  }

  Future<Map<String, dynamic>> appReassignReplacementAnaquelero(
      String idClientRoute, idAnaquelero, startTime, endTime) async {
    return _api.appReassignReplacementAnaquelero(
        idClientRoute, idAnaquelero, startTime, endTime);
  }

  Future<void> dropClientDetailSupLocal() async {
    return LocalDB.dropClientDetailSupLocal();
  }

  Future<int> insertClientDetailSupLocal(ClientDetailSupLocal item) async {
    return LocalDB.insertClientDetailSupLocal(item);
  }

  Future<bool> pendingShippingAgenda() async {
    return LocalDB.pendingShippingAgenda();
  }

  Future<ClientDetailSupLocal> getOneClientDetailSupLocal(
      String? idClient, idCellar, idClientRoute) async {
    return LocalDB.getOneClientDetailSupLocal(
        idClient, idCellar, idClientRoute);
  }

  Future<int> updateClientDetailSupLocal(
      String idClient, idCellar, idClientRoute, content) async {
    return LocalDB.updateClientDetailSupLocal(
        idClient, idCellar, idClientRoute, content);
  }

  Future<int?> existClientDetailSupLocal(
      String? idClient, idCellar, idClientRoute) async {
    return LocalDB.existClientDetailSupLocal(idClient, idCellar, idClientRoute);
  }

  Future<List<ClientDetailSupLocal>>
      getListClientDetailSupLocalSinEnviar() async {
    return LocalDB.getListClientDetailSupLocalSinEnviar();
  }

  Future<int?> markAssistanceBySupervisorDB(
      String idClient, idCellar, idClientRoute, content) async {
    return LocalDB.markAssistanceBySupervisor(
        idClient, idCellar, idClientRoute, content);
  }

  Future<int?> reassignReplacementAnaqueleroDB(
      String idClient, idCellar, idClientRoute, content) async {
    return LocalDB.reassignReplacementAnaquelero(
        idClient, idCellar, idClientRoute, content);
  }

  Future<void> dropClientDetailOtherRouteLocal() async {
    return LocalDB.dropClientDetailOtherRouteLocal();
  }

  Future<int> insertClientDetailOtherRouteLocal(
      ClientDetailOtherRouteLocal item) async {
    return LocalDB.insertClientDetailOtherRouteLocal(item);
  }

  Future<ClientDetailOtherRouteLocal> getOneClientDetailOtherRouteLocal(
      String idRoute, idClient, idCellar) async {
    return LocalDB.getOneClientDetailOtherRouteLocal(
        idRoute, idClient, idCellar);
  }

  Future<int> updateClientDetailOtherRouteLocal(
      String idRoute, idClient, idCellar, content) async {
    return LocalDB.updateClientDetailOtherRouteLocal(
        idRoute, idClient, idCellar, content);
  }

  Future<int?> existClientDetailOtherRouteLocal(
      String? idRoute, idClient, idCellar) async {
    return LocalDB.existClientDetailOtherRouteLocal(
        idRoute, idClient, idCellar);
  }

  Future<void> dropAnaquelerosToManageClientLocal() async {
    return LocalDB.dropAnaquelerosToManageClientLocal();
  }

  Future<int> insertAnaquelerosToManageClientLocal(
      AnaquelerosToManageClientLocal item) async {
    return LocalDB.insertAnaquelerosToManageClientLocal(item);
  }

  Future<AnaquelerosToManageClientLocal?> getOneAnaquelerosToManageClientLocal(
      String idClientRoute) async {
    return LocalDB.getOneAnaquelerosToManageClientLocal(idClientRoute);
  }

  Future<Map<String, dynamic>> getProfileInfoUser() async {
    return _api.getProfileInfoUser();
  }

  Future<List<News>?> fetchNews() async {
    return _apiRest.fetchNews();
  }

  Future<Map<String, dynamic>>
      appGetCountClientsStatesTodaySySupervisor() async {
    return _api.appGetCountClientsStatesTodaySySupervisor();
  }

  Future<Map<String, dynamic>> appRegisterUserDummy(
      String name, email, bornDate, password) async {
    return _api.appRegisterUserDummy(name, email, bornDate, password);
  }

  dropLocalInfo() async {
    await dropHomeInfoDB();
    await dropClientDB();
    await dropEventClientDB();
    await dropEventDB();
    await dropBackEventDB();
    await dropBackCheckDB();
  }
}

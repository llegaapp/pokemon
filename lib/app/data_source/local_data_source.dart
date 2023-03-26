import 'package:pokemon_heb/app/data_source/constant_ds.dart';
import 'package:pokemon_heb/app/models/anaquelero/back_check.dart';
import 'package:pokemon_heb/app/models/anaquelero/back_event.dart';
import 'package:pokemon_heb/app/models/diary/anaqueleros_to_manage_client_local.dart';
import 'package:pokemon_heb/app/models/diary/client_detail_other_route_local.dart';
import 'package:pokemon_heb/app/models/diary/client_detail_sup_local.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/anaquelero/client.dart';
import '../models/anaquelero/event.dart';
import '../models/anaquelero/event_client.dart';
import '../models/anaquelero/home_info.dart';

class LocalDB {
  static Future<Database> _openDB() async {
    List<String> queries = [];
    String _sql;

    _sql =
        "CREATE TABLE IF NOT EXISTS client (id_client_route TEXT, date TEXT, time_show TEXT, id_client TEXT, id_chain TEXT, description TEXT, ";
    _sql = _sql +
        "lowDate TEXT, client_address TEXT, x_coordinate TEXT, y_coordinate TEXT, business_name TEXT, ";
    _sql = _sql +
        "full_address TEXT, branch_office TEXT, is_NOSIO TEXT, type_id TEXT, type_name TEXT, type_description TEXT); ";

    queries.add(_sql);

    _sql =
        "CREATE TABLE IF NOT EXISTS homeInfo (id_client_route TEXT, client_id TEXT, client_name TEXT, status_id_schedule TEXT, status_name_schedule TEXT, ";
    _sql = _sql +
        "status_color_schedule TEXT, time_show TEXT, hours_show TEXT,  today_show TEXT, comment TEXT DEFAULT '', active TEXT DEFAULT '', ";
    _sql = _sql +
        "x_checkin TEXT DEFAULT '', y_checkin TEXT DEFAULT '', date_checkin TEXT DEFAULT '', hour_checkin TEXT DEFAULT '',  ";
    _sql = _sql +
        "x_checkout TEXT DEFAULT '', y_checkout TEXT DEFAULT '', date_checkout TEXT DEFAULT '', hour_checkout TEXT DEFAULT '' ); ";

    queries.add(_sql);

    _sql =
        "CREATE TABLE IF NOT EXISTS eventClient (id_registered_event TEXT, id_client_route TEXT, id_catalog_event TEXT, x_coordinate TEXT, y_coordinate TEXT, created TEXT, created_gtm TEXT, ";
    _sql = _sql +
        "finished TEXT DEFAULT '', finished_gtm TEXT DEFAULT '',  active TEXT DEFAULT 'true' ); ";

    queries.add(_sql);

    _sql =
        "CREATE TABLE IF NOT EXISTS event (id_catalog_event TEXT, name TEXT, description TEXT, times TEXT, count INTEGER DEFAULT 0 ); ";

    queries.add(_sql);

    _sql =
        "CREATE TABLE IF NOT EXISTS backEvent (folio integer, id_registered_event TEXT, id_client_route TEXT, id_catalog_event TEXT, x_coordinate TEXT, y_coordinate TEXT, device_date TEXT, device_gtm TEXT, type_event TEXT, enviado TEXT DEFAULT '0', primary key (folio)); ";

    queries.add(_sql);

    _sql =
        "CREATE TABLE IF NOT EXISTS backCheck (folio integer, id_client_route TEXT, x_coordinate TEXT, y_coordinate TEXT, device_date TEXT, device_gtm TEXT, description TEXT DEFAULT '', type_check TEXT, is_online TEXT, b64Photo TEXT, enviado TEXT DEFAULT '0', primary key (folio)); ";

    queries.add(_sql);

    _sql =
        "CREATE TABLE IF NOT EXISTS client_detail_sup_local (folio integer, id_client integer, id_cellar integer,  id_client_route integer, content TEXT, enviadoAnaquelero integer default 1, enviadoAsistencia integer default 1,  primary key (folio)); ";

    queries.add(_sql);

    _sql =
        "CREATE TABLE IF NOT EXISTS client_detail_other_route_local (folio integer, id_route TEXT, id_client integer, id_cellar integer, content TEXT, primary key (folio)); ";

    queries.add(_sql);

    _sql =
        "CREATE TABLE IF NOT EXISTS anaqueleros_to_manage_client_local (id_client_route integer, content TEXT, primary key (id_client_route)); ";

    queries.add(_sql);

    // Crea la base de datos en caso de que no exista y crea las tablas
    return openDatabase(join(await getDatabasesPath(), 'gestion.db'),
        onCreate: (db, version) async {
      for (String query in queries) {
        await db.execute(query);
      }
    }, version: 1);
  }

  // Inserta una instancia de client
  static Future<int> insertClient(Client item) async {
    Database database = await _openDB();

    return database.insert("client", item.toMap());
  }

  // Limpia la tabla local de client
  static Future<void> dropClient() async {
    Database database = await _openDB();
    final batch = database.batch();

    batch.delete("client");

    await batch.commit(noResult: true);
  }

  // Limpia la tabla local de eventClient
  static Future<void> dropEventClient() async {
    Database database = await _openDB();
    final batch = database.batch();

    batch.delete("eventClient");

    await batch.commit(noResult: true);
  }

  // Carga la tabla de client en un objeto List<Client>
  static Future<List<Client>> getClientDB() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> itemsMap = await database.query("client");

    return List.generate(
        itemsMap.length,
        (i) => Client(
            id_client_route: itemsMap[i]['id_client_route'].toString(),
            date: itemsMap[i]['date'].toString(),
            time_show: itemsMap[i]['time_show'].toString(),
            id_client: itemsMap[i]['id_client'].toString(),
            id_chain: itemsMap[i]['id_chain'].toString(),
            description: itemsMap[i]['description'].toString(),
            lowDate: itemsMap[i]['lowDate'].toString(),
            client_address: itemsMap[i]['client_address'].toString(),
            x_coordinate: itemsMap[i]['x_coordinate'].toString(),
            y_coordinate: itemsMap[i]['y_coordinate'].toString(),
            business_name: itemsMap[i]['business_name'].toString(),
            full_address: itemsMap[i]['full_address'].toString(),
            branch_office: itemsMap[i]['branch_office'].toString(),
            is_NOSIO: itemsMap[i]['is_NOSIO'].toString(),
            type_id: itemsMap[i]['type_id'].toString(),
            type_name: itemsMap[i]['type_name'].toString(),
            type_description: itemsMap[i]['type_description'].toString()));
  }

  // Regresa un objeto de tipo Client desde la base de datos local
  static Future<Client> getOneClientDB(String idClientRoute) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> itemsMap = await database.rawQuery(
        'select * from client where id_client_route = ?', [idClientRoute]);

    return Client(
        id_client_route: itemsMap[0]['id_client_route'].toString(),
        date: itemsMap[0]['date'].toString(),
        time_show: itemsMap[0]['time_show'].toString(),
        id_client: itemsMap[0]['id_client'].toString(),
        id_chain: itemsMap[0]['id_chain'].toString(),
        description: itemsMap[0]['description'].toString(),
        lowDate: itemsMap[0]['lowDate'].toString(),
        client_address: itemsMap[0]['client_address'].toString(),
        x_coordinate: itemsMap[0]['x_coordinate'].toString(),
        y_coordinate: itemsMap[0]['y_coordinate'].toString(),
        business_name: itemsMap[0]['business_name'].toString(),
        full_address: itemsMap[0]['full_address'].toString(),
        branch_office: itemsMap[0]['branch_office'].toString(),
        is_NOSIO: itemsMap[0]['is_NOSIO'].toString(),
        type_id: itemsMap[0]['type_id'].toString(),
        type_name: itemsMap[0]['type_name'].toString(),
        type_description: itemsMap[0]['type_description'].toString());
  }

  // Regresa un objeto de tipo homeInfo desde la base de datos local
  static Future<HomeInfo> getOneHomeInfoDB(String idClientRoute) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> itemsMap = await database.rawQuery(
        'select * from homeInfo where id_client_route = ?', [idClientRoute]);

    return HomeInfo(
        id_client_route: itemsMap[0]['id_client_route'].toString(),
        client_id: itemsMap[0]['client_id'].toString(),
        client_name: itemsMap[0]['client_name'].toString(),
        status_id_schedule: itemsMap[0]['status_id_schedule'].toString(),
        status_name_schedule: itemsMap[0]['status_name_schedule'].toString(),
        status_color_schedule: itemsMap[0]['status_color_schedule'].toString(),
        time_show: itemsMap[0]['time_show'].toString(),
        hours_show: itemsMap[0]['hours_show'].toString(),
        today_show: itemsMap[0]['today_show'].toString(),
        comment: itemsMap[0]['comment'].toString(),
        active: itemsMap[0]['active'].toString());
  }

  // Obtiene el número de registros de la tabla de client
  static Future<int?> getCountClient() async {
    Database database = await _openDB();
    var result = Sqflite.firstIntValue(
        await database.rawQuery("SELECT count(*) as num FROM client"));
    return result;
  }

  // Obtiene el número de registros de la tabla de eventClient con un tipo de evento
  static Future<int?> getSumIdCatalogEvent(String idCatalogEvent) async {
    Database database = await _openDB();
    var result = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT count(*) as num FROM eventClient where id_catalog_event = ? ",
        [idCatalogEvent]));
    return result;
  }

  // Inserta una instancia de homeInfo
  static Future<int> insertHomeInfo(HomeInfo item) async {
    Database database = await _openDB();
    var result = database.rawInsert('''
      insert into homeInfo(id_client_route, client_id, client_name, status_id_schedule, status_name_schedule,
      status_color_schedule, time_show, hours_show, today_show, comment, active ) 
      values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) 
    ''', [
      item.id_client_route.toString(),
      item.client_id.toString(),
      item.client_name.toString(),
      item.status_id_schedule.toString(),
      item.status_name_schedule.toString(),
      item.status_color_schedule,
      item.time_show.toString(),
      item.hours_show.toString(),
      item.today_show.toString(),
      item.comment.toString(),
      item.active.toString()
    ]);
    return result;
  }

  // Inserta una instancia de event
  static Future<int> insertEvent(Event item) async {
    Database database = await _openDB();
    //int numEvent = await getSumIdCatalogEvent(item.id_catalog_event);
    var result = database.rawInsert('''
      insert into event( id_catalog_event, name, description, times ) 
      values(?, ?, ?, ?) 
    ''', [
      item.id_catalog_event.toString(),
      item.name.toString(),
      item.description.toString(),
      item.times.toString()
    ]);
    return result;
  }

  // Inserta una instancia de eventClient
  static Future<int> insertEventClient(EventClient item) async {
    Database database = await _openDB();
    var result = database.rawInsert('''
      insert into eventClient (id_registered_event, id_client_route, id_catalog_event, x_coordinate, y_coordinate, created, created_gtm) 
      values(?, ?, ?, ?, ?, ?, ?) 
    ''', [
      item.id_registered_event.toString(),
      item.id_client_route.toString(),
      item.id_catalog_event.toString(),
      item.x_coordinate.toString(),
      item.y_coordinate.toString(),
      item.created.toString(),
      item.device_gtm,
    ]);
    return result;
  }

  // Inserta una instancia de backEvent
  static Future<int> insertBackEvent(
      EventClient item, String typeEvent, enviado) async {
    Database database = await _openDB();
    var result = database.rawInsert('''
      insert into backEvent (id_registered_event, id_client_route, id_catalog_event, x_coordinate, y_coordinate, device_date, device_gtm, type_event, enviado) 
      values(?, ?, ?, ?, ?, ?, ?, ?, ?)  
    ''', [
      item.id_registered_event.toString(),
      item.id_client_route.toString(),
      item.id_catalog_event.toString(),
      item.x_coordinate.toString(),
      item.y_coordinate.toString(),
      item.created.toString(),
      item.device_gtm.toString(),
      typeEvent,
      enviado
    ]);
    return result;
  }

  // Inserta una instancia de backCheck
  static Future<int> insertBackCheck(
      String id_client_route,
      x_coordinate,
      y_coordinate,
      device_date,
      device_gtm,
      description,
      type_check,
      image,
      enviado) async {
    Database database = await _openDB();
    var result = database.rawInsert('''
      insert into backCheck (id_client_route, x_coordinate, y_coordinate, device_date, device_gtm, description, type_check, b64Photo, enviado) 
      values(?, ?, ?, ?, ?, ?, ?, ?, ?)  
    ''', [
      id_client_route,
      x_coordinate,
      y_coordinate,
      device_date,
      device_gtm,
      description,
      type_check,
      image,
      enviado
    ]);
    return result;
  }

  // Limpia la tabla local de homeInfo
  static Future<void> dropHomeInfo() async {
    Database database = await _openDB();
    final batch = database.batch();

    batch.delete("homeInfo");

    await batch.commit(noResult: true);
  }

  // Limpia la tabla local de event
  static Future<void> dropEvent() async {
    Database database = await _openDB();
    final batch = database.batch();

    batch.delete("event");

    await batch.commit(noResult: true);
  }

  // Limpia la tabla local de backEvent
  static Future<void> dropBackEvent() async {
    Database database = await _openDB();
    final batch = database.batch();

    batch.delete("backEvent");

    await batch.commit(noResult: true);
  }

  // Limpia la tabla local de backCheck
  static Future<void> dropBackCheck() async {
    Database database = await _openDB();
    final batch = database.batch();

    batch.delete("backCheck");

    await batch.commit(noResult: true);
  }

  // Carga la tabla de homeInfo en un objeto List<HomeInfo>
  static Future<List<HomeInfo>> getHomeInfoDB() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> itemsMap =
        await database.query("homeInfo");

    return List.generate(
        itemsMap.length,
        (i) => HomeInfo(
            id_client_route: itemsMap[i]['id_client_route'].toString(),
            client_id: itemsMap[i]['client_id'].toString(),
            client_name: itemsMap[i]['client_name'].toString(),
            status_id_schedule: itemsMap[i]['status_id_schedule'].toString(),
            status_name_schedule:
                itemsMap[i]['status_name_schedule'].toString(),
            status_color_schedule:
                itemsMap[i]['status_color_schedule'].toString(),
            time_show: itemsMap[i]['time_show'].toString(),
            hours_show: itemsMap[i]['hours_show'].toString(),
            today_show: itemsMap[i]['today_show'].toString(),
            comment: itemsMap[i]['comment'].toString(),
            active: itemsMap[i]['active'].toString()));
  }

  // Carga la tabla de event en un objeto List<Event>
  static Future<List<Event>> getEventDB() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> itemsMap = await database.query("event");

    return List.generate(
        itemsMap.length,
        (i) => Event(
            id_catalog_event: itemsMap[i]['id_catalog_event'].toString(),
            name: itemsMap[i]['name'].toString(),
            description: itemsMap[i]['description'].toString(),
            times: itemsMap[i]['times'].toString(),
            count: itemsMap[i]['count'].toString()));
  }

  // Obtiene el número de registros de la tabla de homeInfo
  static Future<int?> getCountHomeInfo() async {
    Database database = await _openDB();
    var result = Sqflite.firstIntValue(
        await database.rawQuery("SELECT count(*) as num FROM client"));
    return result;
  }

  // Obtiene el número de registros de la tabla de homeInfo que están pendientes
  static Future<int?> getCountPendiente() async {
    Database database = await _openDB();
    var result = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT count(*) as num FROM homeInfo where status_id_schedule = '1' "));
    return result;
  }

  // Obtiene el número de registros de la tabla de homeInfo que están en curso
  static Future<int?> getCountEncurso() async {
    Database database = await _openDB();
    var result = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT count(*) as num FROM homeInfo where status_id_schedule = '2' "));
    return result;
  }

  // Obtiene el número de registros de la tabla de homeInfo que están terminadas
  static Future<int?> getCountTerminada() async {
    Database database = await _openDB();
    var result = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT count(*) as num FROM homeInfo where status_id_schedule = '3' "));
    return result;
  }

  // Actualiza checkin en tabla local homeInfo
  static Future<int> updateCheckin(
      String idClientRoute, x, y, day, hour, idStatus, nameStatus) async {
    Database database = await _openDB();
    var result = await database.rawUpdate('''
      update homeInfo 
      set x_checkin = ?, y_checkin = ?, date_checkin = ?, hour_checkin = ?, status_id_schedule = ?, status_name_schedule = ?
      where id_client_route = ?
    ''', [x, y, day, hour, idStatus, nameStatus, idClientRoute]);
    return result;
  }

  // Actualiza checkout en tabla local homeInfo
  static Future<int> updateCheckout(String idClientRoute, x, y, day, hour,
      comment, idStatus, nameStatus) async {
    Database database = await _openDB();
    var result = await database.rawUpdate('''
      update homeInfo 
      set x_checkout = ?, y_checkout = ?, date_checkout = ?, hour_checkout = ?, comment = ?, status_id_schedule = ?, status_name_schedule = ?, active = 'false'
      where id_client_route = ?
    ''', [x, y, day, hour, comment, idStatus, nameStatus, idClientRoute]);
    return result;
  }

  // Regresa el status del cliente
  static Future<String> getStatusClientDB(String idClientRoute) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> itemsMap = await database.rawQuery(
        'select status_id_schedule from homeInfo where id_client_route = ?',
        [idClientRoute]);
    return itemsMap[0]['status_id_schedule'].toString();
  }

  // Actualiza active = true en homeInfo
  static Future<int> updateActiveHomeInfo(String idClientRoute) async {
    Database database = await _openDB();
    var result = await database.rawUpdate('''
      update homeInfo 
      set active = 'true'
      where id_client_route = ?
    ''', [idClientRoute]);
    return result;
  }

  // Inserta una instancia de homeInfo
  static Future<void> insertEvents(
      String id_client_route, List<EventClient> items) async {
    Database database = await _openDB();
    for (var i = 0; i < items.length; i++) {
      if (items[i].is_event == '1') {
        database.rawInsert('''
            insert into eventClient (id_client_route, id_catalog_event, x_coordinate, y_coordinate, created, created_gtm, 
                  finished, finished_gtm, active ) 
            values(?, ?, ?, ?, ?, ?, ?, ?, ? ) 
            ''', [
          id_client_route,
          items[i].id_catalog_event.toString(),
          items[i].x_coordinate.toString(),
          items[i].y_coordinate.toString(),
          items[i].created.toString(),
          items[i].device_gtm.toString(),
          items[i].finished.toString(),
          items[i].device_gtm.toString(),
          items[i].active.toString()
          //'false'
        ]);
        insertBackEvent(items[i], Cnstds.startEvent, '1');
        if (items[i].active.toString() == 'false') {
          insertBackEvent(items[i], Cnstds.endEvent, '1');
        }
      } else if (items[i].is_checkin == '1') {
        await database.rawUpdate('''
           update homeInfo set x_checkin = ?, y_checkin = ?  
           where id_client_route = ?
           ''', [
          items[i].x_coordinate.toString(),
          items[i].y_coordinate.toString(),
          id_client_route
        ]);
        insertBackCheck(
            id_client_route,
            items[i].x_coordinate.toString(),
            items[i].y_coordinate.toString(),
            items[i].created,
            items[i].device_gtm,
            '',
            Cnstds.checkIn,
            '',
            '1');
      } else {
        await database.rawUpdate('''
           update homeInfo set x_checkout = ?, y_checkout = ?  
           where id_client_route = ?
           ''', [
          items[i].x_coordinate.toString(),
          items[i].y_coordinate.toString(),
          id_client_route
        ]);
        insertBackCheck(
            id_client_route,
            items[i].x_coordinate.toString(),
            items[i].y_coordinate.toString(),
            items[i].created,
            items[i].device_gtm,
            '',
            Cnstds.checkOut,
            '',
            '1');
      }

      //updateIncEvent(items[i].id_catalog_event.toString());
    }
  }

  // Obtiene el número de registros de la tabla de event
  static Future<int?> getCountEvent() async {
    Database database = await _openDB();
    var result = Sqflite.firstIntValue(
        await database.rawQuery("SELECT count(*) as num FROM event"));
    return result;
  }

  // Obtiene el número de registros de la tabla de client
  static Future<int?> getEventClient(String idClientRoute) async {
    Database database = await _openDB();
    var result = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT count(*) as num FROM eventClient where active = 'true' and id_client_route = ? ",
        [idClientRoute]));
    return result;
  }

  // Regresa el idRegisteredEvent del event activo para el cliente
  static Future<Map<String, dynamic>> getIdRegisteredEventDB(
      String idClientRoute) async {
    Map<String, dynamic> datos = Map<String, dynamic>();
    Database database = await _openDB();
    final List<Map<String, dynamic>> itemsMap = await database.rawQuery(
        "select id_registered_event, id_catalog_event from eventClient where id_client_route = ? and active = 'true' ",
        [idClientRoute]);
    if (itemsMap == null) {
      datos.addAll({'id_registered_event': '', 'id_catalog_event': ''});
    } else {
      datos.addAll({
        'id_registered_event': itemsMap[0]['id_registered_event'].toString(),
        'id_catalog_event': itemsMap[0]['id_catalog_event'].toString()
      });
    }
    return datos;
  }

  // Se obtiene el último registro de tipo appStartEvent
  static Future<Map<String, dynamic>> getBackEventStartDB() async {
    Map<String, dynamic> datos = Map<String, dynamic>();
    Database database = await _openDB();
    bool exist = false;
    final List<Map<String, dynamic>> itemsMap =
        await database.query("backEvent");
    if (itemsMap.length > 0)
      exist = (itemsMap[itemsMap.length - 1]['type_event'].toString() ==
          Cnstds.startEvent);

    if (!exist) {
      datos.addAll({'data': ''});
    } else {
      datos.addAll({'data': itemsMap[itemsMap.length - 1]});
    }
    return datos;
  }

  // Se obtiene el registro de backCheck con el type_chek = appChekIn
  static Future<Map<String, dynamic>> getBackCheckInDB(String idClient) async {
    Map<String, dynamic> datos = Map<String, dynamic>();
    Database database = await _openDB();
    final List<Map<String, dynamic>> itemsMap = await database.rawQuery(
        "select * from backCheck where type_check = ? and id_client_route = ? ",
        [Cnstds.checkIn, idClient]);

    if (itemsMap == null) {
      datos.addAll({'data': ''});
    } else {
      datos.addAll({'data': itemsMap[0]});
    }
    return datos;
  }

  // Actualiza el evento activo de un cliente
  static Future<int> updateEventClient(
      String idRegisteredEvent, deviceDate, deviceGTM) async {
    Database database = await _openDB();
    var result = await database.rawUpdate('''
      update eventClient set active = 'false', finished = ?, finished_gtm = ? 
      where id_registered_event = ?
    ''', [deviceDate, idRegisteredEvent, deviceGTM]);
    return result;
  }

  // Actualiza la tabla backEvent con el id_registered_event y enviado tipo appStartEvent
  static Future<int> updateCheckEventEnviado(
      String folio, idRegisteredEvent) async {
    Database database = await _openDB();
    var result = await database.rawUpdate('''
      update backEvent set id_registered_event = ?, enviado = ?
      where folio = ?
    ''', [idRegisteredEvent, '1', folio]);
    return result;
  }

  // Actualiza la tabla backCheck con el checkin enviado
  static Future<int> updateCheckEnviado(String idClient, typeCheck) async {
    Database database = await _openDB();
    var result = await database.rawUpdate('''
      update backCheck set enviado = ?
      where type_check = ? and id_client_route = ?
    ''', ['1', typeCheck, idClient]);
    return result;
  }

// Incrementa count en tabla event
  static Future<int> updateIncEvent(String idCatalogEvent) async {
    Database database = await _openDB();
    var result = await database.rawUpdate('''
      update event set count = count + 1
      where id_catalog_event = ?
    ''', [idCatalogEvent]);
    return result;
  }

  // Elimina un registro de la tabla backEvent por folio
  static Future<int> deleteBackEvent(String folio) async {
    Database database = await _openDB();
    var result = await database.rawDelete('''
      delete from backEvent where folio = ?
    ''', [folio]);
    await database.close();
    return result;
  }

  // Notificación de envios pendientes al servidor
  static Future<bool> pendingShipping() async {
    Map<String, dynamic> datos = Map<String, dynamic>();
    Database database = await _openDB();
    var countEvent = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT count(*) as num FROM backEvent where enviado = '0' "));
    var countCheck = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT count(*) as num FROM backCheck where enviado = '0' "));
    bool send = (countEvent! + countCheck!) > 0;
    return send;
  }

  // Carga la tabla de backEvent con registros no enviados
  static Future<List<BackEvent>> getBackEventSendDB() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> itemsMap =
        await database.rawQuery("select * from backEvent");

    return List.generate(
        itemsMap.length,
        (i) => BackEvent(
            folio: itemsMap[i]['folio'].toString(),
            id_registered_event: itemsMap[i]['id_registered_event'].toString(),
            id_client_route: itemsMap[i]['id_client_route'].toString(),
            id_catalog_event: itemsMap[i]['id_catalog_event'].toString(),
            x_coordinate: itemsMap[i]['x_coordinate'].toString(),
            y_coordinate: itemsMap[i]['y_coordinate'].toString(),
            device_date: itemsMap[i]['device_date'].toString(),
            device_gtm: itemsMap[i]['device_gtm'].toString(),
            type_event: itemsMap[i]['type_event'].toString(),
            enviado: itemsMap[i]['enviado'].toString()));
  }

  // Carga la tabla de backCheck con registros no enviados
  static Future<List<BackCheck>> getBackCheckWithoutSendDB() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> itemsMap = await database.rawQuery(
        "select * from backCheck where enviado = '0' order by folio ");

    return List.generate(
        itemsMap.length,
        (i) => BackCheck(
            folio: itemsMap[i]['folio'].toString(),
            id_client_route: itemsMap[i]['id_client_route'].toString(),
            x_coordinate: itemsMap[i]['x_coordinate'].toString(),
            y_coordinate: itemsMap[i]['y_coordinate'].toString(),
            device_date: itemsMap[i]['device_date'].toString(),
            device_gtm: itemsMap[i]['device_gtm'].toString(),
            description: itemsMap[i]['description'].toString(),
            type_check: itemsMap[i]['type_check'].toString(),
            enviado: itemsMap[i]['enviado'].toString()));
  }

  // Actualiza name y description de la tabla event
  static Future<int> updateEventList(
      String idCatalogEvent, name, description) async {
    Database database = await _openDB();
    var result = await database.rawUpdate('''
      update event 
      set name = ?, description = ? 
      where id_catalog_event = ?
    ''', [name, description, idCatalogEvent]);
    return result;
  }

  // Limpia la tabla local de client_detail_sup_local
  static Future<void> dropClientDetailSupLocal() async {
    Database database = await _openDB();
    final batch = database.batch();

    batch.delete("client_detail_sup_local");

    await batch.commit(noResult: true);
  }

  // Inserta una instancia de client_detail_sup_local
  static Future<int> insertClientDetailSupLocal(
      ClientDetailSupLocal item) async {
    Database database = await _openDB();

    return database.insert("client_detail_sup_local", item.toMap());
  }

  // Notificación de envios pendientes al servidor
  static Future<bool> pendingShippingAgenda() async {
    Map<String, dynamic> datos = Map<String, dynamic>();
    Database database = await _openDB();
    var count = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT count(*) as num FROM client_detail_sup_local where enviadoAnaquelero = 0 or enviadoAsistencia = 0"));
    bool send = count! > 0;
    return send;
  }

  // Regresa un objeto de tipo client_detail_sup_local desde la base de datos local
  static Future<ClientDetailSupLocal> getOneClientDetailSupLocal(
      String? idClient, idCellar, idClientRoute) async {
    if (idClientRoute == '') idClientRoute = '0';
    if (idClientRoute == null) idClientRoute = '0';
    Database database = await _openDB();
    final List<Map<String, dynamic>> itemsMap = await database.rawQuery(
        'select * from client_detail_sup_local where id_client = ? and id_cellar = ? and id_client_route = ?',
        [idClient, idCellar, idClientRoute]);

    return ClientDetailSupLocal(
        id_client: itemsMap[0]['id_client'],
        id_cellar: itemsMap[0]['id_cellar'],
        id_client_route: itemsMap[0]['id_client_route'],
        content: itemsMap[0]['content'].toString(),
        enviadoAnaquelero: itemsMap[0]['enviadoAnaquelero'],
        enviadoAsistencia: itemsMap[0]['enviadoAsistencia']);
  }

  // Actualiza content en tabla local client_detail_sup_local
  static Future<int> updateClientDetailSupLocal(
      String idClient, idCellar, idClientRoute, content) async {
    Database database = await _openDB();
    var result = await database.rawUpdate('''
      update client_detail_sup_local 
      set content = ?, enviadoAnaquelero = 1, enviadoAsistencia = 1  
      where id_client = ? and id_cellar = ? and id_client_route = ?
    ''', [content, idClient, idCellar, idClientRoute]);
    return result;
  }

  static Future<int> markAssistanceBySupervisor(
      String idClient, idCellar, idClientRoute, content) async {
    Database database = await _openDB();
    var result = await database.rawUpdate('''
      update client_detail_sup_local 
      set content = ?, enviadoAsistencia = 0  
      where id_client = ? and id_cellar = ? and id_client_route = ?
    ''', [content, idClient, idCellar, idClientRoute]);
    return result;
  }

  static Future<int> reassignReplacementAnaquelero(
      String idClient, idCellar, idClientRoute, content) async {
    Database database = await _openDB();
    var result = await database.rawUpdate('''
      update client_detail_sup_local 
      set content = ?, enviadoAnaquelero = 0  
      where id_client = ? and id_cellar = ? and id_client_route = ?
    ''', [content, idClient, idCellar, idClientRoute]);
    return result;
  }

  // Obtiene si existe el dato en client_detail_sup_local
  static Future<int?> existClientDetailSupLocal(
      String? idClient, idCellar, idClientRoute) async {
    if (idClientRoute == '') idClientRoute = '0';
    if (idClientRoute == null) idClientRoute = '0';
    Database database = await _openDB();
    var result = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT count(*) as num FROM client_detail_sup_local where id_client = ? and id_cellar = ? and id_client_route = ? ",
        [idClient, idCellar, idClientRoute]));
    return result;
  }

  // Carga la tabla de client_detail_sup_local en un objeto List<ClientDetailSupLocal>
  static Future<List<ClientDetailSupLocal>>
      getListClientDetailSupLocalSinEnviar() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> itemsMap = await database.rawQuery(
        'select * from client_detail_sup_local where enviadoAnaquelero = 0 or enviadoAsistencia = 0');

    return List.generate(
        itemsMap.length,
        (i) => ClientDetailSupLocal(
            id_client: itemsMap[i]['id_client'],
            id_cellar: itemsMap[i]['id_cellar'],
            id_client_route: itemsMap[i]['id_client_route'],
            content: itemsMap[i]['content'].toString(),
            enviadoAnaquelero: itemsMap[i]['enviadoAnaquelero'],
            enviadoAsistencia: itemsMap[i]['enviadoAsistencia']));
  }

  // Limpia la tabla local de client_detail_other_route_local
  static Future<void> dropClientDetailOtherRouteLocal() async {
    Database database = await _openDB();
    final batch = database.batch();

    batch.delete("client_detail_other_route_local");

    await batch.commit(noResult: true);
  }

  // Inserta una instancia de client_detail_other_route_local
  static Future<int> insertClientDetailOtherRouteLocal(
      ClientDetailOtherRouteLocal item) async {
    Database database = await _openDB();

    return database.insert("client_detail_other_route_local", item.toMap());
  }

  // Regresa un objeto de tipo client_detail_other_route_local desde la base de datos local
  static Future<ClientDetailOtherRouteLocal> getOneClientDetailOtherRouteLocal(
      String idRoute, idClient, idCellar) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> itemsMap = await database.rawQuery(
        'select * from client_detail_other_route_local where id_route = ? and id_client = ? and id_cellar = ?',
        [idRoute, idClient, idCellar]);

    return ClientDetailOtherRouteLocal(
        id_route: itemsMap[0]['id_route'].toString(),
        id_client: itemsMap[0]['id_client'],
        id_cellar: itemsMap[0]['id_cellar'],
        content: itemsMap[0]['content'].toString());
  }

  // Actualiza content en tabla local client_detail_other_route_local
  static Future<int> updateClientDetailOtherRouteLocal(
      String idRoute, idClient, idCellar, content) async {
    Database database = await _openDB();
    var result = await database.rawUpdate('''
      update client_detail_other_route_local 
      set content = ?  
      where id_route = ? and id_client = ? and id_cellar = ?  
    ''', [content, idRoute, idClient, idCellar]);
    return result;
  }

  // Obtiene si existe el dato en client_detail_other_route_local
  static Future<int?> existClientDetailOtherRouteLocal(
      String? idRoute, idClient, idCellar) async {
    Database database = await _openDB();
    var result = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT count(*) as num FROM client_detail_other_route_local where id_route = ? and id_client = ? and id_cellar = ? ",
        [
          idRoute,
          idClient,
          idCellar,
        ]));
    return result;
  }

  // Limpia la tabla local de anaqueleros_to_manage_client_local
  static Future<void> dropAnaquelerosToManageClientLocal() async {
    Database database = await _openDB();
    final batch = database.batch();

    batch.delete("anaqueleros_to_manage_client_local");

    await batch.commit(noResult: true);
  }

  // Inserta una instancia de anaqueleros_to_manage_client_local
  static Future<int> insertAnaquelerosToManageClientLocal(
      AnaquelerosToManageClientLocal item) async {
    Database database = await _openDB();

    return await database.insert(
        "anaqueleros_to_manage_client_local", item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Regresa un objeto de tipo anaqueleros_to_manage_client_local desde la base de datos local
  static Future<AnaquelerosToManageClientLocal?>
      getOneAnaquelerosToManageClientLocal(String idClientRoute) async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> itemsMap = await database.rawQuery(
        'select * from anaqueleros_to_manage_client_local where id_client_route = ?',
        [idClientRoute]);

    if (itemsMap.isEmpty) {
      return null;
    } else {
      return AnaquelerosToManageClientLocal(
          id_client_route: itemsMap[0]['id_client_route'],
          content: itemsMap[0]['content'].toString());
    }
  }
}

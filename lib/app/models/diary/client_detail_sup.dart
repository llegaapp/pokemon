import '../../config/utils.dart';

class ClientDetailSup {
  String? id_client_route;
  String? client_id;
  String? client_name;
  String? cellar_id;
  String? cellar_name;
  String? client_show;
  String? cellar_show;
  String? status_id;
  String? status_name;
  String? status_color;
  String? start_time;
  String? end_time;
  String? time_show;
  String? diff_time_show;
  String? activity_hours_show;
  String? diff_activity_hours_show;
  Checkin? checkin;
  Comida? comida;
  Checkout? checkout;
  String? client_address;
  String? route_show_anaq;
  String? anaquelero;
  String id_anaquelero;
  String? type_assign_anaq;
  String? id_team_type;
  String? team_type;

  ClientDetailSup(
      {this.id_client_route,
      this.client_id,
      this.client_name,
      this.cellar_id,
      this.cellar_name,
      this.client_show,
      this.cellar_show,
      this.status_id,
      this.status_name,
      this.status_color,
      this.start_time,
      this.end_time,
      this.time_show,
      this.diff_time_show,
      this.activity_hours_show,
      this.diff_activity_hours_show,
      this.checkin,
      this.comida,
      this.checkout,
      this.client_address,
      this.route_show_anaq,
      this.anaquelero,
      required this.id_anaquelero,
      this.type_assign_anaq,
      this.id_team_type,
      this.team_type});

  factory ClientDetailSup.fromJson(Map<String, dynamic> json) {
    var _checkin;
    var _checkout;
    var _comida;
    var _route_show_anaq;
    var _anaquelero;
    var _id_anaquelero;
    var _type_assign_anaq;
    var _id_team_type;
    var _team_type;

    if (json['events'] != null) {
      if (json['events']['checkin'] != null) {
        _checkin = Checkin(
          time_start: json['events']['checkin']['time_start'].toString(),
          diff: json['events']['checkin']['diff'].toString(),
          distance: json['events']['checkin']['distance'] ?? '',
          color: json['events']['checkin']['color'].toString(),
        );
      }
      if (json['events']['checkout'] != null) {
        _checkout = Checkout(
          time_start: json['events']['checkout']['time_start'].toString(),
          diff: json['events']['checkout']['diff'].toString(),
          distance: json['events']['checkout']['distance'] ?? '',
          color: json['events']['checkout']['color'].toString(),
        );
      }
      if (json['events']['comida'] != null) {
        _comida = Comida(
          time_start: json['events']['comida']['time_start'].toString(),
          time_end: json['events']['comida']['time_end'].toString(),
          created: json['events']['comida']['created'].toString(),
          current: json['events']['comida']['current'].toString(),
        );
      }
    }

    if (json['anaquelero'] != null) {
      _route_show_anaq = json['anaquelero']['route_show'].toString();
      _anaquelero = json['anaquelero']['anaquelero'].toString();
      _id_anaquelero = json['anaquelero']['id_anaquelero'].toString();
      _type_assign_anaq = json['anaquelero']['type_assign'].toString();
      _id_team_type = json['anaquelero']['id_team_type'].toString();
      _team_type = json['anaquelero']['team_type'].toString();
    }

    return ClientDetailSup(
      id_client_route: json['id_client_route'].toString(),
      client_id: json['client_id'].toString(),
      client_name: json['client_name'].toString(),
      cellar_id: json['cellar_id'].toString(),
      cellar_name: json['cellar_name'].toString(),
      client_show: json['client_show'].toString(),
      cellar_show: json['cellar_show'].toString(),
      status_id: json['status_id'].toString(),
      status_name: json['status_name'].toString(),
      status_color: json['status_color'].toString(),
      start_time: json['start_time'].toString(),
      end_time: json['end_time'].toString(),
      time_show: json['time_show'].toString(),
      diff_time_show: json['diff_time_show'].toString(),
      activity_hours_show: json['activity_hours_show'].toString(),
      diff_activity_hours_show: json['diff_activity_hours_show'].toString(),
      checkin: _checkin,
      comida: _comida,
      checkout: _checkout,
      client_address: json['client_address'].toString(),
      route_show_anaq: _route_show_anaq,
      anaquelero: _anaquelero,
      id_anaquelero: _id_anaquelero,
      type_assign_anaq: _type_assign_anaq,
      id_team_type: _id_team_type,
      team_type: _team_type,
    );
  }

  static ClientDetailSup clientDetailSupfromJson(
      {required Map<String, dynamic> json, String source = 'api'}) {
    var _checkin;
    var _checkout;
    var _comida;
    var _route_show_anaq;
    var _anaquelero = '';
    var _id_anaquelero = '';
    var _type_assign_anaq;
    var _id_team_type;
    var _team_type;
    var dateTimeLocal = '';
    var dateTimeEndLocal = '';
    var dateTimeCurrentLocal = '';
    String device_date = '';
    String device_gtm = '0';

    if (source == 'api') {
      if (json['events'] != null) {
        if (json['events']['checkin'] != null) {
          if (json['events']['checkin']['device_date'].toString() != 'null') {
            device_date = json['events']['checkin']['device_date'].toString();
            device_gtm = json['events']['checkin']['device_gtm'].toString();
            dateTimeLocal =
                Utils.getUTCToDateTimeLocal(device_date, int.parse(device_gtm));
          } else {
            dateTimeLocal = json['events']['checkin']['time_start'].toString();
          }
          _checkin = Checkin(
            time_start: dateTimeLocal,
            diff: json['events']['checkin']['diff'].toString(),
            distance: json['events']['checkin']['distance'] ?? 'Supervisor',
            color: json['events']['checkin']['color'].toString(),
          );
        }
        if (json['events']['checkout'] != null) {
          if (json['events']['checkout']['device_date'].toString() != 'null') {
            device_date = json['events']['checkout']['device_date'].toString();
            device_gtm = json['events']['checkout']['device_gtm'].toString();
            dateTimeLocal =
                Utils.getUTCToDateTimeLocal(device_date, int.parse(device_gtm));
          } else {
            dateTimeLocal = json['events']['checkout']['time_start'].toString();
          }

          _checkout = Checkout(
            time_start: dateTimeLocal,
            diff: json['events']['checkout']['diff'].toString(),
            distance: json['events']['checkout']['distance'] ?? 'Supervisor',
            color: json['events']['checkout']['color'].toString(),
          );
        }
        if (json['events']['comida'] != null) {
          if (json['events']['comida']['device_date'].toString() != 'null') {
            device_date = json['events']['comida']['device_date'].toString();
            device_gtm = json['events']['comida']['device_gtm'].toString();
            dateTimeLocal =
                Utils.getUTCToDateTimeLocal(device_date, int.parse(device_gtm));
          } else {
            dateTimeLocal = json['events']['ccomida']['time_start'].toString();
          }
          if (json['events']['comida']['end_device_date'].toString() !=
              'null') {
            device_date =
                json['events']['comida']['end_device_date'].toString();
            device_gtm = json['events']['comida']['end_device_gtm'].toString();
            dateTimeEndLocal =
                Utils.getUTCToDateTimeLocal(device_date, int.parse(device_gtm));
          } else {
            dateTimeEndLocal = json['events']['comida']['time_end'].toString();
          }
          if (json['events']['comida']['current_device_date'].toString() !=
              'null') {
            device_date =
                json['events']['comida']['current_device_date'].toString();
            device_gtm = json['events']['comida']['device_gtm'].toString();
            dateTimeCurrentLocal =
                Utils.getUTCToDateTimeLocal(device_date, int.parse(device_gtm));
          } else {
            dateTimeEndLocal = json['events']['comida']['current'].toString();
          }

          _comida = Comida(
            time_start: dateTimeLocal,
            time_end: dateTimeEndLocal,
            created: json['events']['comida']['created'].toString(),
            current: dateTimeCurrentLocal,
            toeat: json['events']['comida']['time_end'].toString() == 'null',
          );
        }
      }
    } else {
      if (json['checkin'] != null) {
        _checkin = Checkin(
          time_start: json['checkin']['time_start'].toString(),
          diff: json['checkin']['diff'].toString(),
          distance: json['checkin']['distance'] ?? 'Supervisor',
          color: json['checkin']['color'].toString(),
        );
      }
      if (json['checkout'] != null) {
        _checkout = Checkout(
          time_start: json['checkout']['time_start'].toString(),
          diff: json['checkout']['diff'].toString(),
          distance: json['checkout']['distance'] ?? 'Supervisor',
          color: json['checkout']['color'].toString(),
        );
      }
    }

    if (source == 'api') {
      if (json['anaquelero'] != null) {
        _route_show_anaq = json['anaquelero']['route_show'].toString();
        _anaquelero = json['anaquelero']['anaquelero'].toString();
        _id_anaquelero = json['anaquelero']['id_anaquelero'].toString();
        _type_assign_anaq = json['anaquelero']['type_assign'].toString();
        _id_team_type = json['anaquelero']['id_team_type'].toString();
        _team_type = json['anaquelero']['team_type'].toString();
      }
    } else {
      _route_show_anaq = json['route_show_anaq'].toString();
      _anaquelero = json['anaquelero'].toString();
      _id_anaquelero = json['id_anaquelero'].toString();
      _type_assign_anaq = json['type_assign_anaq'].toString();
      _id_team_type = json['id_team_type'].toString();
      _team_type = json['team_type'].toString();
    }

    return ClientDetailSup(
      id_client_route: json['id_client_route'].toString(),
      client_id: json['client_id'].toString(),
      client_name: json['client_name'].toString(),
      cellar_id: json['cellar_id'].toString(),
      cellar_name: json['cellar_name'].toString(),
      client_show: json['client_show'].toString(),
      cellar_show: json['cellar_show'].toString(),
      status_id: json['status_id'].toString(),
      status_name: json['status_name'].toString(),
      status_color: json['status_color'].toString(),
      start_time: json['start_time'].toString(),
      end_time: json['end_time'].toString(),
      time_show: json['time_show'].toString(),
      diff_time_show: json['diff_time_show'].toString(),
      activity_hours_show: json['activity_hours_show'].toString(),
      diff_activity_hours_show: json['diff_activity_hours_show'].toString(),
      checkin: _checkin,
      comida: _comida,
      checkout: _checkout,
      client_address: json['client_address'].toString(),
      route_show_anaq: _route_show_anaq,
      anaquelero: _anaquelero,
      id_anaquelero: _id_anaquelero,
      type_assign_anaq: _type_assign_anaq,
      id_team_type: _id_team_type,
      team_type: _team_type,
    );
  }

  factory ClientDetailSup.Copy(ClientDetailSup o) {
    return ClientDetailSup(
      id_client_route: o.id_client_route,
      client_id: o.client_id,
      client_name: o.client_name,
      cellar_id: o.cellar_id,
      cellar_name: o.cellar_name,
      client_show: o.client_show,
      cellar_show: o.cellar_show,
      status_id: o.status_id,
      status_name: o.status_name,
      status_color: o.status_color,
      start_time: o.start_time,
      end_time: o.end_time,
      time_show: o.time_show,
      diff_time_show: o.diff_time_show,
      activity_hours_show: o.activity_hours_show,
      diff_activity_hours_show: o.diff_activity_hours_show,
      checkin: o.checkin,
      comida: o.comida,
      checkout: o.checkout,
      client_address: o.client_address,
      route_show_anaq: o.route_show_anaq,
      anaquelero: o.anaquelero,
      id_anaquelero: o.id_anaquelero,
      type_assign_anaq: o.type_assign_anaq,
      id_team_type: o.id_team_type,
      team_type: o.team_type,
    );
  }

  Map<String, dynamic> toJson(ClientDetailSup item) {
    Map<String, dynamic>? _checkin =
        item.checkin != null ? item.checkin!.toJson(item.checkin) : null;
    Map<String, dynamic>? _checkout =
        item.checkout != null ? item.checkout!.toJson(item.checkout) : null;
    Map<String, dynamic>? _comida =
        item.comida != null ? item.comida!.toJson(item.comida) : null;

    return <String, dynamic>{
      'id_client_route': item.id_client_route,
      'client_id': item.client_id,
      'client_name': item.client_name,
      'cellar_id': item.cellar_id,
      'cellar_name': item.cellar_name,
      'client_show': item.client_show,
      'cellar_show': item.cellar_show,
      'status_id': item.status_id,
      'status_name': item.status_name,
      'status_color': item.status_color,
      'start_time': item.start_time,
      'end_time': item.end_time,
      'time_show': item.time_show,
      'diff_time_show': item.diff_time_show,
      'checkin': _checkin,
      'comida': _comida,
      'checkout': _checkout,
      'client_address': item.client_address,
      'route_show_anaq': item.route_show_anaq,
      'anaquelero': item.anaquelero,
      'id_anaquelero': item.id_anaquelero,
      'activity_hours_show': item.activity_hours_show,
      'diff_activity_hours_show': item.diff_activity_hours_show,
      'type_assign_anaq': item.type_assign_anaq,
      'id_team_type': item.id_team_type,
      'team_type': item.team_type,
    };
  }
}

class Checkin {
  String? time_start;
  String? diff;
  String? distance;
  String? color;

  Checkin({this.time_start, this.diff, this.distance, this.color});

  Map<String, dynamic> toJson(Checkin? item) {
    return <String, dynamic>{
      'time_start': item!.time_start,
      'diff': item.diff,
      'distance': item.distance,
      'color': item.color,
    };
  }
}

class Checkout {
  String? time_start;
  String? diff;
  String? distance;
  String? color;

  Checkout({this.time_start, this.diff, this.distance, this.color});

  Map<String, dynamic> toJson(Checkout? item) {
    return <String, dynamic>{
      'time_start': item!.time_start,
      'diff': item.diff,
      'distance': item.distance,
      'color': item.color,
    };
  }
}

class Comida {
  String? time_start;
  String? time_end;
  String? created;
  String? current;
  bool? toeat;

  Comida(
      {this.time_start, this.time_end, this.created, this.current, this.toeat});

  Map<String, dynamic> toJson(Comida? item) {
    return <String, dynamic>{
      'time_start': item!.time_start,
      'time_end': item.time_end,
      'created': item.created,
      'current': item.current,
      'toeat': item.toeat,
    };
  }
}

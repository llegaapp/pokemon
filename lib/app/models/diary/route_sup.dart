class RouteSup {
  String? id_route;
  String? name_route;
  String? route_show;
  String? id_supervisor_base_team;
  String? name_supervisor_base_team;
  String? id_anaquelero_base_team;
  String? name_anaquelero_base_team;
  String? week_days_base_team;
  String? id_supervisor_backup_team;
  String? name_supervisor_backup_team;
  String? id_anaquelero_backup_team;
  String? name_anaquelero_backup_team;
  String? week_days_backup_team;
  String? id_team_type;
  String? team_type;
  List<DiaryClient>? diary_client_list;
  bool? selected;

  RouteSup(
      {this.id_route,
      this.name_route,
      this.route_show,
      this.id_supervisor_base_team,
      this.name_supervisor_base_team,
      this.id_anaquelero_base_team,
      this.name_anaquelero_base_team,
      this.week_days_base_team,
      this.id_supervisor_backup_team,
      this.name_supervisor_backup_team,
      this.id_anaquelero_backup_team,
      this.name_anaquelero_backup_team,
      this.week_days_backup_team,
      this.id_team_type,
      this.team_type,
      this.diary_client_list,
      this.selected});

  factory RouteSup.fromJson(Map<String, dynamic> json) {
    var _listClient;

    if (json['diary'] != null) {
      var items = json['diary'];
      var t = items.map((f) => DiaryClient.fromJson(f)).toList();
      _listClient = t.cast<DiaryClient>().toList();
    }
    return RouteSup(
      id_route: json['id_route'].toString(),
      name_route: json['name_route'].toString(),
      route_show: json['route_show'].toString(),
      id_supervisor_base_team: json['id_supervisor_base_team'].toString(),
      name_supervisor_base_team: json['name_supervisor_base_team'].toString(),
      id_anaquelero_base_team: json['id_anaquelero_base_team'].toString(),
      name_anaquelero_base_team: json['name_anaquelero_base_team'].toString(),
      week_days_base_team: json['week_days_base_team'].toString(),
      id_supervisor_backup_team: json['id_supervisor_backup_team'].toString(),
      name_supervisor_backup_team:
          json['name_supervisor_backup_team'].toString(),
      id_anaquelero_backup_team: json['id_anaquelero_backup_team'].toString(),
      name_anaquelero_backup_team:
          json['name_anaquelero_backup_team'].toString(),
      week_days_backup_team: json['week_days_backup_team'].toString(),
      id_team_type: json['id_team_type'].toString(),
      team_type: json['team_type'].toString(),
      diary_client_list: _listClient,
      selected: json['selected'] == null
          ? false
          : json['selected'].toString() == 'true',
    );
  }
  String toString() {
    return 'RouteSup( id_route:$id_route,\n'
        'name_route:$name_route,\n'
        'route_show:$route_show,\n'
        'id_supervisor_base_team:$id_supervisor_base_team,\n'
        'name_supervisor_base_team:$name_supervisor_base_team,\n'
        'id_anaquelero_base_team:$id_anaquelero_base_team,\n'
        'name_anaquelero_base_team:$name_anaquelero_base_team,\n'
        'week_days_base_team:$week_days_base_team,\n'
        'id_supervisor_backup_team:$id_supervisor_backup_team,\n'
        'name_supervisor_backup_team:$name_supervisor_backup_team,\n'
        'id_anaquelero_backup_team:$id_anaquelero_backup_team,\n'
        'name_anaquelero_backup_team:$name_anaquelero_backup_team,\n'
        'week_days_backup_team:$week_days_backup_team,\n'
        'id_team_type:$id_team_type,\n'
        'team_type:$team_type,\n'
        'diary_client_list:$diary_client_list,\n '
        'selected:$selected,\n'
        ')';
  }

  Map<String, dynamic> toJson(RouteSup item) {
    List<Map<String, dynamic>>? _diary_client_list =
        item.diary_client_list != null
            ? item.diary_client_list!.map((i) => i.toJson(i)).toList()
            : null;

    return <String, dynamic>{
      'id_route': item.id_route,
      'name_route': item.name_route,
      'route_show': item.route_show,
      'id_supervisor_base_team': item.id_supervisor_base_team,
      'name_supervisor_base_team': item.name_supervisor_base_team,
      'id_anaquelero_base_team': item.id_anaquelero_base_team,
      'name_anaquelero_base_team': item.name_anaquelero_base_team,
      'week_days_base_team': item.week_days_base_team,
      'id_supervisor_backup_team': item.id_supervisor_backup_team,
      'name_supervisor_backup_team': item.name_supervisor_backup_team,
      'id_anaquelero_backup_team': item.id_anaquelero_backup_team,
      'name_anaquelero_backup_team': item.name_anaquelero_backup_team,
      'week_days_backup_team': item.week_days_backup_team,
      'id_team_type': item.id_team_type,
      'team_type': item.team_type,
      'diary': _diary_client_list,
      'selected': item.selected,
    };
  }
}

class DiaryClient {
  String? id_client;
  String? name_client;
  String? id_cellar;
  String? name_cellar;
  String? start_time;
  String? end_time;
  String? hours;
  String? id_status;
  String? name_status;
  String? color_status;
  String? id_client_route;
  bool visible = true;

  DiaryClient(
      {this.id_client,
      this.name_client,
      this.id_cellar,
      this.name_cellar,
      this.start_time,
      this.end_time,
      this.hours,
      this.id_status,
      this.name_status,
      this.color_status,
      this.id_client_route,
      visible = true});

  factory DiaryClient.fromJson(Map<String, dynamic> json) {
    return DiaryClient(
      id_client: json['id_client'].toString() == ''
          ? '0'
          : json['id_client'].toString(),
      name_client: json['name_client'].toString(),
      id_cellar: json['id_cellar'].toString() == ''
          ? '0'
          : json['id_cellar'].toString(),
      name_cellar: json['name_cellar'].toString(),
      start_time: json['start_time'].toString(),
      end_time: json['end_time'].toString(),
      hours: json['hours'].toString(),
      id_status: json['id_status'].toString() == ''
          ? '0'
          : json['id_status'].toString(),
      name_status: json['name_status'].toString(),
      color_status: json['color_status'].toString(),
      id_client_route: json['id_client_route'].toString() == ''
          ? '0'
          : json['id_client_route'].toString(),
    );
  }

  Map<String, dynamic> toJson(DiaryClient o) => <String, dynamic>{
        'id_client': o.id_client,
        'name_client': o.name_client,
        'id_cellar': o.id_cellar,
        'name_cellar': o.name_cellar,
        'start_time': o.start_time,
        'end_time': o.end_time,
        'hours': o.hours,
        'id_status': o.id_status,
        'name_status': o.name_status,
        'color_status': o.color_status,
        'id_client_route': o.id_client_route,
      };

  factory DiaryClient.Copy(DiaryClient o) {
    return DiaryClient(
      id_client: o.id_client,
      name_client: o.name_client,
      id_cellar: o.id_cellar,
      name_cellar: o.name_cellar,
      start_time: o.start_time,
      end_time: o.end_time,
      hours: o.hours,
      id_status: o.id_status,
      name_status: o.name_status,
      color_status: o.color_status,
      id_client_route: o.id_client_route,
    );
  }
}

class TeamListBySupervisor {
  bool? is_day_closed;
  String? attendance_count;
  String? absence_count;
  List<Team>? attendance_list;
  List<Team>? absence_list;
  List<Team>? all;

  TeamListBySupervisor({
    this.is_day_closed,
    this.attendance_count,
    this.absence_count,
    this.attendance_list,
    this.absence_list,
    this.all,
  });

  factory TeamListBySupervisor.fromJson(Map<String, dynamic> json) {
    var _attendanceList;
    var _absenceList;
    var _allList;
    if (json['attendance_list'] != null) {
      var items = json['attendance_list'];
      var t = items.map((f) => Team.fromJson(f)).toList();
      _attendanceList = t.cast<Team>().toList();
    }
    if (json['absence_list'] != null) {
      var items = json['absence_list'];
      var t = items.map((f) => Team.fromJson(f)).toList();
      _absenceList = t.cast<Team>().toList();
    }
    if (json['all'] != null) {
      var items = json['all'];
      var t = items.map((f) => Team.fromJson(f)).toList();
      _allList = t.cast<Team>().toList();
    }
    return TeamListBySupervisor(
      attendance_count:
          json['attendance_count'] == null || json['attendance_count'] == 'null'
              ? '0'
              : json['attendance_count'],
      absence_count:
          json['absence_count'] == null || json['absence_count'] == 'null'
              ? '0'
              : json['absence_count'],
      attendance_list: _attendanceList,
      absence_list: _absenceList,
      all: _allList,
      is_day_closed: json['is_day_closed'] == 'true' ? true : false,
    );
  }

  Map<String, dynamic> toJson(TeamListBySupervisor item) {
    List<Map<String, dynamic>>? _attendanceList = item.attendance_list != null
        ? item.attendance_list!.map((i) => i.toJson(i)).toList()
        : null;
    List<Map<String, dynamic>>? _absenceList = item.absence_list != null
        ? item.absence_list!.map((i) => i.toJson(i)).toList()
        : null;
    List<Map<String, dynamic>>? _allList =
        item.all != null ? item.all!.map((i) => i.toJson(i)).toList() : null;

    return <String, dynamic>{
      'is_day_closed': item.is_day_closed,
      'attendance_count': item.attendance_count,
      'absence_count': item.absence_count,
      'attendance_list': _attendanceList,
      'absence_list': _absenceList,
      'all': _allList,
    };
  }

  String toString() {
    return 'Teams( isDayClosed:   $is_day_closed,\n attendanceCount:   $attendance_count,\n absenceCount:  $absence_count,\n attendanceList:  ' +
        attendance_list!.toString() +
        ',\n allList:   ' +
        all!.toString() +
        /*',\n absenceList:   ' +
        absence_list!.toString() ?? '0' +*/
        ', )';
  }

  factory TeamListBySupervisor.copy(TeamListBySupervisor o) {
    return TeamListBySupervisor(
      is_day_closed: o.is_day_closed,
      attendance_count: o.attendance_count,
      absence_count: o.absence_count,
      attendance_list: o.attendance_list,
      absence_list: o.absence_list,
      all: o.all,
    );
  }
}

class Team {
  String? id_anaquelero;
  String? name_anaquelero;
  String? route_show;
  String? id_client_route;
  String? attendance;
  String? search_field;
  String? time_start;
  String? active_from;
  String? profile;
  String? show_attendance;
  List<Details>? details;

  Team({
    this.id_anaquelero,
    this.name_anaquelero,
    this.route_show,
    this.id_client_route,
    this.attendance,
    this.search_field,
    this.time_start,
    this.active_from,
    this.profile,
    this.show_attendance,
    this.details,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    var _details;
    if (json['details'] != null) {
      var items = json['details'];
      var t = items.map((f) => Details.fromJson(f)).toList();
      _details = t.cast<Details>().toList();
    }
    return Team(
      id_anaquelero: json['id_anaquelero'].toString(),
      name_anaquelero: json['name_anaquelero'].toString(),
      route_show: json['route_show'].toString(),
      id_client_route: json['id_client_route'].toString(),
      attendance: json['attendance'].toString(),
      search_field: json['search_field'].toString(),
      time_start: json['time_start'] ?? '',
      active_from: json['active_from'].toString(),
      profile: json['profile'].toString(),
      show_attendance: json['show_attendance'].toString(),
      details: _details,
    );
  }

  Map<String, dynamic> toJson(Team o) {
    List<Map<String, dynamic>>? _details =
        o.details != null ? o.details!.map((i) => i.toJson(i)).toList() : null;

    return <String, dynamic>{
      'id_anaquelero': o.id_anaquelero,
      'name_anaquelero': o.name_anaquelero,
      'route_show': o.route_show,
      'id_client_route': o.id_client_route,
      'attendance': o.attendance,
      'search_field': o.search_field,
      'time_start': o.time_start,
      'active_from': o.active_from,
      'profile': o.profile,
      'show_attendance': o.show_attendance,
      'details': _details,
    };
  }

  String toString() {
    return 'Teams( id_anaquelero: $id_anaquelero,\n name_anaquelero: $name_anaquelero,\n route_show: $route_show, \n id_client_route: $id_client_route,\n attendance: $attendance,\n search_field: $search_field,\n time_start: $time_start,\n active_from:  $active_from,\n  )';
  }

  factory Team.copy(Team o) {
    return Team(
      id_anaquelero: o.id_anaquelero,
      name_anaquelero: o.name_anaquelero,
      route_show: o.route_show,
      id_client_route: o.id_client_route,
      attendance: o.attendance,
      search_field: o.search_field,
      time_start: o.time_start,
      active_from: o.active_from,
      profile: o.profile,
      show_attendance: o.show_attendance,
      details: o.details,
    );
  }
}

class Details {
  String? id_route;
  String? id_client;
  String? id_cellar;
  String? id_client_route;
  String? client_name;
  String? time;
  String? hours;
  String? status;
  String? status_id;
  String? status_desc;
  String? status_color;

  Details(
      {this.id_route,
      this.id_client,
      this.id_cellar,
      this.id_client_route,
      this.client_name,
      this.time,
      this.hours,
      this.status,
      this.status_id,
      this.status_desc,
      this.status_color});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      id_route: json['id_route'].toString(),
      id_client: json['id_client'].toString(),
      id_cellar: json['id_cellar'].toString(),
      id_client_route: json['id_client_route'].toString(),
      client_name: json['client_name'].toString(),
      time: json['time'].toString(),
      hours: json['hours'].toString(),
      status: json['status'].toString(),
      status_id: json['status_id'].toString(),
      status_desc: json['status_desc'].toString(),
      status_color: json['status_color'].toString(),
    );
  }

  Map<String, dynamic> toJson(Details o) => <String, dynamic>{
        'id_route': o.id_route,
        'id_client': o.id_client,
        'id_cellar': o.id_cellar,
        'id_client_route': o.id_client_route,
        'client_name': o.client_name,
        'time': o.time,
        'hours': o.hours,
        'status': o.status,
        'status_id': o.status_id,
        'status_desc': o.status_desc,
        'status_color': o.status_color,
      };

  String toString() {
    return 'Details( id_client_route: $id_client_route,\n client_name: $client_name,\n time: $time, \n hours: $hours,\n status: $status,\n status_id: $status_id,\n status_desc: $status_desc,\n status_color: $status_color,\n  )';
  }

  factory Details.copy(Details o) {
    return Details(
      id_route: o.id_route,
      id_client: o.id_client,
      id_cellar: o.id_cellar,
      id_client_route: o.id_client_route,
      client_name: o.client_name,
      time: o.time,
      hours: o.hours,
      status: o.status,
      status_id: o.status_id,
      status_desc: o.status_desc,
      status_color: o.status_color,
    );
  }
}

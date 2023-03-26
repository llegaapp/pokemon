class HomeInfo {
  String? id_client_route;
  String? client_id;
  String? client_name;
  String? status_id_schedule;
  String? status_name_schedule;
  String? status_color_schedule;
  String? time_show;
  String? hours_show;
  String? today_show;
  String? comment;
  String? active;

  HomeInfo(
      {this.id_client_route,
      this.client_id,
      this.client_name,
      this.status_id_schedule,
      this.status_name_schedule,
      this.status_color_schedule,
      this.time_show,
      this.hours_show,
      this.today_show,
      this.comment,
      this.active});

  HomeInfo.fromJson({required Map<String, dynamic> json, String source = 'api'})
      : id_client_route = json['id_client_route'].toString(),
        client_id = json['client_id'].toString(),
        client_name = json['client_name'].toString(),
        status_id_schedule = json['status_id_schedule'].toString(),
        status_name_schedule = json['status_name_schedule'].toString(),
        status_color_schedule = json['status_color_schedule'].toString(),
        time_show = json['time_show'].toString(),
        hours_show = json['hours_show'].toString(),
        today_show = json['today_show'].toString(),
        comment = source == 'api' ? '' : json['comment'].toString(),
        active = source == 'api' ? '' : json['active'].toString();

  Map<String, dynamic> toMap() {
    return {
      'id_client_route': id_client_route.toString(),
      'client_id': client_id.toString(),
      'client_name': client_name.toString(),
      'status_id_schedule': status_id_schedule.toString(),
      'status_name_schedule': status_name_schedule.toString(),
      'status_color_schedule': status_color_schedule.toString(),
      'time_show': time_show.toString(),
      'hours_show': hours_show.toString(),
      'today_show': today_show.toString(),
      'comment': comment.toString(),
      'active': active.toString()
    };
  }

  Map<String, dynamic> toJson(HomeInfo item) {
    return <String, dynamic>{
      'id_client_route': item.id_client_route.toString(),
      'client_id': item.client_id.toString(),
      'client_name': item.client_name.toString(),
      'status_id_schedule': item.status_id_schedule.toString(),
      'status_name_schedule': item.status_name_schedule.toString(),
      'status_color_schedule': item.status_color_schedule.toString(),
      'time_show': item.time_show.toString(),
      'hours_show': item.hours_show.toString(),
      'today_show': item.today_show.toString(),
      'comment': item.comment.toString(),
      'active': item.active.toString(),
    };
  }
}

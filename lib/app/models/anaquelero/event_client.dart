class EventClient {
  final String? id_registered_event;
  final String? id_client_route;
  final String? id_catalog_event;
  final String? x_coordinate;
  final String? y_coordinate;
  final String? created;
  final String? device_gtm;
  final String? finished;
  final String? active;
  final String? is_checkin;
  final String? is_checkout;
  final String? is_event;

  EventClient(
      {this.id_registered_event,
      this.id_client_route,
      this.id_catalog_event,
      this.x_coordinate,
      this.y_coordinate,
      this.created,
      this.device_gtm,
      this.finished,
      this.active,
      this.is_checkin,
      this.is_checkout,
      this.is_event});

  EventClient.fromJson(Map<String, dynamic> json)
      : id_registered_event = json['id_registered_event'].toString(),
        id_client_route = json['id_client_route'].toString(),
        id_catalog_event = json['event_type']['id_catalog_event'].toString(),
        x_coordinate = json['x_coordinate'].toString(),
        y_coordinate = json['y_coordinate'].toString(),
        created = json['created'].toString(),
        device_gtm = json['device_gtm'].toString(),
        finished = json['finished'] == null ? '' : json['finished'].toString(),
        active = json['finished'] == null ? 'true' : 'false',
        is_checkin = json['is_chekin'].toString(),
        is_checkout = json['is_checkout'].toString(),
        is_event = json['is_event'].toString();

  Map<String, dynamic> toMap() {
    return {
      'id_registered_event': id_registered_event.toString(),
      'id_client_route': id_client_route.toString(),
      'id_catalog_event': id_catalog_event.toString(),
      'x_coordinate': x_coordinate.toString(),
      'y_coordinate': y_coordinate.toString(),
      'created': created.toString(),
      'device_gtm': device_gtm.toString(),
      'finished': finished.toString(),
      'active': active.toString(),
      'is_checkin': is_checkin.toString(),
      'is_checkout': is_checkout.toString(),
      'is_event': is_event.toString()
    };
  }
}

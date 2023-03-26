class BackEvent {
  final String? folio;
  final String? id_registered_event;
  final String? id_client_route;
  final String? id_catalog_event;
  final String? x_coordinate;
  final String? y_coordinate;
  final String? device_date;
  final String? device_gtm;
  final String? type_event;
  final String? enviado;

  BackEvent(
      {this.folio,
      this.id_registered_event,
      this.id_client_route,
      this.id_catalog_event,
      this.x_coordinate,
      this.y_coordinate,
      this.device_date,
      this.device_gtm,
      this.type_event,
      this.enviado});

  Map<String, dynamic> toMap() {
    return {
      'folio': folio,
      'id_registered_event': id_registered_event,
      'id_client_route': id_client_route,
      'id_catalog_event': id_catalog_event,
      'x_coordinate': x_coordinate,
      'y_coordinate': y_coordinate,
      'device_date': device_date,
      'device_gtm': device_gtm,
      'type_event': type_event,
      'enviado': enviado
    };
  }
}

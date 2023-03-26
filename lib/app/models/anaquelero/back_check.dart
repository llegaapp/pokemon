class BackCheck {
  final String? folio;
  final String? id_client_route;
  final String? x_coordinate;
  final String? y_coordinate;
  final String? device_date;
  final String? device_gtm;
  final String? description;
  final String? is_online;
  final String? b64Photo;
  final String? type_check;
  final String? enviado;

  BackCheck(
      {this.folio,
      this.id_client_route,
      this.x_coordinate,
      this.y_coordinate,
      this.device_date,
      this.device_gtm,
      this.description,
      this.is_online,
      this.b64Photo,
      this.type_check,
      this.enviado});

  Map<String, dynamic> toMap() {
    return {
      'folio': folio,
      'id_client_route': id_client_route,
      'x_coordinate': x_coordinate,
      'y_coordinate': y_coordinate,
      'device_date': device_date,
      'device_gtm': device_gtm,
      'description': description,
      'is_online': is_online,
      'b64Photo': b64Photo,
      'type_check': type_check,
      'enviado': enviado
    };
  }
}

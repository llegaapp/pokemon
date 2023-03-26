class Client {
  final String? id_client_route;
  final String? date;
  final String? time_show;
  final String? id_client;
  final String? id_chain;
  final String? description;
  final String? lowDate;
  final String? client_address;
  final String? x_coordinate;
  final String? y_coordinate;
  final String? business_name;
  final String? full_address;
  final String? branch_office;
  final String? is_NOSIO;
  final String? type_id;
  final String? type_name;
  final String? type_description;

  Client(
      {this.id_client_route,
      this.date,
      this.time_show,
      this.id_client,
      this.id_chain,
      this.description,
      this.lowDate,
      this.client_address,
      this.x_coordinate,
      this.y_coordinate,
      this.business_name,
      this.full_address,
      this.branch_office,
      this.is_NOSIO,
      this.type_id,
      this.type_name,
      this.type_description});

  Client.fromJson(Map<String, dynamic> json)
      : id_client_route = json['id_client_route'].toString(),
        date = json['date'].toString(),
        time_show = json['time_show'].toString(),
        id_client = json['client']['id_client'].toString(),
        id_chain = json['client']['id_chain'].toString(),
        description = json['client']['description'].toString(),
        lowDate = json['client']['lowDate'].toString(),
        client_address = json['client']['client_address'].toString(),
        x_coordinate = json['client']['x_coordinate'].toString(),
        y_coordinate = json['client']['y_coordinate'].toString(),
        business_name = json['client']['business_name'].toString(),
        full_address = json['client']['full_address'].toString(),
        branch_office = json['client']['branch_office'].toString(),
        is_NOSIO = json['client']['is_NOSIO'].toString(),
        type_id = json['client']['type_client'] == null
            ? ''
            : json['client']['type_client']['id'].toString(),
        type_name = json['client']['type_client'] == null
            ? ''
            : json['client']['type_client']['name'].toString(),
        type_description = json['client']['type_client'] == null
            ? ''
            : json['client']['type_client']['description'].toString();

  Map<String, dynamic> toMap() {
    return {
      'id_client_route': id_client_route,
      'date': date,
      'time_show': time_show,
      'id_client': id_client,
      'id_chain': id_chain,
      'description': description,
      'lowDate': lowDate,
      'client_address': client_address,
      'x_coordinate': x_coordinate,
      'y_coordinate': y_coordinate,
      'business_name': business_name,
      'full_address': full_address,
      'branch_office': branch_office,
      'is_NOSIO': is_NOSIO,
      'type_id': type_id,
      'type_name': type_name,
      'type_description': type_description
    };
  }
}

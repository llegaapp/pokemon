class ClientDetailOtherRoute {
  String? id_route;
  String? description;
  String? route_show;
  String? anaquelero;

  ClientDetailOtherRoute(
      {this.id_route, this.description, this.route_show, this.anaquelero});

  factory ClientDetailOtherRoute.fromJson(Map<String, dynamic> json) {
    return ClientDetailOtherRoute(
      id_route: json['id_route'] == null ? '' : json['id_route'].toString(),
      description:
          json['description'] == null ? '' : json['description'].toString(),
      route_show:
          json['route_show'] == null ? '' : json['route_show'].toString(),
      anaquelero: json['details'] == null
          ? ''
          : json['details']['anaquelero'].toString(),
    );
  }
  factory ClientDetailOtherRoute.Copy(ClientDetailOtherRoute o) {
    return ClientDetailOtherRoute(
      id_route: o.id_route,
      description: o.description,
      route_show: o.route_show,
      anaquelero: o.anaquelero,
    );
  }

  Map<String, dynamic> toJson(ClientDetailOtherRoute o) => <String, dynamic>{
        'id_route': o.id_route,
        'description': o.description,
        'route_show': o.route_show,
        'anaquelero': o.anaquelero,
      };

  String toString() {
    return 'ClientDetailOtherRoute(id_route: $id_route,\n description: $description,\n route_show: $route_show,\n anaquelero: $anaquelero, )';
  }
}

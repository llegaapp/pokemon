class ClientDetailOtherRouteLocal {
  final String id_route;
  final int id_client;
  final int id_cellar;
  final String content;

  ClientDetailOtherRouteLocal(
      {required this.id_route,
      required this.id_client,
      required this.id_cellar,
      required this.content});

  factory ClientDetailOtherRouteLocal.fromJson(Map<String, dynamic> json) {
    return ClientDetailOtherRouteLocal(
      id_route: json['id_route'].toString(),
      id_client: json['id_client'],
      id_cellar: json['id_cellar'],
      content: json['content'].toString(),
    );
  }

  Map<String, dynamic> toJson(ClientDetailOtherRouteLocal item) {
    return <String, dynamic>{
      'id_route': item.id_route,
      'id_client': item.id_client,
      'id_cellar': item.id_cellar,
      'content': item.content,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id_route': id_route,
      'id_client': id_client,
      'id_cellar': id_cellar,
      'content': content,
    };
  }
}

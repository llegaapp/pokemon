class ClientDetailSupLocal {
  final int? id_client;
  final int? id_cellar;
  final int? id_client_route;
  final String? content;
  final int? enviadoAnaquelero;
  final int? enviadoAsistencia;

  ClientDetailSupLocal(
      {required this.id_client,
      required this.id_cellar,
      required this.id_client_route,
      required this.content,
      required this.enviadoAnaquelero,
      required this.enviadoAsistencia});

  factory ClientDetailSupLocal.fromJson(Map<String, dynamic> json) {
    return ClientDetailSupLocal(
      id_client: int.parse(json['id_client'].toString()),
      id_cellar: int.parse(json['id_cellar'].toString()),
      id_client_route: int.parse(json['id_client_route'].toString()),
      content: json['content'].toString(),
      enviadoAnaquelero: 1,
      enviadoAsistencia: 1,
    );
  }

  Map<String, dynamic> toJson(ClientDetailSupLocal item) {
    return <String, dynamic>{
      'id_client': item.id_client,
      'id_cellar': item.id_cellar,
      'id_client_route': item.id_client_route,
      'content': item.content,
      'enviadoAnaquelero': item.enviadoAnaquelero,
      'enviadoAsistencia': item.enviadoAsistencia,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id_client': id_client,
      'id_cellar': id_cellar,
      'id_client_route': id_client_route,
      'content': content,
      'enviadoAnaquelero': enviadoAnaquelero,
      'enviadoAsistencia': enviadoAsistencia,
    };
  }
}

class AnaquelerosToManageClientLocal {
  final int id_client_route;
  final String content;

  AnaquelerosToManageClientLocal(
      {required this.id_client_route, required this.content});

  factory AnaquelerosToManageClientLocal.fromJson(Map<String, dynamic> json) {
    return AnaquelerosToManageClientLocal(
      id_client_route: json['id_client_route'],
      content: json['content'].toString(),
    );
  }

  Map<String, dynamic> toJson(AnaquelerosToManageClientLocal item) {
    return <String, dynamic>{
      'id_client_route': item.id_client_route,
      'content': item.content,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id_client_route': id_client_route,
      'content': content,
    };
  }
}

class Routes {
  String? idRoute;
  String? nameRoute;

  Routes({
    this.idRoute,
    this.nameRoute,
  });
  factory Routes.fromJson(Map<String, dynamic> json) {
    return Routes(
      idRoute: json['idRoute'] == null ? '' : json['idRoute'],
      nameRoute: json['nameRoute'] == null ? '' : json['nameRoute'],
    );
  }
  factory Routes.Copy(Routes o) {
    return Routes(
      idRoute: o.idRoute,
      nameRoute: o.nameRoute,
    );
  }

  String toString() {
    return 'Routes(  idRoute: $idRoute,\n nameRoute: $nameRoute, )';
  }
}

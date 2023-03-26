class CatRoutesBySupervisor {
  String? idRoute;
  String? nameRoute;

  CatRoutesBySupervisor({
    this.idRoute,
    this.nameRoute,
  });
  factory CatRoutesBySupervisor.fromJson(Map<String, dynamic> json) {
    return CatRoutesBySupervisor(
      idRoute: json['idRoute'] == null ? '' : json['idRoute'],
      nameRoute: json['nameRoute'] == null ? '' : json['nameRoute'],
    );
  }
  factory CatRoutesBySupervisor.Copy(CatRoutesBySupervisor o) {
    return CatRoutesBySupervisor(
      idRoute: o.idRoute,
      nameRoute: o.nameRoute,
    );
  }
  Map<String, dynamic> toJson(CatRoutesBySupervisor item) {
      return <String, dynamic>{
        'idRoute': item.idRoute,
        'nameRoute': item.nameRoute,
    };
  }

  String toString() {
    return 'CatRoutesBySupervisor(  idRoute: $idRoute,\n nameRoute: $nameRoute, )';
  }
}

class ClientsListByRouteSupervisor {
  String? idRoute;
  String? nameRoute;
  String? idCellar;
  String? nameCellar;
  String? idClient;
  String? idClientRoute;
  String? nameClient;
  String? idStatus;
  String? nameStatus;
  String? colorStatus;
  String? clientShow;
  String? cellarShow;
  String? clientAddress;

  String? anaqueleroIdRoute;
  String? anaqueleroIdAnaquelero;
  String? anaqueleroAnaquelero;
  String? anaqueleroTypeAssign;

  String textTime = '';
  String? startTime;
  String? endTime;
  bool forToday = false;
  String? enviado;

  ClientsListByRouteSupervisor({
    this.enviado,
    this.idRoute,
    this.nameRoute,
    this.idCellar,
    this.nameCellar,
    this.idClient,
    this.idClientRoute,
    this.nameClient,
    this.idStatus,
    this.nameStatus,
    this.colorStatus,
    this.clientShow,
    this.cellarShow,
    this.clientAddress,
    this.anaqueleroIdRoute,
    this.anaqueleroIdAnaquelero,
    this.anaqueleroAnaquelero,
    this.anaqueleroTypeAssign,
    this.startTime,
    this.endTime,
  });

  factory ClientsListByRouteSupervisor.fromJson(Map<String, dynamic> json) {
    return ClientsListByRouteSupervisor(
      enviado: '1',
      idRoute: json['idRoute'],
      nameRoute: json['nameRoute'],
      idCellar: json['idCellar'],
      nameCellar: json['nameCellar'],
      idClient: json['idClient'],
      idClientRoute: json['idClientRoute'],
      nameClient: json['nameClient'],
      idStatus: json['idStatus'] == null ? '' : json['idStatus'],
      nameStatus: json['nameStatus'] == null ? '' : json['nameStatus'],
      colorStatus: json['colorStatus'] == null ? '' : json['colorStatus'],
      clientShow: json['clientShow'] == null ? '' : json['clientShow'],
      cellarShow: json['cellarShow'] == null ? '' : json['cellarShow'],
      clientAddress: json['clientAddress'] == null ? '' : json['clientAddress'],
      anaqueleroIdRoute: json['anaquelero'] == null ? '' : json['anaquelero']['anaqueleroIdRoute'] == null
          ? ''
          : json['anaquelero']['anaqueleroIdRoute'],
      anaqueleroIdAnaquelero: json['anaquelero'] == null ? '' :
          json['anaquelero']['anaqueleroIdAnaquelero'] == null
              ? ''
              : json['anaquelero']['anaqueleroIdAnaquelero'],
      anaqueleroAnaquelero: json['anaquelero'] == null ? '' : json['anaquelero']['anaqueleroAnaquelero'] == null
          ? ''
          : json['anaquelero']['anaqueleroAnaquelero'],
      anaqueleroTypeAssign: json['anaquelero'] == null ? '' : json['anaquelero']['anaqueleroTypeAssign'] == null
          ? ''
          : json['anaquelero']['anaqueleroTypeAssign'],
    );
  }
  factory ClientsListByRouteSupervisor.fromLocalJson(
      Map<String, dynamic> json) {
    return ClientsListByRouteSupervisor(
      enviado: json['enviado'],
      idClient: json['idClient'],
      idClientRoute: json['idClientRoute'],
      idCellar: json['idCellar'],
      anaqueleroIdAnaquelero: json['anaqueleroIdAnaquelero'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enviado': enviado,
      'idRoute': idRoute,
      'nameRoute': nameRoute,
      'idCellar': idCellar,
      'nameCellar': nameCellar,
      'idClient': idClient,
      'idClientRoute': idClientRoute,
      'nameClient': nameClient,
      'idStatus': idStatus,
      'nameStatus': nameStatus,
      'colorStatus': colorStatus,
      'clientShow': clientShow,
      'cellarShow': cellarShow,
      'clientAddress': clientAddress,
      'anaqueleroIdRoute': anaqueleroIdRoute,
      'anaqueleroIdAnaquelero': anaqueleroIdAnaquelero,
      'anaqueleroAnaquelero': anaqueleroAnaquelero,
      'anaqueleroTypeAssign': anaqueleroTypeAssign,
    };
  }

  String toString() {
    return 'ClientsListByRouteSupervisor( enviado:   $enviado,\nidRoute:   $idRoute,\n nameRoute:  $nameRoute,\n idCellar:  $idCellar,\n nameCellar:  $nameCellar,\n idClient:  $idClient,\n idClientRoute:  $idClientRoute,\n nameClient:  $nameClient,\n idStatus:  $idStatus,\n nameStatus:  $nameStatus,\n colorStatus:  $colorStatus,\n clientShow:  $clientShow,\n  cellarShow:  $cellarShow,\n  clientAddress:  $clientAddress,\n anaqueleroIdRoute:  $anaqueleroIdRoute,\n anaqueleroIdAnaquelero:  $anaqueleroIdAnaquelero,\n anaqueleroAnaquelero:  $anaqueleroAnaquelero,\n  anaqueleroTypeAssign:  $anaqueleroTypeAssign,\n  textTime:  $textTime,\n toTime:  $startTime,\n fromTime:  $endTime,\n  forToday:  $forToday,\n  )';
  }

  Map<String, dynamic> toJson(ClientsListByRouteSupervisor item) {
    return <String, dynamic>{
      'enviado': enviado,
      'idRoute': idRoute,
      'nameRoute': nameRoute,
      'idCellar': idCellar,
      'nameCellar': nameCellar,
      'idClient': idClient,
      'idClientRoute': idClientRoute,
      'nameClient': nameClient,
      'idStatus': idStatus,
      'nameStatus': nameStatus,
      'colorStatus': colorStatus,
      'clientShow': clientShow,
      'cellarShow': cellarShow,
      'clientAddress': clientAddress,
      'anaqueleroIdRoute': anaqueleroIdRoute,
      'anaqueleroIdAnaquelero': anaqueleroIdAnaquelero,
      'anaqueleroAnaquelero': anaqueleroAnaquelero,
      'anaqueleroTypeAssign': anaqueleroTypeAssign,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory ClientsListByRouteSupervisor.copy(ClientsListByRouteSupervisor o) {
    return ClientsListByRouteSupervisor(
      enviado: o.enviado,
      idRoute: o.idRoute,
      nameRoute: o.nameRoute,
      idCellar: o.idCellar,
      nameCellar: o.nameCellar,
      idClient: o.idClient,
      idClientRoute: o.idClientRoute,
      nameClient: o.nameClient,
      idStatus: o.idStatus,
      nameStatus: o.nameStatus,
      colorStatus: o.colorStatus,
      clientShow: o.clientShow,
      cellarShow: o.cellarShow,
      clientAddress: o.clientAddress,
      anaqueleroIdRoute: o.anaqueleroIdRoute,
      anaqueleroIdAnaquelero: o.anaqueleroIdAnaquelero,
      anaqueleroAnaquelero: o.anaqueleroAnaquelero,
      anaqueleroTypeAssign: o.anaqueleroTypeAssign,
    );
  }
}

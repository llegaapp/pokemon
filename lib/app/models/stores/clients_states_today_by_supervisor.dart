class CountClientsStates {
  String? all;
  String? finished;
  String? inProgress;
  String? pending;

  CountClientsStates({
    this.all,
    this.finished,
    this.inProgress,
    this.pending,
  });

  static CountClientsStates fromJson({required Map<String, dynamic> json}) {
    return CountClientsStates(
      all: json['all'].toString() ?? '',
      finished: json['finished'].toString() ?? '',
      inProgress: json['inProgress'].toString() ?? '',
      pending: json['pending'].toString() ?? '',
    );
  }

  factory CountClientsStates.Copy(CountClientsStates o) {
    return CountClientsStates(
      all: o.all,
      finished: o.finished,
      inProgress: o.inProgress,
      pending: o.pending,
    );
  }

  Map<String, dynamic> toJson(CountClientsStates item) {
    return <String, dynamic>{
      'all': item.all,
      'finished': item.finished,
      'inProgress': item.inProgress,
      'pending': item.pending,
    };
  }

  String toString() {
    return 'CountClientsStates(  all: $all,\n finished: $finished,\n inProgress: $inProgress,\n pending: $pending )';
  }
}

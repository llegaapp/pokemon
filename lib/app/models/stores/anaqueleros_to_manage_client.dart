class AnaquelerosToManage {
  String? id;
  String? name;
  bool selected = false;

  AnaquelerosToManage({
    this.id,
    this.name,
  });
  factory AnaquelerosToManage.fromJson(Map<String, dynamic> json) {
    return AnaquelerosToManage(
      id: json['id'] == null ? '' : json['id'],
      name: json['name'] == null ? '' : json['name'],
    );
  }
  factory AnaquelerosToManage.Copy(AnaquelerosToManage o) {
    return AnaquelerosToManage(
      id: o.id,
      name: o.name,
    );
  }
  Map<String, dynamic> toJson(AnaquelerosToManage item) {
    return <String, dynamic>{
      'id': item.id,
      'name': item.name,
    };
  }

  String toString() {
    return 'Anaqueleros(  id: $id,\n name: $name, selected: $selected )';
  }
}

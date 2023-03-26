
class Event {
  final String? id_catalog_event;
  final String? name;
  final String? description;
  final String? times;
  final String? count;

  Event({this.id_catalog_event, this.name, this.description, this.times, this.count});

  Event.fromJson(Map<String, dynamic> json)
      : id_catalog_event = json['id_catalog_event'].toString(),
        name             = json['name'].toString(),
        description      = json['description'].toString(),
        times            = json['times'].toString(),
        count            = json['count'].toString();

  Map<String, dynamic> toMap() {
    return { 'id_catalog_event' : id_catalog_event, 
             'name'             : name,
             'description'      : description,
             'times'            : times,
             'count'            : count};
  }

}
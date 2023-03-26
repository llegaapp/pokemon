class Profile {
  String? user_id;
  String? user_name;
  String? profile;
  String? manager_type;
  String? manager_name;
  String? active_since;

  Profile({
    this.user_id,
    this.user_name,
    this.profile,
    this.manager_type,
    this.manager_name,
    this.active_since,
  });

  static Profile profileFromJson({required Map<String, dynamic> json}) {
    return Profile(
      user_id: json['user_id'] ?? '',
      user_name: json['user_name'] ?? '',
      profile: json['profile'] ?? '',
      manager_type: json['manager_type'] ?? '',
      manager_name: json['manager_name'] ?? '',
      active_since: json['active_since'] ?? '',
    );
  }

  factory Profile.Copy(Profile o) {
    return Profile(
      user_id: o.user_id,
      user_name: o.user_name,
      profile: o.profile,
      manager_type: o.manager_type,
      manager_name: o.manager_name,
      active_since: o.active_since,
    );
  }

  Map<String, dynamic> toJson(Profile item) {
    return <String, dynamic>{
      'user_id': item.user_id,
      'user_name': item.user_name,
      'profile': item.profile,
      'manager_type': item.manager_type,
      'manager_name': item.manager_name,
      'active_since': item.active_since,
    };
  }
}

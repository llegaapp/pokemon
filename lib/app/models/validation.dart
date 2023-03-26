class Validation {
  final String code;
  final String message;
  final String description;
  final String level;

  Validation(this.code, this.message, this.description, this.level);

  Validation.fromJson(Map<String, dynamic> json)
      : code = json['code'] ?? '',
        message = json['message'] ?? '',
        description = json['description'] ?? '',
        level = json['level'] ?? '';
}

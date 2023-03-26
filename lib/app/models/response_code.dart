
class ResponseCode {

  final String code;
  final String message;
  final String description;
  final String level;

  ResponseCode(this.code, this.message, this.description, this.level);

  ResponseCode.fromJson(Map<String, dynamic> json)
      : code        = json['code'],
        message     = json['message'],
        description = json['description'],
        level       = json['level'];

}
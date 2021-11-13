import 'dart:convert';

ImageError imageErrorFromJson(String str) => ImageError.fromJson(json.decode(str));

String userErrorToJson(ImageError data) => json.encode(data.toJson());

class ImageError {
  ImageError({
    required this.code,
    required this.message,
  });

  int code;
  String message;

  factory ImageError.fromJson(Map<String, dynamic> json) => ImageError(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
      };
}

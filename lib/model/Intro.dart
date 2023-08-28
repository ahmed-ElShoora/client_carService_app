// To parse this JSON data, do
//
//     final intro = introFromJson(jsonString);

import 'dart:convert';

Intro introFromJson(String str) => Intro.fromJson(json.decode(str));

String introToJson(Intro data) => json.encode(data.toJson());

class Intro {
  Intro({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  Data data;

  factory Intro.fromJson(Map<String, dynamic> json) => Intro(
    status: json["status"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.logoClient,
    this.logoPhane,
    required this.appClientIntro,
    required this.appPhaneIntro,
  });

  String? logoClient;
  String? logoPhane;
  AppIntro appClientIntro;
  AppIntro appPhaneIntro;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    logoClient: json["logo_client"],
    logoPhane: json["logo_phane"],
    appClientIntro: AppIntro.fromJson(json["app_client_intro"]),
    appPhaneIntro: AppIntro.fromJson(json["app_phane_intro"]),
  );

  Map<String, dynamic> toJson() => {
    "logo_client": logoClient,
    "logo_phane": logoPhane,
    "app_client_intro": appClientIntro.toJson(),
    "app_phane_intro": appPhaneIntro.toJson(),
  };
}

class AppIntro {
  AppIntro({
    required this.one,
    required this.two,
  });

  One one;
  One two;

  factory AppIntro.fromJson(Map<String, dynamic> json) => AppIntro(
    one: One.fromJson(json["one"]),
    two: One.fromJson(json["two"]),
  );

  Map<String, dynamic> toJson() => {
    "one": one.toJson(),
    "two": two.toJson(),
  };
}

class One {
  One({
    required this.id,
    this.image,
    this.title,
    this.desc,
    required this.app,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String? image;
  String? title;
  String? desc;
  String app;
  dynamic? createdAt;
  DateTime? updatedAt;

  factory One.fromJson(Map<String, dynamic> json) => One(
    id: json["id"],
    image: json["image"],
    title: json["title"],
    desc: json["desc"],
    app: json["app"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
    "desc": desc,
    "app": app,
    "created_at": createdAt,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
  };
}

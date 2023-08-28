// To parse this JSON data, do
//
//     final ad = adFromJson(jsonString);

import 'dart:convert';

Ad adFromJson(String str) => Ad.fromJson(json.decode(str));

String adToJson(Ad data) => json.encode(data.toJson());

class Ad {
  Ad({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  List<Datum>? data;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    status: json["status"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.image,
    this.title,
    this.link,
    this.createdAt,
    this.updatedAt,
    this.app,
  });

  int? id;
  String? image;
  String? title;
  String? link;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? app;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    image: json["image"],
    title: json["title"],
    link: json["link"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    app: json["app"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
    "link": link,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "app": app,
  };
}

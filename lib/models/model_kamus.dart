// To parse this JSON data, do
//
//     final modelKamus = modelKamusFromJson(jsonString);

import 'dart:convert';

List<ModelKamus> modelKamusFromJson(String str) =>
    List<ModelKamus>.from(json.decode(str).map((x) => ModelKamus.fromJson(x)));

String modelKamusToJson(List<ModelKamus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelKamus {
  ModelKamus({
    required this.id,
    required this.judul,
    required this.isi,
    required this.tanggal,
  });

  String id;
  String judul;
  String isi;
  DateTime tanggal;

  factory ModelKamus.fromJson(Map<dynamic, dynamic> json) => ModelKamus(
        id: json["id"],
        judul: json["judul"],
        isi: json["isi"],
        tanggal: DateTime.parse(json["tanggal"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "isi": isi,
        "tanggal": tanggal.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final modelBerita = modelBeritaFromJson(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
DateFormat dateFormat = DateFormat('yyyy-MM-dd');

List<ModelBerita> modelBeritaFromJson(String str) => List<ModelBerita>.from(
    json.decode(str).map((x) => ModelBerita.fromJson(x)));

String modelBeritaToJson(List<ModelBerita> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelBerita {
  ModelBerita({
    required this.idBerita,
    required this.judul,
    required this.isi,
    required this.foto,
    required this.tglBerita,
  });

  String idBerita;
  String judul;
  String isi;
  String foto;
  DateTime tglBerita;

  factory ModelBerita.fromJson(Map<dynamic, dynamic> json) => ModelBerita(
        idBerita: json["id_berita"],
        judul: json["judul"],
        isi: json["isi"],
        foto: json["foto"],
        tglBerita: dateFormat.parse(json["tgl_berita"]),
      );

  Map<String, dynamic> toJson() => {
        "id_berita": idBerita,
        "judul": judul,
        "isi": isi,
        "foto": foto,
        "tgl_berita": tglBerita.toIso8601String(),
      };
}

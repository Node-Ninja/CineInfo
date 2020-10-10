// To parse this JSON data, do
//
//     final languages = languagesFromJson(jsonString);

import 'dart:convert';

Map<String, Languages> languagesFromJson(String str) =>
    Map.from(json.decode(str))
        .map((k, v) => MapEntry<String, Languages>(k, Languages.fromJson(v)));

String languagesToJson(Map<String, Languages> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Languages {
  Languages({
    this.name,
    this.nativeName,
  });

  String name;
  String nativeName;

  factory Languages.fromJson(Map<String, dynamic> json) => Languages(
        name: json["name"],
        nativeName: json["nativeName"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "nativeName": nativeName,
      };
}

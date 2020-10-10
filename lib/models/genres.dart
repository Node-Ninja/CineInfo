// To parse this JSON data, do
//
//     final genres = genresFromJson(jsonString);

import 'dart:convert';

Map<String, String> genresFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) => MapEntry<String, String>(k, v));

String genresToJson(Map<String, String> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));

// To parse this JSON data, do
//
//     final person = personFromJson(jsonString);

import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));
Credits creditsFromJson(String str) => Credits.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
  Person({
    this.details,
    this.credits,
    this.personId,
    this.status,
  });

  Details details;
  Credits credits;
  int personId;
  int status;

  factory Person.fromJson(Map<String, dynamic> data) => Person(
        details: data["details"],
        credits: data["credits"],
        personId: data["personId"],
        status: data["status"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "details": details.toJson(),
        "credits": credits.toJson(),
        "personId": personId,
        "status": status,
      };
}

class Credits {
  Credits({
    this.cast,
    this.crew,
    this.id,
  });

  List<Cast_> cast;
  List<Cast_> crew;
  int id;

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
        cast: List<Cast_>.from(json["cast"].map((x) => Cast_.fromJson(x))),
        crew: List<Cast_>.from(json["crew"].map((x) => Cast_.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
        "id": id,
      };
}

class Cast_ {
  Cast_({
    this.character,
    this.creditId,
    this.releaseDate,
    this.voteCount,
    this.video,
    this.adult,
    this.voteAverage,
    this.title,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.popularity,
    this.id,
    this.backdropPath,
    this.overview,
    this.posterPath,
    this.department,
    this.job,
  });

  String character;
  String creditId;
  dynamic releaseDate;
  int voteCount;
  bool video;
  bool adult;
  double voteAverage;
  String title;
  List<int> genreIds;
  String originalLanguage;
  String originalTitle;
  double popularity;
  int id;
  String backdropPath;
  String overview;
  String posterPath;
  String department;
  String job;

  factory Cast_.fromJson(Map<String, dynamic> json) => Cast_(
        character: json["character"] == null ? null : json["character"],
        creditId: json["credit_id"],
        releaseDate:
            (json["release_date"] == null || json["release_date"] == "")
                ? null
                : DateTime.parse(json["release_date"]),
        voteCount: json["vote_count"],
        video: json["video"],
        adult: json["adult"],
        voteAverage: json["vote_average"].toDouble(),
        title: json["title"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        popularity: json["popularity"].toDouble(),
        id: json["id"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        overview: json["overview"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        department: json["department"] == null ? null : json["department"],
        job: json["job"] == null ? null : json["job"],
      );

  Map<String, dynamic> toJson() => {
        "character": character == null ? null : character,
        "credit_id": creditId,
        "release_date": releaseDate == null ? null : releaseDate,
        "vote_count": voteCount,
        "video": video,
        "adult": adult,
        "vote_average": voteAverage,
        "title": title,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "popularity": popularity,
        "id": id,
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "overview": overview,
        "poster_path": posterPath == null ? null : posterPath,
        "department": department == null ? null : department,
        "job": job == null ? null : job,
      };
}

enum OriginalLanguage { EN, ZH, PT }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "pt": OriginalLanguage.PT,
  "zh": OriginalLanguage.ZH
});

class Details {
  Details({
    this.birthday,
    this.knownForDepartment,
    this.deathday,
    this.id,
    this.name,
    this.alsoKnownAs,
    this.gender,
    this.biography,
    this.popularity,
    this.placeOfBirth,
    this.profilePath,
    this.adult,
    this.imdbId,
    this.homepage,
  });

  String birthday;
  String knownForDepartment;
  dynamic deathday;
  int id;
  String name;
  List<String> alsoKnownAs;
  int gender;
  String biography;
  double popularity;
  String placeOfBirth;
  String profilePath;
  bool adult;
  String imdbId;
  dynamic homepage;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        birthday: json["birthday"],
        knownForDepartment: json["known_for_department"],
        deathday: json["deathday"],
        id: json["id"],
        name: json["name"],
        alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
        gender: json["gender"],
        biography: json["biography"],
        popularity: json["popularity"].toDouble(),
        placeOfBirth: json["place_of_birth"],
        profilePath: json["profile_path"],
        adult: json["adult"],
        imdbId: json["imdb_id"],
        homepage: json["homepage"],
      );

  Map<String, dynamic> toJson() => {
        "birthday": birthday,
        "known_for_department": knownForDepartment,
        "deathday": deathday,
        "id": id,
        "name": name,
        "also_known_as": List<dynamic>.from(alsoKnownAs.map((x) => x)),
        "gender": gender,
        "biography": biography,
        "popularity": popularity,
        "place_of_birth": placeOfBirth,
        "profile_path": profilePath,
        "adult": adult,
        "imdb_id": imdbId,
        "homepage": homepage,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

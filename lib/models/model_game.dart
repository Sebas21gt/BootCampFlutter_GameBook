// To parse this JSON data, do
//
//     final modelGame = modelGameFromJson(jsonString);

import 'dart:convert';

List<ModelGame> modelGameFromJson(String str) => List<ModelGame>.from(json.decode(str).map((x) => ModelGame.fromJson(x)));

String modelGameToJson(List<ModelGame> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelGame {
    int id;
    String title;
    String thumbnail;
    String shortDescription;
    String gameUrl;
    String genre;
    String platform;
    String publisher;
    String developer;
    DateTime releaseDate;
    String freetogameProfileUrl;

    ModelGame({
        required this.id,
        required this.title,
        required this.thumbnail,
        required this.shortDescription,
        required this.gameUrl,
        required this.genre,
        required this.platform,
        required this.publisher,
        required this.developer,
        required this.releaseDate,
        required this.freetogameProfileUrl,
    });

    factory ModelGame.fromJson(Map<String, dynamic> json) => ModelGame(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"] ?? '',
        shortDescription: json["short_description"],
        gameUrl: json["game_url"],
        genre: json["genre"],
        platform: json["platform"],
        publisher: json["publisher"],
        developer: json["developer"],
        releaseDate: DateTime.parse(json["release_date"]),
        freetogameProfileUrl: json["freetogame_profile_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "short_description": shortDescription,
        "game_url": gameUrl,
        "genre": genre,
        "platform": platform,
        "publisher": publisher,
        "developer": developer,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "freetogame_profile_url": freetogameProfileUrl,
    };
}

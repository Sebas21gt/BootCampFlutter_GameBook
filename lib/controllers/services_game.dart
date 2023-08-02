import 'package:dio/dio.dart';
import 'package:game_book/models/model_data_game.dart';
import 'package:game_book/models/model_game.dart';

//https://www.freetogame.com/api/games

final dio = Dio();
String url = 'https://www.freetogame.com/api/';
List<ModelGame> game = [];
ModelGame? detailsGame;

class Services {
  Future<List<ModelGame>> getGames() async {
    final response = await dio.get('${url}games');
    // modelGame = ModelGame.fromJson(response.data);
    game = (response.data as List).map((e) => ModelGame.fromJson(e)).toList();
    return game;
  }

  Future<List<ModelGame>> getGamesPopularity() async {
    final response = await dio.get('${url}games?sort-by=popularity');
    // modelGame = ModelGame.fromJson(response.data);
    game = (response.data as List).map((e) => ModelGame.fromJson(e)).toList();
    return game;
  }

  // Future<List<ModelGame>> getDetailsGame(String id) async {
  //   final response = await dio.get('${url}game?id=$id');
  //   // print(ModelGame.fromJson(response.data));
  //   detailsGame = ModelGame.fromJson(response.data) as List<ModelGame>;
  //   // detailsGame = (detailsGame as List).map((e) => ModelGame.fromJson(e)).toList();
  //   return detailsGame;
  // }

  Future<ModelDataGame> getDetailsGame(String id) async {
    final response = await dio.get('${url}game?id=$id');
    return ModelDataGame.fromJson(response.data);
  }

  
}

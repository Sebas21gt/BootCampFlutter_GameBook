import 'package:flutter/material.dart';
import 'package:game_book/controllers/services_game.dart';
import 'package:game_book/models/model_game.dart';

class GameModel extends ChangeNotifier {
  List<ModelGame> _games = [];
  Set<String> _uniquePlatforms = {};

  List<ModelGame> get games => _games;
  Set<String> get uniquePlatforms => _uniquePlatforms;

  void getGames() {
    Services().getGamesPopularity().then((value) {
      _games = value;
      _getUniquePlatforms();
      notifyListeners();
    });
  }

  void _getUniquePlatforms() {
    _uniquePlatforms = {};
    for (var game in _games) {
      _uniquePlatforms.add(game.platform);
    }
  }
}

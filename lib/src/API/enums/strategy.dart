import 'package:tic_tac_toe_lib/src/API/classes/game_strategy.dart';
import 'package:tic_tac_toe_lib/src/classes/strategies/easy_strategy.dart';
import 'package:tic_tac_toe_lib/src/classes/strategies/hard_strategy.dart';
import 'package:tic_tac_toe_lib/src/classes/strategies/medium_strategy.dart';

enum Strategy {
  easy,
  medium,
  hard,
  twoPlayers;

  GameStrategy? get convertToObj {
    List<GameStrategy?> list = [
      EasyStrategy(),
      MediumStrategy(),
      HardStrategy(),
      null,
    ];
    return list[index];
  }
}

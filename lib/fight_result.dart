import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class FightResult {
  final String result;

  const FightResult._(this.result,this.color);


  final Color color;

  static const won = FightResult._("Won",FightClubColors.greenWin);
  static const lost = FightResult._("Lost",FightClubColors.redLost);
  static const draw = FightResult._("Draw",FightClubColors.blueDraw);

  static const values = [won,lost,draw];


  static FightResult getByName(final String name) {
    return values.firstWhere((fightResult) => fightResult.result == name);
  }


  static FightResult? calculateResult(final int yourLives, final int enemysLives) {
    if(yourLives == 0 && enemysLives == 0){
      return draw;
    } else if (yourLives == 0) {
      return lost;
    } else if (enemysLives == 0){
      return won;
    }
    return null;
  }

  @override
  String toString() {
    return result;
  }
}
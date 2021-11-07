import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';

class FightResultWidget extends StatelessWidget {
  final FightResult fightResult;

  const FightResultWidget({Key? key, required this.fightResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    height: 160,
    child: Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:  const [
            Expanded(child: ColoredBox(color: Colors.white)),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, FightClubColors.darkPurple],
                  ),
                ),
              ),
            ),
            Expanded(child: ColoredBox(color: FightClubColors.darkPurple,))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 16),
            Column(children: [
              const SizedBox(height: 16),
              const Text(
                "You",
                style: TextStyle(color: FightClubColors.darkGreyText),
              ),
              const SizedBox(height: 12),
              Image.asset(
                FightClubImages.youAvatar,
                width: 92,
                height: 92,
              ),
            ]),
            Container(
              height: 44,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  color: _getColorForResult(fightResult.toString()),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 12),
                  child: Center(
                    child: Text(
                      fightResult.toString().toLowerCase(),
                      style: const TextStyle(color: Colors.white,fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Enemy",
                  style: TextStyle(color: FightClubColors.darkGreyText),
                ),
                const SizedBox(height: 12),
                Image.asset(
                  FightClubImages.enemyAvatar,
                  width: 92,
                  height: 92,
                ),
              ],
            ),
            const SizedBox(width: 16),
          ],
        ),
      ],
    ),
    );
  }

  _getColorForResult(String result) {
    if(result == "Won" ) {
      return FightClubColors.greenWin;
    } else {
      return result == "Draw" ? FightClubColors.blueDraw : FightClubColors.redLost;
    }
  }
}

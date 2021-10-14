import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'fight_club_images.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme:
              GoogleFonts.pressStart2pTextTheme(Theme.of(context).textTheme)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const maxLives = 5;

  BodyPart? defendingBodyPart = BodyPart.none;
  BodyPart? attackingBodyPart = BodyPart.none;
  BodyPart? whatEnemyAttacks = BodyPart.random();
  BodyPart? whatEnemyDefends = BodyPart.random();

  int yourLives = maxLives;
  int enemiesLives = maxLives;

  String gameState = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
                maxLivesCount: maxLives,
                yourLivesCount: yourLives,
                enemiesLivesCount: enemiesLives),
            Expanded(
                child: SizedBox(
              width: double.infinity,
              height: 146,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                child: ColoredBox(
                  color: const Color.fromRGBO(197, 209, 234, 1),
                  child: Center(
                      child: Text(
                    gameState,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: FightClubColors.darkGreyText),
                  )),
                ),
              ),
            )),
            ControlsWidget(
                defendingBodyPart: defendingBodyPart,
                selectDefendingBodyPart: _selectDefendingBodyPart,
                attackingBodyPart: attackingBodyPart,
                selectAttackingBodyPart: _selectAttackingBodyPart),
            const SizedBox(height: 14),
            GoButton(
                text: yourLives == 0 || enemiesLives == 0
                    ? "Start new game"
                    : "Go",
                onTap: _setGameState,
                getColor: _getColorForGo()),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Color _getColorForGo() {
    if (yourLives == 0 || enemiesLives == 0) {
      return FightClubColors.blackButton;
    } else if (attackingBodyPart == BodyPart.none ||
        defendingBodyPart == BodyPart.none) {
      return FightClubColors.greyButton;
    } else {
      return FightClubColors.blackButton;
    }
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    if (yourLives == 0 || enemiesLives == 0) {
      return;
    }
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(final BodyPart value) {
    if (yourLives == 0 || enemiesLives == 0) {
      return;
    }
    setState(() {
      attackingBodyPart = value;
    });
  }

  void _setGameState() {
    if (yourLives == 0 || enemiesLives == 0) {
      setState(() {
        yourLives = maxLives;
        enemiesLives = maxLives;
        gameState = "Draw";
      });
    } else {
      if (attackingBodyPart != BodyPart.none &&
          defendingBodyPart != BodyPart.none) {
        setState(() {
          gameState = "";
          final bool enemyLoseLife = attackingBodyPart != whatEnemyDefends;
          final bool yourLoseLife = defendingBodyPart != whatEnemyAttacks;

          if (enemyLoseLife) {
            enemiesLives -= 1;
            if (enemiesLives == 0) {
              gameState = "You won";
            } else {
              gameState = "You hit enemy’s " + attackingBodyPart!.name.toLowerCase() + ".\n";
            }
          } else {
            gameState = "Your attack was blocked.\n";
          }

          if (yourLoseLife) {
            yourLives -= 1;
            if (yourLives == 0) {
              gameState = "You lost";
            } else {
              gameState += enemiesLives == 0 ? "" : "Enemy hit your " + whatEnemyAttacks!.name.toLowerCase() + ".\n";
            }
          } else {
            gameState += enemiesLives == 0 ? "" : "Enemy’s attack was blocked.";
          }

          whatEnemyDefends = BodyPart.random();
          whatEnemyAttacks = BodyPart.random();

          attackingBodyPart = BodyPart.none;
          defendingBodyPart = BodyPart.none;
        });
      }
    }
  }
}

class GoButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color getColor;
  final String text;

  const GoButton(
      {Key? key,
      required this.onTap,
      required this.getColor,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
            height: 40,
            child: ColoredBox(
              color: getColor,
              child: Center(
                child: Text(
                  text.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: FightClubColors.whiteText),
                ),
              ),
            )),
      ),
    );
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemiesLivesCount;

  const FightersInfo({
    Key? key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemiesLivesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Expanded(
                  child: ColoredBox(
                color: Colors.white,
              )),
              Expanded(child: ColoredBox(color: Color(0xFFC5D1EA)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LivesWidget(
                  overallLivesCount: maxLivesCount,
                  currentLivesCount: yourLivesCount),
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
              const ColoredBox(
                color: Colors.green,
                child: SizedBox(height: 44, width: 44),
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
              LivesWidget(
                  overallLivesCount: maxLivesCount,
                  currentLivesCount: enemiesLivesCount),
            ],
          ),
        ],
      ),
    );
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  const ControlsWidget(
      {Key? key,
      this.defendingBodyPart,
      this.attackingBodyPart,
      required this.selectDefendingBodyPart,
      required this.selectAttackingBodyPart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: <Widget>[
              Text("Defend".toUpperCase(),
                  style: const TextStyle(color: FightClubColors.darkGreyText)),
              const SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingBodyPart == BodyPart.head,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              const SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: defendingBodyPart == BodyPart.legs,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              const SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torse,
                selected: defendingBodyPart == BodyPart.torse,
                bodyPartSetter: selectDefendingBodyPart,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: <Widget>[
              Text("Attack".toUpperCase(),
                  style: const TextStyle(color: FightClubColors.darkGreyText)),
              const SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: attackingBodyPart == BodyPart.head,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              const SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attackingBodyPart == BodyPart.legs,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              const SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torse,
                selected: attackingBodyPart == BodyPart.torse,
                bodyPartSetter: selectAttackingBodyPart,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16)
      ],
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._("Head");
  static const torse = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");
  static const none = BodyPart._("None");

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }

  static const List<BodyPart> _values = [head, torse, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;

  const LivesWidget(
      {Key? key,
      required this.overallLivesCount,
      required this.currentLivesCount})
      : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(overallLivesCount, (index) {
        if (index < currentLivesCount) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Image.asset(
              FightClubIcons.heartFull,
              width: 18,
              height: 18,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Image.asset(
              FightClubIcons.heartEmpty,
              width: 18,
              height: 18,
            ),
          );
        }
      }),
    );
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color: selected
              ? FightClubColors.blueButton
              : FightClubColors.greyButton,
          child: Center(
              child: Text(
            bodyPart.name.toUpperCase(),
            style: TextStyle(
                color: selected
                    ? FightClubColors.whiteText
                    : FightClubColors.darkGreyText),
          )),
        ),
      ),
    );
  }
}

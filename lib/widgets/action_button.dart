import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color getColor;
  final String text;

  const ActionButton(
      {Key? key,
        required this.onTap,
        required this.getColor,
        required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: getColor,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        alignment: Alignment.center,
        child:Text(
          text.toUpperCase(),
          style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: FightClubColors.whiteText
          ),
        ) ,
      ),
    );
  }
}
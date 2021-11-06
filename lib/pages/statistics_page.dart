import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              child: const Text(
                "Statistics",
                style: TextStyle(color: FightClubColors.darkGreyText,fontWeight: FontWeight.w400,fontSize: 24),
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SecondaryActionButton(
                  onTap: () => {Navigator.of(context).pop()}, text: "Back"),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/pages/statistics_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:flutter_fight_club/widgets/fight_result_widget.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MainPageContent();
  }
}

class _MainPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Center(
              child: Text("The\nFight\nClub".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 30, color: FightClubColors.darkGreyText)),
            ),
            const Expanded(child: SizedBox()),
            FutureBuilder<String?>(
              future: SharedPreferences.getInstance().then(
                      (sharedPreferences) =>
                      sharedPreferences.getString("last_fight_result")),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox();
                } else {
                  FightResult result = FightResult.won;
                  if(snapshot.data == "Won") {
                    result = FightResult.won;
                  } else {
                    result = snapshot.data == "Draw" ?  FightResult.draw : FightResult.lost;
                  }
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            "Last fight result",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: FightClubColors.darkGreyText),
                          ),
                        ),
                      ),
                      FightResultWidget(fightResult: result),
                    ],
                  );
                }
              },
            ),
            const Expanded(child: SizedBox()),
            SecondaryActionButton(
                onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const StatisticsPage()))
                    },
                text: 'Statistics'),
            ActionButton(
                text: "Start".toUpperCase(),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FightPage(),
                    ),
                  );
                },
                getColor: FightClubColors.blackButton),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

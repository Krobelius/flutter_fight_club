import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              child: const Text(
                "Statistics",
                style: TextStyle(
                    color: FightClubColors.darkGreyText,
                    fontWeight: FontWeight.w400,
                    fontSize: 24),
              ),
            ),
            Center(
              child: Column(
                children: [
                  FutureBuilder(
                      future: _getStat("won"),
                      builder: (context, snap) {
                        if (!snap.hasData || snap.data == null) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.0),
                            child: Text("Won: 0"),
                          );
                        } else {
                          return Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 6.0),
                              child: Text("Won: " + snap.data.toString()));
                        }
                      }),
                  FutureBuilder(
                      future: _getStat("draw"),
                      builder: (context, snap) {
                        if (!snap.hasData || snap.data == null) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.0),
                            child: Text("Draw: 0"),
                          );
                        } else {
                          return Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 6.0),
                              child: Text("Draw: " + snap.data.toString()));
                        }
                      }),
                  FutureBuilder(
                      future: _getStat("lost"),
                      builder: (context, snap) {
                        if (!snap.hasData || snap.data == null) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.0),
                            child: Text("Lost: 0"),
                          );
                        } else {
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Text("Lost: " + snap.data.toString()));
                        }
                      }),
                ],
              ),
            ),
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

 Future _getStat(String name) {
    return(SharedPreferences.getInstance().then(
            (sharedPreferences) =>
            sharedPreferences.getInt("stats_"+name)
    ));
  }
}

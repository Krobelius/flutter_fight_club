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
            const Expanded(child: SizedBox.shrink()),
            FutureBuilder<SharedPreferences>(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox();
                } else {
                  final SharedPreferences sp = snapshot.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Won: ${sp.getInt("stats_won") ?? 0}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: FightClubColors.darkGreyText),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Lost: ${sp.getInt("stats_lost") ?? 0}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: FightClubColors.darkGreyText),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Draw: ${sp.getInt("stats_draw") ?? 0}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: FightClubColors.darkGreyText),
                      ),
                      const SizedBox(height: 6),
                    ],
                  );
                }
              },
            ),
            const Expanded(child: SizedBox.shrink()),
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

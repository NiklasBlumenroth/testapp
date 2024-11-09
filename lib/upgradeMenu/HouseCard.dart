import 'package:flutter/material.dart';
import 'package:testapp/upgradeMenu/BuildTimeRow.dart';
import 'package:testapp/upgradeMenu/FlexibleButton.dart';
import 'package:testapp/upgradeMenu/UpgradeTimeRow.dart';

class HouseCard extends StatelessWidget {

  final int level;
  final int count;
  final bool unlocked;
  final int levelUnlockCost;
  final int levelBuyCost;
  final int levelUpgradeCost;
  final String levelBuildTime;
  final String levelUpgradeTime;
  // final Function(int) onUpgrade;
  // final Function(int) onBuy;
  // final Function() onUpgradeAll; // Callback für alle upgraden
  final bool upgrade = true;
  final bool singleBuy = false;

  const HouseCard({
    Key? key,
    required this.level,
    required this.count,
    required this.unlocked,
    required this.levelUnlockCost,
    required this.levelBuyCost,
    required this.levelUpgradeCost,
    required this.levelBuildTime,
    required this.levelUpgradeTime,
    // required this.onUpgrade,
    // required this.onBuy,
    // required this.onUpgradeAll
  })  : super(key: key);


  @override
  Widget build(BuildContext context) {
    final isLocked = !unlocked;

    return Card(
      elevation: isLocked ? 2 : 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: isLocked ? Colors.grey[300] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Level: $level',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isLocked ? Colors.grey : Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Anzahl Häuser: $count',
              style: TextStyle(color: isLocked ? Colors.grey : Colors.black),
            ),
            Text(
              'Baukosten: $levelBuildTime',
              style: TextStyle(color: isLocked ? Colors.grey : Colors.black),
            ),
            if (isLocked)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Noch nicht verfügbar',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            if (!isLocked) ...[
              SizedBox(height: 8),
              BuildTimeRow(buildTime: levelBuildTime),
              UpgradeTimeRow(upgradeTime: levelUpgradeTime),
              SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                 /* // Upgrade Buttons nur anzeigen, wenn upgrades verfügbar sind
                  if (upgrade) ...[
                    FlexibleButton(
                      onPressed: count >= 1 ? () => onUpgrade(1) : null,
                      label: 'Upgrade 1 Haus',
                      color: Colors.orange,
                      enabled: count >= 1,
                    ),
                    FlexibleButton(
                      onPressed: count >= 10 ? () => onUpgrade(10) : null,
                      label: 'Upgrade 10 Häuser',
                      color: Colors.orangeAccent,
                      enabled: count >= 10,
                    ),
                  ],
                  // Nur einen Kauf-Button anzeigen, wenn singleBuy true ist
                  if (singleBuy) ...[
                    FlexibleButton(
                      onPressed: () => onBuy(1),
                      label: 'Freischalten',
                      color: Colors.green,
                    ),
                  ] else ...[
                    FlexibleButton(
                      onPressed: () => onBuy(1),
                      label: 'Kaufen 1 Haus',
                      color: Colors.green,
                    ),
                    FlexibleButton(
                      onPressed: () => onBuy(10),
                      label: 'Kaufen 10 Häuser',
                      color: Colors.greenAccent,
                    ),
                  ],

                  */
                ],
              ),
              // SizedBox(height: 8),
              // if (upgrade) // Nur anzeigen, wenn Upgrades verfügbar sind
              //   Container(
              //     width: double.infinity, // Button auf volle Breite der Card
              //     child: ElevatedButton(
              //       onPressed: onUpgradeAll, // Callback für alle upgraden
              //       child: Text("Alle auf nächstes Level upgraden"),
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.blueGrey,
              //         padding: EdgeInsets.symmetric(vertical: 12),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.zero, // Eckiges Design
              //         ),
              //       ),
              //     ),
              //   ),
            ]
          ],
        ),
      ),
    );
  }
}

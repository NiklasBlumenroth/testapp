import 'package:flutter/cupertino.dart';

class HouseSite {
  String title;
  int maxUnlockedLevel;
  int levelCount;
  int worker;
  List<Haus> houses;

  HouseSite({
    required this.title,
    required this.maxUnlockedLevel,
    required this.levelCount,
    required this.worker,
    required this.houses
  });

  // fromData Methode, die eine Haus-Instanz aus einer Map erstellt
  factory HouseSite.fromData(Map<String, dynamic> data) {
    return HouseSite(
      title: data["title"] as String,
      maxUnlockedLevel: data["maxUnlockedLevel"] as int,
      levelCount: data["levelCount"] as int,
      worker: data["worker"] as int,
      houses: data["houses"] as List<Haus>
    );
  }

}


class Haus {
  late int level;
  late bool unlocked;
  late int levelUnlockCost;
  late int levelBuyCost;
  late int levelUpgradeCost;
  late String levelBuildTime;
  late String levelUpgradeTime;



  Haus({
    required this.level,
    required this.unlocked,
    required this.levelUnlockCost,
    required this.levelBuyCost,
    required this.levelUpgradeCost,
    required this.levelBuildTime,
    required this.levelUpgradeTime
  });

  upgrade(amount){

  }
  buy(buyAmo){

  }

  // fromData Methode, die eine Haus-Instanz aus einer Map erstellt
  factory Haus.fromData(Map<String, dynamic> data) {
    return Haus(
        level: data["level"] as int,
        unlocked: data["unlocked"] as bool,
        levelUnlockCost: data["levelUnlockCost"] as int,
        levelBuyCost: data["levelBuyCost"] as int,
        levelUpgradeCost: data["levelUpgradeCost"] as int,
        levelBuildTime: data["levelBuildTime"] as String,
        levelUpgradeTime: data["levelUpgradeTime"] as String
    );
  }
}
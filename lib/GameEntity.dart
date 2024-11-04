abstract class GameEntity {
  String get title;
  int get max_level;
  bool get upgradable;
  bool get singleBuy;
  Map<String, dynamic> get data;
}

class UpgradableEntity implements GameEntity {
  String title;
  int max_level;
  bool upgradable;
  bool singleBuy;
  Map<String, dynamic> data;

  UpgradableEntity({
    required this.title,
    required this.max_level,
    required this.upgradable,
    required this.singleBuy,
    required this.data
  });


}

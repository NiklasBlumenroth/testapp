abstract class CardEntity {
  int get level;
  int get cost;
  String get buildTime;
  String get upgradeTime;
  int get count;

  

}


class SingleCard implements CardEntity {
  late int level;
  late int cost;
  late String buildTime;
  late String upgradeTime;
  late int count;

  SingleCard({
    required this.level,
    required this.cost,
    required this.buildTime,
    required this.upgradeTime,
    required this.count
  });


}
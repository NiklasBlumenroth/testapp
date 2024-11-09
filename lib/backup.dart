// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart'; // Importiere den Provider
// import 'package:testapp/CardEntity.dart';
// import 'package:testapp/submenu/SubMenuSite.dart';
// import 'balance_provider.dart'; // Importiere den BalanceProvider
// import 'package:testapp/upgradeMenu/HouseCard.dart';
//
// class HousePage extends StatefulWidget {
//   final String title;
//   const HousePage({Key? key, required this.title}) : super(key: key);
//
//   @override
//   _HousePageState createState() => _HousePageState();
// }
//
// class _HousePageState extends State<HousePage> {
//   late SubMenuSite site;  // site ist jetzt vom Typ SubMenuSite
//   late Future<Map<String, dynamic>> futureData; // Wir holen Daten für das site Objekt
//   List<Map<String, dynamic>> transactionLog = [];
//
//   // Methode zum Hinzufügen von Aktivitäten zur Liste
//   void _addTransaction(String level, String action, int cost) {
//     setState(() {
//       transactionLog.add({
//         'level': level,
//         'action': action,
//         'cost': cost,
//         'time': DateTime.now(),
//       });
//     });
//   }
//
//
//   // Methode zum Entfernen und Zurückerstatten des Guthabens
//   void _removeTransaction(int index) {
//     final balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
//     final transaction = transactionLog[index];
//
//     // Kosten dem Guthaben wieder hinzufügen
//     balanceProvider.updateBalance(transaction['cost']);
//
//     setState(() {
//       transactionLog.removeAt(index);
//     });
//   }
//
//   Future<Map<String, dynamic>> _fetchData() async {
//     // JSON-Datei laden
//     final String response = await rootBundle.loadString('assets/menu.json');
//
//     // JSON-Daten decodieren
//     Map<String, dynamic> data = json.decode(response);
//
//     // Menü-Daten als Liste laden
//     List<dynamic> menu = data["menu"];
//
//     // Den richtigen Eintrag basierend auf dem Titel finden
//     var selectedItem = menu.firstWhere(
//           (item) => item["title"] == widget.title,
//       orElse: () => null,
//     );
//
//     if (selectedItem != null) {
//       return selectedItem;  // Der Eintrag wird zurückgegeben, wenn er gefunden wurde
//     } else {
//       throw Exception("Fehler: Kein Eintrag mit dem Titel '${widget.title}' gefunden");
//     }
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     futureData = _fetchData(); // Daten holen
//     loadSiteData(); // Daten laden und site setzen
//   }
//
//   Future<void> loadSiteData() async {
//     try {
//       final data = await _fetchData(); // Daten laden
//       setState(() {
//         site = Haus(
//           title: data["title"],
//           maxUnlockedLevel: data["maxUnlockedLevel"],
//           count: List<int>.from(data["count"]),
//           levelCount: data["levelCount"],
//           levelUnlockCost: List<int>.from(data["levelUnlockCost"]),
//           levelBuyCost: List<int>.from(data["levelBuyCost"]),
//           levelUpgradeCost: List<int>.from(data["levelUpgradeCost"]),
//           levelBuildTime: List<String>.from(data["levelBuildTime"]),
//           levelUpgradeTime: List<String>.from(data["levelUpgradeTime"]),
//           worker: data["worker"],
//         );
//       });
//     } catch (error) {
//       print("Error loading data: $error"); // Fehlerbehandlung
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: site.levelCount + 1, // Ein Tab mehr für die Übersicht
//       child: Scaffold(
//         appBar: AppBar(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(widget.title),
//               Consumer<BalanceProvider>(builder: (context, balanceProvider, _) {
//                 return Text(
//                   'Guthaben: ${balanceProvider.balance}€',
//                   style: TextStyle(fontSize: 16),
//                 );
//               }),
//             ],
//           ),
//           backgroundColor: Colors.green,
//           bottom: PreferredSize(
//             preferredSize: Size.fromHeight(kToolbarHeight),
//             child: TabBar(
//               isScrollable: true,
//               tabs: [
//                 Tab(text: 'Übersicht'), // Tab für die Übersicht
//                 ...List.generate(site.levelCount, (index) {
//                   final isLocked = index > site.maxUnlockedLevel;
//                   return Tab(
//                     text: 'Level ${index + 1}',
//                     icon: Icon(
//                       isLocked ? Icons.lock : Icons.lock_open,
//                       color: isLocked ? Colors.grey : Colors.black,
//                     ),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ),
//         body: FutureBuilder<Map<String, dynamic>>(
//           future: futureData,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text("Fehler: ${snapshot.error}"));
//             } else if (snapshot.hasData) {
//               final data = snapshot.data!;
//
//               site = Haus(
//                 title: data["title"],
//                 maxUnlockedLevel: data["maxUnlockedLevel"],
//                 count: List<int>.from(data["count"]),
//                 levelCount: data["levelCount"],
//                 levelUnlockCost: List<int>.from(data["levelUnlockCost"]),
//                 levelBuyCost: List<int>.from(data["levelBuyCost"]),
//                 levelUpgradeCost: List<int>.from(data["levelUpgradeCost"]),
//                 levelBuildTime: List<String>.from(data["levelBuildTime"]),
//                 levelUpgradeTime: List<String>.from(data["levelUpgradeTime"]),
//                 worker: data["worker"],
//               );
//
//               return TabBarView(
//                 children: [
//                   // Übersicht-Seite mit Arbeiteranzahl und Aktivitätenliste
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Oberer Bereich mit Anzahl der Arbeiter
//                         Text(
//                           'Anzahl der Arbeiter: ${(site as Haus).worker}',
//                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 20),
//                         // Log der Transaktionen
//                         Text(
//                           'Aktivitäten',
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         Expanded(
//                           child: ListView.builder(
//                             itemCount: transactionLog.length,
//                             itemBuilder: (context, index) {
//                               final transaction = transactionLog[index];
//                               return ListTile(
//                                 title: Text(
//                                   '${transaction['level']} - ${transaction['action']}',
//                                 ),
//                                 subtitle: Text(
//                                   'Kosten: ${transaction['cost']}€ - ${transaction['time'].toString().substring(0, 16)}',
//                                 ),
//                                 trailing: IconButton(
//                                   icon: Icon(Icons.delete, color: Colors.red),
//                                   onPressed: () => _removeTransaction(index),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // Level-Ansicht für die weiteren Tabs
//                   ...List.generate(site.levelCount, (index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: ListView(
//                         children: [
//                           HouseCard(
//                             level: index + 1,
//                             cost: (site as Haus).levelBuyCost[index],
//                             buildTime: (site as Haus).levelBuildTime[index],
//                             upgradeTime: (site as Haus).levelUpgradeTime[index],
//                             count: (site as Haus).count[index],
//                             maxLevel: (site as Haus).maxUnlockedLevel,
//                             onUpgrade: (upgradeAmount) {
//                               final balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
//                               final totalCost = (site as Haus).levelUpgradeCost[index] * upgradeAmount;
//
//                               if ((site as Haus).count[index] > 0) {
//                                 if (balanceProvider.balance >= totalCost) {
//                                   balanceProvider.updateBalance(-totalCost);
//                                   (site as Haus).upgrade(upgradeAmount);
//                                   _addTransaction('Level ${index + 1}', 'Upgrade $upgradeAmount', totalCost);
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(
//                                         'Nicht genügend Guthaben! Ihr Guthaben beträgt: ${balanceProvider.balance}€',
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               }
//                             },
//                             onBuy: (buyAmount) {
//                               final balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
//                               final totalCost = (site as Haus).levelBuyCost[index] * buyAmount;
//                               if (balanceProvider.balance >= totalCost) {
//                                 balanceProvider.updateBalance(-totalCost);
//                                 (site as Haus).buy(buyAmount);
//                                 _addTransaction('Level ${index + 1}', 'Kaufe $buyAmount', totalCost);
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text(
//                                       'Nicht genügend Guthaben! Ihr Guthaben beträgt: ${balanceProvider.balance}€',
//                                     ),
//                                   ),
//                                 );
//                               }
//                             }, onUpgradeAll: () {  },
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//                 ],
//               );
//             } else {
//               return const Center(child: Text("Fehler"));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
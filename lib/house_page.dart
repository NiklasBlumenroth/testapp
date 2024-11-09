import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:testapp/balance_provider.dart';
import 'package:testapp/fetcher/data_fetcher.dart';
import 'package:testapp/submenu/SubMenuSite.dart';
import 'package:testapp/submenu/house_level_tabs.dart';
import 'package:testapp/submenu/house_overview_page.dart';
import 'package:testapp/upgradeMenu/HouseCard.dart';

class HousePage extends StatefulWidget {
  final String title;
  final int levelCount;


  const HousePage({Key? key,
    required this.title,
    required this.levelCount}) : super(key: key);

  @override
  _HousePageState createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> with SingleTickerProviderStateMixin {
  // late Haus site;
  late Future<Map<String, dynamic>> futureData;
  List<Map<String, dynamic>> transactionLog = [];
  TabController? _tabController; // TabController als nullable
  late List<HouseCard> houses;
  late int worker;

  @override
  void initState() {
    super.initState();
    futureData = DataFetcher.fetchData(widget.title);
    loadSiteData();
    // Den TabController nur setzen, wenn site geladen ist
    _tabController = TabController(length: widget.levelCount + 1, vsync: this);
  }

  Future<void> loadSiteData() async {
    try {
      final data = await DataFetcher.fetchData(widget.title);
      setState(() {
        worker = data["worker"];

        List<HouseCard> cards = [];
        for (var item in data['houses']) {
          try{
            cards.add(HouseCard(
              level: data.length,
              unlocked: item["unlocked"] as bool,
              levelUnlockCost: item["levelUnlockCost"] as int,
              levelBuyCost: item["levelBuyCost"] as int,
              levelUpgradeCost: item["levelUpgradeCost"] as int,
              levelBuildTime: item["levelBuildTime"] as String,
              levelUpgradeTime: item["levelUpgradeTime"] as String,
              count: 4,
              // onUpgrade: (int ) {  },
              // onBuy: (int ) {  },
              // onUpgradeAll: () {  },
            ));
          }catch(e, stacktrace){
            print('Es gab einen Fehler: $e');
            print('Stack-Trace: $stacktrace');
          }

        }
        houses = cards;
      });
    } catch (error) {
      print("Error loading data: $error");
    }
  }
  void _addTransaction(String level, String action, int cost) {
    setState(() {
      transactionLog.add({
        'level': level,
        'action': action,
        'cost': cost,
        'time': DateTime.now(),
      });
    });
  }

  void _removeTransaction(int index) {
    final balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
    final transaction = transactionLog[index];
    balanceProvider.updateBalance(transaction['cost']);
    setState(() {
      transactionLog.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Fehler: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          List<HouseCard> cards = [];
          final data = snapshot.data!;
          print('DATA SNAPSHOT' + snapshot.data.toString());
          // worker = data["worker"];
          for (var item in data['houses']) {
            cards.add(HouseCard(
              level: item["level"] as int,
              unlocked: item["unlocked"] as bool,
              levelUnlockCost: item["levelUnlockCost"] as int,
              levelBuyCost: item["levelBuyCost"] as int,
              levelUpgradeCost: item["levelUpgradeCost"] as int,
              levelBuildTime: item["levelBuildTime"] as String,
              levelUpgradeTime: item["levelUpgradeTime"] as String,
              count: item["count"] as int,
              // onUpgrade: (int ) {  },
              // onBuy: (int ) {  },
              // onUpgradeAll: () {  },
            ));
          }
          houses = cards;
          // Sicherstellen, dass der TabController korrekt gesetzt wird, bevor wir die Tabs anzeigen
          _tabController ??= TabController(length: widget.levelCount + 1, vsync: this);

          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title),
                  Consumer<BalanceProvider>(
                    builder: (context, balanceProvider, _) => Text(
                      'Guthaben: ${balanceProvider.balance}€',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              bottom: _tabController != null
                  ? TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: _buildTabs(houses),
              )
                  : null,
            ),
            body: _tabController == null
                ? const Center(child: CircularProgressIndicator()) // Falls noch kein TabController da ist
                : TabBarView(
              controller: _tabController!,
              children: [
                OverviewSection(
                  workerCount: worker,
                  transactionLog: transactionLog,
                  onRemoveTransaction: _removeTransaction,
                ),
                // Passiere den TabController an LevelTabs
                LevelTabs(houses: houses, addTransaction: _addTransaction,),
              ],
            ),
          );
        } else {
          return const Center(child: Text("Fehler"));
        }
      },
    );
  }

  List<Tab> _buildTabs(List<HouseCard> site) {
    return [
      Tab(text: 'Übersicht'),
      ...List.generate(
        widget.levelCount,
            (index) => Tab(
          text: 'Level ${index + 1}',
          icon: Icon(
            houses[index].unlocked == false ? Icons.lock : Icons.lock_open,
          ),
        ),
      ),
    ];
  }

  @override
  void dispose() {
    _tabController?.dispose();  // TabController freigeben, wenn er existiert
    super.dispose();
  }
}

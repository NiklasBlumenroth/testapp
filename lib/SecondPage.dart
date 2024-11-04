import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importiere den Provider
import 'package:testapp/CardEntity.dart';
import 'balance_provider.dart'; // Importiere den BalanceProvider
import 'package:testapp/upgradeMenu/HouseCard.dart';

class SecondPage extends StatelessWidget {
  final String title;
  final int maxLevel;
  final List<CardEntity> data;
  final bool upgradable;
  final bool singleBuy;


  const SecondPage({
    Key? key,
    required this.title,
    required this.data,
    required this.maxLevel,
    required this.upgradable,
    required this.singleBuy
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: data.length,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Consumer<BalanceProvider>(
                builder: (context, balanceProvider, _) {
                  return Text(
                    'Guthaben: ${balanceProvider.balance}€',
                    style: TextStyle(fontSize: 16),
                  );
                },
              ),
            ],
          ),
          backgroundColor: Colors.green,
          bottom: TabBar(
            isScrollable: true,
            tabs: List.generate(data.length, (index) {
              final isLocked = data[index].level > maxLevel; // Zugriff auf level über GameEntity
              return Tab(
                text: 'Level ${index + 1}',
                icon: Icon(
                  isLocked ? Icons.lock : Icons.lock_open,
                  color: isLocked ? Colors.grey : Colors.black,
                ),
              );
            }),
          ),
        ),
        body: TabBarView(
          children: List.generate(data.length, (index) {
            final entitiesAtLevel = data.where((item) => item.level == index + 1).toList();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  ...entitiesAtLevel.map((item) {
                    return HouseCard(
                      level: item.level,
                      cost: item.cost,
                      buildTime: item.buildTime,
                      upgradeTime: item.upgradeTime,
                      count: item.count,
                      maxLevel: maxLevel,
                      unlockCondition: "wadawdawd",
                      singleBuy: singleBuy,
                      upgrade: upgradable,
                      onUpgrade: (upgradeAmount) {
                        final balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
                        final totalCost = item.cost * upgradeAmount;

                        if (item.count > 0) {
                          if (balanceProvider.balance >= totalCost) {
                            balanceProvider.updateBalance(-totalCost);
                            item.upgrade(upgradeAmount); // Verwende die Upgrade-Methode von GameEntity
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Nicht genügend Guthaben! Ihr Guthaben beträgt: ${balanceProvider.balance}€',
                                ),
                              ),
                            );
                          }
                        }
                      },
                      onBuy: (buyAmount) {
                        final balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
                        final totalCost = item.cost * buyAmount;

                        if (balanceProvider.balance >= totalCost) {
                          balanceProvider.updateBalance(-totalCost);
                          item.buy(buyAmount); // Verwende die Buy-Methode von GameEntity
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Nicht genügend Guthaben! Ihr Guthaben beträgt: ${balanceProvider.balance}€',
                              ),
                            ),
                          );
                        }
                      },
                      onUpgradeAll: () {
                        final balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
                        final totalUpgradeCost = item.cost * item.count;

                        if (balanceProvider.balance >= totalUpgradeCost) {
                          balanceProvider.updateBalance(-totalUpgradeCost);
                          item.upgrade(item.count); // Upgrade alle Einheiten
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Nicht genügend Guthaben für das Upgrade aller Objekte! Ihr Guthaben beträgt: ${balanceProvider.balance}€',
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }).toList(),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

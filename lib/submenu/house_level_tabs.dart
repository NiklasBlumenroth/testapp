import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/balance_provider.dart';
import 'package:testapp/submenu/SubMenuSite.dart';
import 'package:testapp/upgradeMenu/HouseCard.dart';

class LevelTabs extends StatelessWidget {
  final List<HouseCard> houses;
  final Function(String, String, int) addTransaction;

  LevelTabs({required this.houses, required this.addTransaction});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: houses.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: HouseCard(
            level: index + 1,
            unlocked: houses[index].unlocked,
            levelUnlockCost: houses[index].levelUnlockCost,
            levelBuyCost: houses[index].levelBuyCost,
            levelUpgradeCost: houses[index].levelUpgradeCost,
            levelBuildTime: houses[index].levelBuildTime,
            levelUpgradeTime: "",
            count: houses[index].count,
            // onUpgrade: (upgradeAmount) {
            //   final balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
            //   final totalCost = houses[index].levelUpgradeCost * upgradeAmount;
            //
            //   if (houses[index].count > 0) {
            //     if (balanceProvider.balance >= totalCost) {
            //       balanceProvider.updateBalance(-totalCost);
            //       // site.upgrade(buyAmount);
            //       addTransaction('Level ${index + 1}', 'Upgrade $upgradeAmount', totalCost);
            //     } else {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text('Nicht genügend Guthaben! Ihr Guthaben beträgt: ${balanceProvider.balance}€'),
            //         ),
            //       );
            //     }
            //   }
            // },
            // onBuy: (buyAmount) {
            //   final balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
            //   final totalCost = houses[index].levelBuyCost * buyAmount;
            //   if (balanceProvider.balance >= totalCost) {
            //     balanceProvider.updateBalance(-totalCost);
            //     // site.buy(buyAmount);
            //     addTransaction('Level ${index + 1}', 'Kaufe $buyAmount', totalCost);
            //   } else {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(
            //         content: Text('Nicht genügend Guthaben! Ihr Guthaben beträgt: ${balanceProvider.balance}€'),
            //       ),
            //     );
            //   }
            // },
            // onUpgradeAll: () { /* Implement all-upgrade logic if needed */ },
          ),
        );
      },
    );
  }
}

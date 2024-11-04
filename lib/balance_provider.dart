import 'package:flutter/material.dart';

class BalanceProvider with ChangeNotifier {
  int _balance;

  BalanceProvider(this._balance); // Initialisiere das Guthaben über den Konstruktor

  int get balance => _balance;

  void updateBalance(int amount) {
    _balance += amount;
    notifyListeners();
  }
}

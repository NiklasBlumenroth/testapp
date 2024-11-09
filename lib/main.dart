import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'SingleElem.dart';

import 'StoryPage.dart';
import 'KartePage.dart';
import 'MaschinePage.dart';
import 'balance_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BalanceProvider(10000)), // Setze Startguthaben hier
      ],
      child: const TestApp(),
    ),
  );
}

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  _TestAppState createState() => _TestAppState();
}

class Items {
  final String title;
  final int count;

  Items(this.title, this.count);
}

class _TestAppState extends State<TestApp> {
  late Future<List<Items>> futureProducts;
  int _selectedIndex = 0; // Aktueller Index der ausgewählten Seite

  @override
  void initState() {
    super.initState();
    futureProducts = loadMenuData();
  }

  Future<List<Items>> loadMenuData() async {
    final String response = await rootBundle.loadString('assets/menu.json');
    final data = json.decode(response);

    List<Items> menuItems = [];

    for (var item in data['menu']) {
      String title = item['title'];
      int count = item['levelCount'];
      Items items = Items(title, count);
      menuItems.add(items);
    }

    return menuItems;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return FutureBuilder<List<Items>>( // Hauptseite
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Fehler: ${snapshot.error}'));
            } else {
              final products = snapshot.data!;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, i) {
                  String titel = products[i].title;
                  int count = products[i].count;
                  return SingleElem(titel, count);
                },
              );
            }
          },
        );
      case 1:
        return KartePage();
      case 2:
        return MaschinePage();
      case 3:
        return StoryPage();
      default:
        return Container();
    }
  }

  Color _getButtonColor(int index) {
    return _selectedIndex == index ? Colors.green : Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Füge MaterialApp hinzu
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('TestApp'),
              Row(
                children: [
                  const Icon(Icons.account_balance_wallet, color: Colors.white),
                  const SizedBox(width: 5),
                  Consumer<BalanceProvider>(
                    builder: (context, balanceProvider, _) {
                      return Text(
                        '${balanceProvider.balance}€',
                        style: const TextStyle(fontSize: 18),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: const Color.fromRGBO(45, 150, 60, 1),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Container(
              color: const Color.fromRGBO(30, 80, 70, 1),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: _getButtonColor(0),
                      child: IconButton(
                        icon: const Icon(Icons.list, color: Colors.white),
                        onPressed: () => _onItemTapped(0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: _getButtonColor(1),
                      child: IconButton(
                        icon: const Icon(Icons.map, color: Colors.white),
                        onPressed: () => _onItemTapped(1),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: _getButtonColor(2),
                      child: IconButton(
                        icon: const Icon(Icons.device_hub, color: Colors.white),
                        onPressed: () => _onItemTapped(2),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: _getButtonColor(3),
                      child: IconButton(
                        icon: const Icon(Icons.book, color: Colors.white),
                        onPressed: () => _onItemTapped(3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: _getPage(_selectedIndex),
        backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/services.dart';

class DataFetcher {
  static Future<Map<String, dynamic>> fetchData(String title) async {
    final String response = await rootBundle.loadString('assets/menu.json');
    Map<String, dynamic> data = json.decode(response);
    List<dynamic> menu = data["menu"];
    var selectedItem = menu.firstWhere(
          (item) => item["title"] == title,
      orElse: () => null,
    );
    if (selectedItem != null) {
      return selectedItem;
    } else {
      throw Exception("Kein Eintrag mit dem Titel '$title' gefunden");
    }
  }
}

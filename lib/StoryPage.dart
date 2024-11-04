import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int populationCount = 0;
  int populationMax = 0;
  int energyCount = 0;
  int energyProduced = 0;
  int energySave = 0;
  int foodCount = 0;
  int foodProduced = 0;
  int foodSaved = 0;
  int actualSteps = 0;
  int stepsSaved = 0;

  @override
  void initState() {
    super.initState();
    loadStatsData();
  }

  Future<void> loadStatsData() async {
    try {
      // Lade die JSON-Daten
      final String response = await rootBundle.loadString('assets/statistics.json');
      final data = json.decode(response);

      setState(() {
        // Setze die Werte aus der JSON-Datei
        populationCount = data['statistics']['populationCount'];
        populationMax = data['statistics']['populationMax'];
        energyCount = data['statistics']['energyCount'];
        energyProduced = data['statistics']['energyProduced'];
        energySave = data['statistics']['energySave'];
        foodCount = data['statistics']['foodCount'];
        foodProduced = data['statistics']['foodProduced'];
        foodSaved = data['statistics']['foodSaved'];
        actualSteps = data['statistics']['actualSteps'];
        stepsSaved = data['statistics']['stepsSaved'];
      });
    } catch (error) {
      print('Fehler beim Laden der Statistikdaten: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistik')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spielstatistik',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildStatCard('Bevölkerung', '$populationCount / $populationMax'),
            _buildStatCard('Energie', '$energyCount / $energyProduced'),
            _buildStatCard('Nahrung', '$foodCount / $foodProduced'),
            _buildStatCard('Maximale Schritte', '$actualSteps'),
            SizedBox(height: 20),
            Text(
              'Speicheroptionen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildStatCard('Energie', 'Speicher: $energySave'),
            _buildStatCard('Nahrung', 'Speicher: $foodSaved'),
            _buildStatCard('Schritte', 'Speicher: $stepsSaved'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

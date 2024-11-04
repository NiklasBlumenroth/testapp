import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/GameEntity.dart';
import 'package:testapp/SecondPage.dart';

class SingleElem extends StatelessWidget {
  final GameEntity itemData; // Ändere den Datentyp zu GameEntity

  const SingleElem(this.itemData); // Übergebe ein GameEntity-Objekt

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 4.0),
        leading: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.smart_button_outlined),
        ),
        title: GestureDetector(
          onTap: () {
            // Navigation zur SecondPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondPage(
                  title: itemData.title, // Zugriff auf den Titel über GameEntity
                  data: [itemData], // Übergabe des GameEntity-Objekts als Liste
                  maxLevel: itemData.max_level, // Zugriff auf maxLevel
                  singleBuy: itemData.singleBuy,
                  upgradable: itemData.upgradable,
                ),
              ),
            );
          },
          child: Text(
            itemData.title, // Zugriff auf den Titel über GameEntity
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

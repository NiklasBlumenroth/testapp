import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'house_page.dart';

class SingleElem extends StatelessWidget {
  final String title; // Ändere den Datentyp zu GameEntity
  final int levelCount;
  const SingleElem(this.title, this.levelCount); // Übergebe ein GameEntity-Objekt

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
                builder: (context) {
                  switch (this.title) {
                    case "Häuser": return HousePage(title: this.title, levelCount: this.levelCount);
                    default:
                      return HousePage(title: this.title, levelCount: this.levelCount,); // Fallback-Seite, falls keine Übereinstimmung
                  }
                },
              ),
            );

          },
          child: Text(
            this.title,
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

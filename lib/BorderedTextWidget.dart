import 'package:flutter/material.dart';

class BorderedTextWidget extends StatelessWidget {
  final String text;

  const BorderedTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0), // Abstand zwischen Text und Rahmen
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2), // Rahmenfarbe und -breite
          borderRadius: BorderRadius.circular(8.0), // Eckenabrundung des Rahmens
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 18), // Textstil
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text("Umrahmter Text")),
      body: BorderedTextWidget(text: "Dies ist ein umrahmter Text"),
    ),
  ));
}

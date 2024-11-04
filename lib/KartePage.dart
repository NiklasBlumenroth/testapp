import 'package:flutter/material.dart';

class KartePage extends StatefulWidget {
  @override
  _KartePageState createState() => _KartePageState();
}

class _KartePageState extends State<KartePage> {
  double _scaleFactor = 1.0; // Skalierungsfaktor für das Zoomen
  double _startScale = 1.0; // Startskalierung für das Zoomen
  double _offsetX = 0; // X-Offset für das Scrollen
  double _offsetY = 0; // Y-Offset für das Scrollen

  final double _minScale = 0.5; // Minimaler Zoomfaktor
  final double _maxScale = 3.0; // Maximaler Zoomfaktor

  Offset _startFocalPoint = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Karte')),
      body: GestureDetector(
        onScaleStart: (details) {
          _startScale = _scaleFactor; // Aktuelle Skalierung speichern
          _startFocalPoint = details.focalPoint; // Focal Point speichern
        },
        onScaleUpdate: (details) {
          setState(() {
            // Skalierung anpassen, innerhalb der Grenzen
            _scaleFactor = (_startScale * details.scale).clamp(_minScale, _maxScale);

            // Verschiebung (Scrollen) nur anwenden, wenn sie sinnvoll ist
            if (_scaleFactor > _minScale) {
              final Offset delta = details.focalPoint - _startFocalPoint;
              _offsetX = (_offsetX + delta.dx).clamp(-_getMaxScrollX(), 0);
              _offsetY = (_offsetY + delta.dy).clamp(-_getMaxScrollY(), 0);
              _startFocalPoint = details.focalPoint; // Focal Point aktualisieren
            }
          });
        },
        child: Transform(
          transform: Matrix4.identity()
            ..translate(_offsetX, _offsetY) // Anwendung des Offsets
            ..scale(_scaleFactor), // Skalierung der Karte
          alignment: Alignment.topLeft,
          child: CustomPaint(
            painter: MapPainter(),
            child: Container(
              width: 1000, // Breite der Karte
              height: 1000, // Höhe der Karte
            ),
          ),
        ),
      ),
    );
  }

  double _getMaxScrollX() {
    // Maximaler Scrollwert in X-Richtung
    return (1000 * _scaleFactor) - MediaQuery.of(context).size.width;
  }

  double _getMaxScrollY() {
    // Maximaler Scrollwert in Y-Richtung
    return (1000 * _scaleFactor) - MediaQuery.of(context).size.height;
  }
}

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    // Hintergrundfarbe
    paint.color = Colors.lightBlue[100]!;
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paint);

    // Straßen zeichnen
    paint.color = Colors.grey[600]!;
    canvas.drawRect(Rect.fromLTRB(0, size.height * 0.6, size.width, size.height * 0.65), paint); // Horizontale Straße
    canvas.drawRect(Rect.fromLTRB(size.width * 0.4, 0, size.width * 0.45, size.height), paint); // Vertikale Straße

    // Häuser zeichnen
    paint.color = Colors.brown; // Hausfarbe
    canvas.drawRect(Rect.fromLTRB(size.width * 0.1, size.height * 0.4, size.width * 0.3, size.height * 0.6), paint); // Haus 1
    canvas.drawRect(Rect.fromLTRB(size.width * 0.5, size.height * 0.4, size.width * 0.7, size.height * 0.6), paint); // Haus 2

    // Fenster zeichnen
    paint.color = Colors.white;
    canvas.drawRect(Rect.fromLTRB(size.width * 0.15, size.height * 0.45, size.width * 0.25, size.height * 0.55), paint); // Fenster 1
    canvas.drawRect(Rect.fromLTRB(size.width * 0.55, size.height * 0.45, size.width * 0.65, size.height * 0.55), paint); // Fenster 2

    // Grünflächen zeichnen
    paint.color = Colors.green;
    canvas.drawRect(Rect.fromLTRB(size.width * 0.2, size.height * 0.65, size.width * 0.8, size.height * 0.8), paint); // Park
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
    }
}
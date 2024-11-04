import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlexibleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color color;
  final bool enabled; // Neue Eigenschaft

  const FlexibleButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.color,
    this.enabled = true, // Standardmäßig aktiviert
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null, // Button wird deaktiviert, wenn nicht aktiviert
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? color : Colors.grey, // Farbe anpassen, wenn deaktiviert
      ),
      child: Text(label),
    );
  }
}

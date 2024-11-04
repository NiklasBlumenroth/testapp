import 'package:flutter/cupertino.dart';

class BuildTimeRow extends StatelessWidget {
  final String buildTime;

  const BuildTimeRow({Key? key, required this.buildTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Bauzeit: $buildTime',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

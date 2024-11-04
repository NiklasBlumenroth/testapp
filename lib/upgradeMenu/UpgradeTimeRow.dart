
import 'package:flutter/cupertino.dart';

class UpgradeTimeRow extends StatelessWidget {
  final String upgradeTime;

  const UpgradeTimeRow({Key? key, required this.upgradeTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Upgrade-Zeit: $upgradeTime',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
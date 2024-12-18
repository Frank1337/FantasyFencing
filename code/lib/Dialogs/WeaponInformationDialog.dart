import 'package:fantasy_fencing/Enumerations/Weapons.dart';
import 'package:flutter/material.dart';

class WeaponInformationDialog extends StatelessWidget {
  final Weapons weapon;

  const WeaponInformationDialog({super.key, required this.weapon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        weapon.name,
        style: const TextStyle(color: Colors.green),
      ),
      content: Text(
        weapon.description,
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

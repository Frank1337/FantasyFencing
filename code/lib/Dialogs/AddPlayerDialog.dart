import 'package:fantasy_fencing/Dialogs/PlayerDialogBase.dart';
import 'package:fantasy_fencing/Enumerations/Weapons.dart';
import 'package:fantasy_fencing/Models/Player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPlayerDialog extends PlayerDialogBase {
  const AddPlayerDialog({super.key, required super.playerList});

  @override
  State<AddPlayerDialog> createState() => _AddPlayerDialogState();
}

class _AddPlayerDialogState extends PlayerDialogBaseState<AddPlayerDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expController = TextEditingController();
  final TextEditingController _killsController = TextEditingController();
  Weapons? _selectedWeapon;

  @override
  void dispose() {
    _nameController.dispose();
    _expController.dispose();
    _killsController.dispose();
    super.dispose();
  }

  void _addPlayer(String name, Weapons waffe, int? exp, int? kills) {
    setState(() {
      widget.playerList.add(Player(
        rang: widget.playerList.length + 1,
        name: name,
        waffe: waffe,
        exp: exp ??
            widget.playerList
                .map((player) => player.exp)
                .reduce((a, b) => a < b ? a : b),
        kills: kills ?? 0,
      ));
      sortPlayersByKills();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Neuen Fantasy Fencer hinzufügen',
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text('Name:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Name eingeben',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Waffe:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<Weapons>(
                    value: _selectedWeapon,
                    isExpanded: true,
                    hint: Text(
                      'Waffe wählen',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    onChanged: (Weapons? newValue) {
                      setState(() {
                        _selectedWeapon = newValue;
                      });
                    },
                    items: Weapons.values.map((Weapons weapon) {
                      return DropdownMenuItem<Weapons>(
                        value: weapon,
                        child: Text(weapon.name),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('EXP:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _expController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      hintText: 'EXP eingeben',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Kills:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _killsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      hintText: 'Kills eingeben',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
          child: const Text('Abbrechen'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
          onPressed:
              (_selectedWeapon != null && _nameController.text.isNotEmpty)
                  ? () {
                      Navigator.of(context).pop();
                      _addPlayer(
                        _nameController.text,
                        _selectedWeapon!,
                        int.tryParse(_expController.text),
                        int.tryParse(_killsController.text),
                      );
                    }
                  : null,
          child: const Text('Hinzufügen'),
        ),
      ],
    );
  }
}

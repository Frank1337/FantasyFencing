import 'package:code/Dialogs/PlayerDialogBase.dart';
import 'package:code/Enumerations/Weapons.dart';
import 'package:code/Models/Player.dart';
import 'package:flutter/material.dart';

class AddBattleDialog extends PlayerDialogBase {
  const AddBattleDialog({super.key, required super.playerList});

  @override
  State<AddBattleDialog> createState() => _AddBattleDialogState();
}

class _AddBattleDialogState extends PlayerDialogBaseState<AddBattleDialog> {
  String? _selectedWinner;
  String? _selectedLoser;

  void _updateBattleResults(String winnerName, String loserName) {
    setState(() {
      Player winner = widget.playerList.firstWhere(
          (player) => player.name == winnerName,
          orElse: () => Player(
              rang: 0,
              name: '',
              waffe: Weapons.Felsenschwert,
              exp: 0,
              kills: 0));
      Player loser = widget.playerList.firstWhere(
          (player) => player.name == loserName,
          orElse: () => Player(
              rang: 0,
              name: '',
              waffe: Weapons.Felsenschwert,
              exp: 0,
              kills: 0));

      if (winner.name.isNotEmpty && loser.name.isNotEmpty) {
        int winnerExpGain = loser.lv;
        int loserExpGain = (winner.lv / 2).floor();

        if (loserExpGain == 0) {
          loserExpGain += 1;
        }

        widget.playerList[widget.playerList.indexOf(winner)] = Player(
          rang: winner.rang,
          name: winner.name,
          waffe: winner.waffe,
          exp: winner.exp + winnerExpGain,
          kills: winner.kills + 1,
        );

        widget.playerList[widget.playerList.indexOf(loser)] = Player(
          rang: loser.rang,
          name: loser.name,
          waffe: loser.waffe,
          exp: loser.exp + loserExpGain,
          kills: loser.kills,
        );

        sortPlayersByKills();

        // Show winner dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(winner.name),
              content: Text('EXP gained: $winnerExpGain'),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Show loser dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(loser.name),
                          content: Text('EXP gained: $loserExpGain'),
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
                      },
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Neuen Kampf eintragen',
        style: TextStyle(color: Colors.green),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text('Sieger:'),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButton<String>(
                  value: _selectedWinner,
                  hint: const Text('Sieger wählen'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedWinner = newValue;
                    });
                  },
                  items: widget.playerList.map((Player player) {
                    return DropdownMenuItem<String>(
                      value: player.name,
                      child: Text(player.name),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Verlierer:'),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButton<String>(
                  value: _selectedLoser,
                  hint: const Text('Verlierer wählen'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLoser = newValue;
                    });
                  },
                  items: widget.playerList.map((Player player) {
                    return DropdownMenuItem<String>(
                      value: player.name,
                      child: Text(player.name),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
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
          onPressed: (_selectedWinner != null && _selectedLoser != null)
              ? () {
                  Navigator.of(context).pop();
                  _updateBattleResults(
                    _selectedWinner!,
                    _selectedLoser!,
                  );
                }
              : null,
          child: const Text('Eintragen'),
        ),
      ],
    );
  }
}

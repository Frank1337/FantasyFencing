import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fantasy_fencing/Dialogs/PlayerDialogBase.dart';
import 'package:fantasy_fencing/Enumerations/Buffs.dart';
import 'package:fantasy_fencing/Models/Player.dart';
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
      Player? winner = widget.playerList.firstWhereOrNull(
        (player) => player.name == winnerName,
      );
      Player? loser = widget.playerList
          .firstWhereOrNull((player) => player.name == loserName);

      if (winner != null && loser != null) {
        int winnerExpGain = loser.lv;
        int loserExpGain = (winner.lv / 2).floor();

        if (loserExpGain == 0) {
          loserExpGain += 1;
        }

        Player newWinner = Player(
          rang: winner.rang,
          name: winner.name,
          waffe: winner.waffe,
          exp: winner.exp + winnerExpGain,
          kills: winner.kills + 1,
        );

        Player newLoser = Player(
          rang: loser.rang,
          name: loser.name,
          waffe: loser.waffe,
          exp: loser.exp + loserExpGain,
          kills: loser.kills,
        );

        bool lvlUpWInner = winner.lv < newWinner.lv;
        bool lvlUpLoser = loser.lv < newLoser.lv;

        // Get random Buffs
        Buffs winnerBuff = BuffsExtension.getRandomBuff();
        Buffs? loserBuff;
        final random = Random();
        if (random.nextDouble() <= 0.6) {
          loserBuff = BuffsExtension.getRandomBuff();
        }

        bool waffentauschWinner = winnerBuff == Buffs.Waffentausch;
        bool waffentauschLoser = loserBuff == Buffs.Waffentausch;

        if (waffentauschWinner) {
          final temp = newWinner.waffe;
          newWinner.waffe = newLoser.waffe;
          newLoser.waffe = temp;
        }

        if (waffentauschLoser) {
          final temp = newWinner.waffe;
          newWinner.waffe = newLoser.waffe;
          newLoser.waffe = temp;
        }

        widget.playerList[widget.playerList.indexOf(winner)] = newWinner;
        widget.playerList[widget.playerList.indexOf(loser)] = newLoser;
        sortPlayersByKills();

        // Show winner dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Herzlichen Glückwunsch ${winner.name}",
                style: const TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dein Bonus:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('EXP gained: +$winnerExpGain'),
                    Text("Kills: +1 (Total ${newWinner.kills})"),
                    if (newWinner.lv % 2 == 0) ...[
                      const Text("Vollheilung durch gerades lvl up!"),
                    ],
                    const SizedBox(height: 10),
                    const Text(
                      "Dein Buff fürs nächste Gefecht:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${winnerBuff.type}: ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: winnerBuff.description,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (waffentauschWinner) ...[
                      const SizedBox(height: 10),
                      Text(
                        "${winner.name} kämpft jetzt mit ${loser.waffe.name} und ${loser.name} mit ${winner.waffe.name}",
                      ),
                    ],
                    if (lvlUpWInner) ...[
                      const SizedBox(height: 10),
                      Text(
                        "Level up! Du bist jetzt Level ${newWinner.lv} und hast ${newWinner.HP} max. HP",
                        style: TextStyle(
                          color: Colors.yellow[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                    // Show loser dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Herzlichen Glückwunsch ${loser.name}",
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Dein Bonus:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text('EXP gained: +$loserExpGain'),
                                Text(
                                    "Wiederbelebung: Du hast wieder ${newLoser.HP} HP"),
                                if (loserBuff != null) ...[
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Dein Buff fürs nächste Gefecht:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${loserBuff.type}: ',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: loserBuff.description,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                if (waffentauschLoser) ...[
                                  const SizedBox(height: 10),
                                  Text(
                                    "${winner.name} kämpft jetzt mit ${loser.waffe.name} und ${loser.name} mit ${winner.waffe.name}",
                                  ),
                                ],
                                if (lvlUpLoser) ...[
                                  const SizedBox(height: 10),
                                  Text(
                                    "Level up! Du bist jetzt Level ${newLoser.lv} und hast ${newLoser.HP} HP",
                                    style: TextStyle(
                                      color: Colors.yellow[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]
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
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text(
                'Sieger:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButton<String>(
                  value: _selectedWinner,
                  isExpanded: true,
                  hint: Text(
                    'Sieger wählen',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedWinner = newValue;
                    });
                  },
                  items: widget.playerList
                      .where((player) => player.name != _selectedLoser)
                      .map((Player player) {
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
              const Text(
                'Verlierer:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButton<String>(
                  value: _selectedLoser,
                  isExpanded: true,
                  hint: Text('Verlierer wählen',
                      style: TextStyle(color: Colors.grey[400])),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLoser = newValue;
                    });
                  },
                  items: widget.playerList
                      .where((player) => player.name != _selectedWinner)
                      .map((Player player) {
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

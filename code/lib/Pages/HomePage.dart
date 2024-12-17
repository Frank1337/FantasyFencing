import 'package:code/Dialogs/AddBattleDialog.dart';
import 'package:code/Dialogs/AddPlayerDialog.dart';
import 'package:code/Enumerations/Weapons.dart';
import 'package:code/Models/Player.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Player> _playerList = [
    Player(
        rang: 1, name: 'Alice', waffe: Weapons.Blutduerster, exp: 0, kills: 5),
    Player(
        rang: 2, name: 'Bob', waffe: Weapons.Felsenschwert, exp: 1, kills: 5),
    Player(
        rang: 3,
        name: 'Charlie',
        waffe: Weapons.Basiliskenklaue,
        exp: 2,
        kills: 5),
    Player(rang: 4, name: 'David', waffe: Weapons.Nachtdolch, exp: 2, kills: 5),
    Player(
        rang: 5, name: 'Eve', waffe: Weapons.Phoenixzepter, exp: 4, kills: 1),
    Player(rang: 6, name: 'Frank', waffe: Weapons.Eisenfaust, exp: 5, kills: 0),
    Player(
        rang: 7, name: 'Grace', waffe: Weapons.GaiasKetten, exp: 6, kills: 6),
    Player(
        rang: 8, name: 'Heidi', waffe: Weapons.Windfaecher, exp: 7, kills: 7),
    Player(rang: 9, name: 'Ivan', waffe: Weapons.Nebelstab, exp: 8, kills: 8),
    Player(
        rang: 10, name: 'Judy', waffe: Weapons.Felsenschwert, exp: 9, kills: 9),
    Player(
        rang: 11,
        name: 'Kevin',
        waffe: Weapons.Felsenschwert,
        exp: 10,
        kills: 10),
  ];

  void displayAddPlayerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddPlayerDialog(
          playerList: _playerList,
        );
      },
    ).then((_) {
      setState(() {}); // Ensure the HomePage updates after the dialog is closed
    });
  }

  void displayAddBattleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddBattleDialog(
          playerList: _playerList,
        );
      },
    ).then((_) {
      setState(() {}); // Ensure the HomePage updates after the dialog is closed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text(
          "Fantasy Fencing",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(40.0),
                1: FlexColumnWidth(),
                2: FixedColumnWidth(100.0),
                3: FixedColumnWidth(35.0),
                4: FixedColumnWidth(35.0),
                5: FixedColumnWidth(40.0),
                6: FixedColumnWidth(40.0),
              },
              border: TableBorder.all(),
              children: [
                const TableRow(
                  children: [
                    TableCell(child: Center(child: Text('Rang'))),
                    TableCell(child: Center(child: Text('Name'))),
                    TableCell(child: Center(child: Text('Waffe'))),
                    TableCell(child: Center(child: Text('Lv'))),
                    TableCell(child: Center(child: Text('HP'))),
                    TableCell(child: Center(child: Text('EXP'))),
                    TableCell(child: Center(child: Text('Kills'))),
                  ],
                ),
                ..._playerList.map((player) {
                  return TableRow(
                    children: [
                      TableCell(
                          child: Center(child: Text(player.rang.toString()))),
                      TableCell(child: Center(child: Text(player.name))),
                      TableCell(child: Center(child: Text(player.waffe.name))),
                      TableCell(
                          child: Center(child: Text(player.lv.toString()))),
                      TableCell(
                          child: Center(child: Text(player.HP.toString()))),
                      TableCell(
                          child: Center(child: Text(player.exp.toString()))),
                      TableCell(
                          child: Center(child: Text(player.kills.toString()))),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => displayAddPlayerDialog(context),
              tooltip: 'Spieler hinzufügen',
              child: const Icon(
                Icons.person_add,
                size: 35,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 80, // Adjust the distance between the buttons
            child: FloatingActionButton(
                onPressed: () => displayAddBattleDialog(context),
                tooltip: 'Kampf eintragen',
                child: Image.asset("images/battle_icon.png")),
          ),
        ],
      ),
    );
  }
}

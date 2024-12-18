import 'package:fantasy_fencing/Dialogs/AddBattleDialog.dart';
import 'package:fantasy_fencing/Dialogs/AddPlayerDialog.dart';
import 'package:fantasy_fencing/Dialogs/WeaponInformationDialog.dart';
import 'package:fantasy_fencing/Enumerations/Weapons.dart';
import 'package:fantasy_fencing/Models/Player.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _tableContentRowHeight = 40;
  final double _tableHeaderRowHeight = 40;
  final List<Player> _playerList = [
    //   Player(
    //       rang: 1, name: 'Alice', waffe: Weapons.Blutduerster, exp: 0, kills: 5),
    //   Player(
    //       rang: 2, name: 'Bob', waffe: Weapons.Felsenschwert, exp: 1, kills: 5),
    //   Player(
    //       rang: 3,
    //       name: 'Charlie',
    //       waffe: Weapons.Basiliskenklaue,
    //       exp: 2,
    //       kills: 5),
    //   Player(rang: 4, name: 'David', waffe: Weapons.Nachtdolch, exp: 2, kills: 5),
    //   Player(
    //       rang: 5, name: 'Eve', waffe: Weapons.Phoenixzepter, exp: 4, kills: 1),
    //   Player(rang: 6, name: 'Frank', waffe: Weapons.Eisenfaust, exp: 5, kills: 0),
    //   Player(
    //       rang: 7, name: 'Grace', waffe: Weapons.GaiasKetten, exp: 6, kills: 6),
    //   Player(
    //       rang: 8, name: 'Heidi', waffe: Weapons.Windfaecher, exp: 7, kills: 7),
    //   Player(rang: 9, name: 'Ivan', waffe: Weapons.Nebelstab, exp: 8, kills: 8),
    //   Player(
    //       rang: 10, name: 'Judy', waffe: Weapons.Felsenschwert, exp: 9, kills: 9),
    //   Player(
    //       rang: 11,
    //       name: 'Kevin',
    //       waffe: Weapons.Felsenschwert,
    //       exp: 10,
    //       kills: 10),
  ];

  void displayWeaponInformationDialog(BuildContext context, Weapons? weapon) {
    if (weapon == null) {
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WeaponInformationDialog(
          weapon: weapon,
        );
      },
    );
  }

  void displayAddPlayerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddPlayerDialog(
          playerList: _playerList,
        );
      },
    ).then((_) {
      setState(() {});
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
      setState(() {});
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child:
                Image.asset("images/fantasy_fencer_2.jpg", fit: BoxFit.cover),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(40.0),
                      1: FlexColumnWidth(),
                      2: FixedColumnWidth(120.0),
                      3: FixedColumnWidth(35.0),
                      4: FixedColumnWidth(35.0),
                      5: FixedColumnWidth(40.0),
                      6: FixedColumnWidth(40.0),
                    },
                    border: TableBorder.all(color: Colors.white),
                    children: [
                      TableRow(
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        children: [
                          TableCell(
                            child: Container(
                              height: _tableHeaderRowHeight,
                              alignment: Alignment.center,
                              child: const Text('Rang',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: _tableHeaderRowHeight,
                              alignment: Alignment.center,
                              child: const Text('Name',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: _tableHeaderRowHeight,
                              alignment: Alignment.center,
                              child: const Text('Waffe',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: _tableHeaderRowHeight,
                              alignment: Alignment.center,
                              child: const Text('Lv',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: _tableHeaderRowHeight,
                              alignment: Alignment.center,
                              child: const Text('HP',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: _tableHeaderRowHeight,
                              alignment: Alignment.center,
                              child: const Text('EXP',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: _tableHeaderRowHeight,
                              alignment: Alignment.center,
                              child: const Text('Kills',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                      ..._playerList.map((player) {
                        return TableRow(
                          decoration: BoxDecoration(color: Colors.transparent),
                          children: [
                            TableCell(
                              child: Container(
                                height: _tableContentRowHeight,
                                alignment: Alignment.center,
                                child: Text(player.rang.toString(),
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: _tableContentRowHeight,
                                alignment: Alignment.center,
                                child: Text(player.name,
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            TableCell(
                              child: GestureDetector(
                                onTap: () {
                                  displayWeaponInformationDialog(
                                      context, player.waffe);
                                },
                                child: Container(
                                  height: _tableContentRowHeight,
                                  alignment: Alignment.center,
                                  child: Text(player.waffe.name,
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: _tableContentRowHeight,
                                alignment: Alignment.center,
                                child: Text(player.lv.toString(),
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: _tableContentRowHeight,
                                alignment: Alignment.center,
                                child: Text(player.HP.toString(),
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: _tableContentRowHeight,
                                alignment: Alignment.center,
                                child: Text(player.exp.toString(),
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: _tableContentRowHeight,
                                alignment: Alignment.center,
                                child: Text(player.kills.toString(),
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
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
            right: 80,
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

import 'package:code/Models/Player.dart';
import 'package:flutter/material.dart';

abstract class PlayerDialogBase extends StatefulWidget {
  final List<Player> playerList;

  const PlayerDialogBase({super.key, required this.playerList});
}

abstract class PlayerDialogBaseState<T extends PlayerDialogBase>
    extends State<T> {
  @protected
  void sortPlayersByKills() {
    widget.playerList.sort((a, b) {
      if (b.kills != a.kills) {
        return b.kills.compareTo(a.kills);
      } else {
        return b.exp.compareTo(a.exp);
      }
    });

    int currentRank = 1;
    for (int i = 0; i < widget.playerList.length; i++) {
      if (i > 0 &&
          (widget.playerList[i].kills != widget.playerList[i - 1].kills ||
              widget.playerList[i].exp != widget.playerList[i - 1].exp)) {
        currentRank = i + 1;
      }
      widget.playerList[i] = Player(
        rang: currentRank,
        name: widget.playerList[i].name,
        waffe: widget.playerList[i].waffe,
        exp: widget.playerList[i].exp,
        kills: widget.playerList[i].kills,
      );
    }
  }
}

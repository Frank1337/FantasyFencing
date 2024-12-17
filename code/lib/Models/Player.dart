import 'package:code/Enumerations/Weapons.dart';

class Player {
  final int rang;
  final String name;
  final Weapons waffe;
  final int exp;
  final int kills;

  Player({
    required this.rang,
    required this.name,
    required this.waffe,
    required this.exp,
    required this.kills,
  });

  int get lv {
    int level = 1;
    int expThreshold = 0;
    int remainingExp = exp;

    while (remainingExp >= expThreshold) {
      remainingExp -= expThreshold;
      level++;
      expThreshold = level - 1;
    }

    return level - 1;
  }

  int get HP {
    return 3 + lv;
  }
}

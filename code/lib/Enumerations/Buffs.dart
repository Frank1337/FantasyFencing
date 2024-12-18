import 'dart:math';

enum Buffs {
  SofortHeilungKlein(
      'Kleiner Powernap', 'Du erhältst sofort eine Heilung von 1 HP', 0.125),
  SofortHeilungMittel(
      'Kurzes Chillout', 'Du erhältst sofort eine Heilung von 2 HP', 0.05),
  SofortHeilungGross('Erholsame Meditation',
      'Du erhältst sofort eine Heilung von 3 HP', 0.025),
  SofortSchadenKlein(
      'Blauer Fleck',
      'Du erhälst sofort 1 Schaden. Hast du nur ein Leben bekommst du keinen Schaden (Was ein Glück!). Der Effekt tritt nach deiner Vollheilung in Kraft falls du ein lvl up hast.',
      0.0625),
  SofortSchadenMittel(
      'Hingefallen',
      'Du erhälst sofort 2 Schaden. Hast du 2 oder weniger Leben, dann reduziert sich dein Leben auf 1. Der Effekt tritt nach deiner Vollheilung in Kraft falls du ein lvl up hast.',
      0.0375),
  SofortSchadenGross(
      'Wunde',
      'Du erhälst sofort 3 Schaden. Hast du 3 oder weniger Leben, dann reduziert sich dein Leben auf 1. Der Effekt tritt nach deiner Vollheilung in Kraft falls du ein lvl up hast.',
      0.025),
  Erstschlag(
      'Erstschlag',
      'Wenn du als erstes triffst, fügst du bei deinem ersten Treffer ein Schaden mehr zu',
      0.15),
  Waffentausch(
      'Waffentausch', 'Du tauschst die Waffe mit deinem letzten Gegner', 0.1),
  Tarnmantel(
      'Tarnmantel',
      'Du wirst unsichtbar. der erste Gegentreffer im nächsten Gefecht macht dir 0 Schaden.',
      0.15),
  Laehmung(
      'Laehmung',
      'Deine Beine fühlen sich ganz schwach an. Du darfst deine Beine nicht bewegen bis der erste Treffer im neuen Gefecht gefallen ist.',
      0.05),
  BeserkerModus(
      'Beserker Modus',
      'Du bist völlig in rage! Alle deine Treffer machen im nächsten Gefecht doppelten Schaden.',
      0.025),
  PanzerModus(
      'Panzer Modus',
      'Du fühlst dich undurchdringbar. Jeglicher Schaden im nächsten Gefecht wird halbiert. Bei Dezimalwerten wird aufgerundet. bspw würdest du 3 Schaden bekommen, bekommst du staddessen 2 Schaden',
      0.05),
  FaustKampf(
      'Faust Kampf',
      'Du fichst im nächsten Gefecht nur mit deinen Fäusten. Das heißt der Effekt deiner Waffe ist ausgesetzt.',
      0.05),
  Entwaffnet(
      'Entwaffnet',
      'Du entwaffnest deinen nächsten Gegner. Das heißt der Effekt der Waffe deines Gegners ist ausgesetzt.',
      0.10),
  ;

  final String type;
  final String description;
  final double probabilityWeight;

  const Buffs(this.type, this.description, this.probabilityWeight);
}

extension BuffsExtension on Buffs {
  static Buffs getRandomBuff() {
    final random = Random();
    final totalWeight = Buffs.values
        .fold<double>(0, (sum, buff) => sum + buff.probabilityWeight);
    final randomValue = random.nextDouble() * totalWeight;

    double cumulativeWeight = 0;
    for (var buff in Buffs.values) {
      cumulativeWeight += buff.probabilityWeight;
      if (randomValue <= cumulativeWeight) {
        return buff;
      }
    }

    return Buffs.values.last; // Fallback in case of rounding errors
  }
}

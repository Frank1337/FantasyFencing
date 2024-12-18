enum Weapons {
  Blutduerster("Blutdürster",
      "Jedes mal wenn du deinen Genger triffst bekommst du +1 HP. Wenn du volle HP hast bekommst du kein HP."),
  Felsenschwert("Felsenschwert",
      "Jedes mal wenn du deinen Gegner mit einer Angrifssaktion triffst machst du 2 Schaden."),
  Basiliskenklaue("Basiliskenklaue",
      "Jedes mal wenn du deinen Gegner triffst machst du einen Schaden mehr als vorher. Dein erster Treffer macht 0 Schaden. Das bedeutet erster Treffer: 0 Schaden, zweiter Treffer 1 Schaden, dritter Treffer 2 Schaden usw. "),
  Nachtdolch("Nachtdolch",
      "Jedes mal wenn du deinen Gegner im Nahkampf triffst machst du 3 Schaden."),
  Eisenfaust("Eisenfaust",
      "Jedes mal wenn du deinen Gegner mit einer Verteidigungsaktion (Parade-Riposte) triffst machst du 2 Schaden."),
  Nebelstab("Nebelstab",
      "Jedes dritte mal wenn du deinen Gegner triffst wirst du in Nebel gehüllt. Der nächste Treffer deines gegners macht 0 Schaden. Anschließend verschwidet der Nebel wieder. Falls du bei deinem dritter Treffer schon in Nebel gehüllt bist gibt es kein Effekt."),
  Windfaecher("Windfächer",
      "Jedes mal wen du deinen Gegner gültig oder ungültig triffst wird dein gegner 2 Meter nach hinten versetzt. Falls durch den Effekt von Windfächer dein Gegner hinter die Endlinie geschleudert wird, bekommt dein Gegner 2 Zusatzschaden. Das bedeutet falls dein gegner nach einen gültigen Treffer hinter die Endlinie geschleudert wird bekommt er insgesamt 3 Schaden"),
  GaiasKetten("Gaias Ketten",
      "Jedes zweite mal wenn du deinen Gegner triffst wird er am hinteren Fuß auf dem Boden festgewurzelt. Dein Gegner wird bei der nächsten Gefechtsunterbrechung (gültiger oder ungültiger Treffer von dir oder deinen Gegner) von den Wurzelfesseln befreit."),
  Phoenixzepter("Phönixzepter",
      "Fallen deine HP auf 0, wirst du einmalig mit einem drittel deiner maximalen Leben (abgerundet) wiederbelebt. Bei der Wiederbelebung werden alle negativen Statuseffekte aufgehoben (Gift, Festgewurzelt). Hast du beispielsweise 5 max leben und bist zum Todeszeitpunkt vergiftet wirst du mit 1 HP und ohne Vergiftung wiederbelebt. Hast du 6 max Leben wirst du mit 2 HP wiederbelebt. Usw.");

  final String name;
  final String description;

  const Weapons(this.name, this.description);
}

extension WeaponsExtension on Weapons {
  static Weapons fromString(String weapon) {
    switch (weapon) {
      case 'Blutdürster':
        return Weapons.Blutduerster;
      case 'Felsenschwert':
        return Weapons.Felsenschwert;
      case 'Basiliskenklaue':
        return Weapons.Basiliskenklaue;
      case 'Nachtdolch':
        return Weapons.Nachtdolch;
      case 'Eisenfaust':
        return Weapons.Eisenfaust;
      case 'Nebelstab':
        return Weapons.Nebelstab;
      case 'Windfächer':
        return Weapons.Windfaecher;
      case 'Gaias Ketten':
        return Weapons.GaiasKetten;
      case 'Phönixzepter':
        return Weapons.Phoenixzepter;
      default:
        throw ArgumentError('Invalid weapon name');
    }
  }
}

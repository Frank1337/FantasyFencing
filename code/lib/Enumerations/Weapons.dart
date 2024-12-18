enum Weapons {
  Blutduerster,
  Felsenschwert,
  Basiliskenklaue,
  Nachtdolch,
  Eisenfaust,
  Nebelstab,
  Windfaecher,
  GaiasKetten,
  Phoenixzepter,
}

extension WeaponsExtension on Weapons {
  String get name {
    switch (this) {
      case Weapons.Blutduerster:
        return 'Blutdürster';
      case Weapons.Felsenschwert:
        return 'Felsenschwert';
      case Weapons.Basiliskenklaue:
        return 'Basiliskenklaue';
      case Weapons.Nachtdolch:
        return 'Nachtdolch';
      case Weapons.Eisenfaust:
        return 'Eisenfaust';
      case Weapons.Nebelstab:
        return 'Nebelstab';
      case Weapons.Windfaecher:
        return 'Windfächer';
      case Weapons.GaiasKetten:
        return 'Gaias Ketten';
      case Weapons.Phoenixzepter:
        return 'Phönixzepter';
      default:
        return '';
    }
  }

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

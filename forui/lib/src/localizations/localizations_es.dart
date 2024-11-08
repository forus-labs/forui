import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class FLocalizationsEs extends FLocalizations {
  FLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String fullDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String year(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.y(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String yearMonth(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMM(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String abbreviatedMonth(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMM(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String day(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.d(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }
}

/// The translations for Spanish Castilian, as used in Latin America and the Caribbean (`es_419`).
class FLocalizationsEs419 extends FLocalizationsEs {
  FLocalizationsEs419(): super('es_419');


}

/// The translations for Spanish Castilian, as used in Argentina (`es_AR`).
class FLocalizationsEsAr extends FLocalizationsEs {
  FLocalizationsEsAr(): super('es_AR');


}

/// The translations for Spanish Castilian, as used in Bolivia (`es_BO`).
class FLocalizationsEsBo extends FLocalizationsEs {
  FLocalizationsEsBo(): super('es_BO');


}

/// The translations for Spanish Castilian, as used in Chile (`es_CL`).
class FLocalizationsEsCl extends FLocalizationsEs {
  FLocalizationsEsCl(): super('es_CL');


}

/// The translations for Spanish Castilian, as used in Colombia (`es_CO`).
class FLocalizationsEsCo extends FLocalizationsEs {
  FLocalizationsEsCo(): super('es_CO');


}

/// The translations for Spanish Castilian, as used in Costa Rica (`es_CR`).
class FLocalizationsEsCr extends FLocalizationsEs {
  FLocalizationsEsCr(): super('es_CR');


}

/// The translations for Spanish Castilian, as used in the Dominican Republic (`es_DO`).
class FLocalizationsEsDo extends FLocalizationsEs {
  FLocalizationsEsDo(): super('es_DO');


}

/// The translations for Spanish Castilian, as used in Ecuador (`es_EC`).
class FLocalizationsEsEc extends FLocalizationsEs {
  FLocalizationsEsEc(): super('es_EC');


}

/// The translations for Spanish Castilian, as used in Guatemala (`es_GT`).
class FLocalizationsEsGt extends FLocalizationsEs {
  FLocalizationsEsGt(): super('es_GT');


}

/// The translations for Spanish Castilian, as used in Honduras (`es_HN`).
class FLocalizationsEsHn extends FLocalizationsEs {
  FLocalizationsEsHn(): super('es_HN');


}

/// The translations for Spanish Castilian, as used in Mexico (`es_MX`).
class FLocalizationsEsMx extends FLocalizationsEs {
  FLocalizationsEsMx(): super('es_MX');


}

/// The translations for Spanish Castilian, as used in Nicaragua (`es_NI`).
class FLocalizationsEsNi extends FLocalizationsEs {
  FLocalizationsEsNi(): super('es_NI');


}

/// The translations for Spanish Castilian, as used in Panama (`es_PA`).
class FLocalizationsEsPa extends FLocalizationsEs {
  FLocalizationsEsPa(): super('es_PA');


}

/// The translations for Spanish Castilian, as used in Peru (`es_PE`).
class FLocalizationsEsPe extends FLocalizationsEs {
  FLocalizationsEsPe(): super('es_PE');


}

/// The translations for Spanish Castilian, as used in Puerto Rico (`es_PR`).
class FLocalizationsEsPr extends FLocalizationsEs {
  FLocalizationsEsPr(): super('es_PR');


}

/// The translations for Spanish Castilian, as used in Paraguay (`es_PY`).
class FLocalizationsEsPy extends FLocalizationsEs {
  FLocalizationsEsPy(): super('es_PY');


}

/// The translations for Spanish Castilian, as used in El Salvador (`es_SV`).
class FLocalizationsEsSv extends FLocalizationsEs {
  FLocalizationsEsSv(): super('es_SV');


}

/// The translations for Spanish Castilian, as used in the United States (`es_US`).
class FLocalizationsEsUs extends FLocalizationsEs {
  FLocalizationsEsUs(): super('es_US');


}

/// The translations for Spanish Castilian, as used in Uruguay (`es_UY`).
class FLocalizationsEsUy extends FLocalizationsEs {
  FLocalizationsEsUy(): super('es_UY');


}

/// The translations for Spanish Castilian, as used in Venezuela (`es_VE`).
class FLocalizationsEsVe extends FLocalizationsEs {
  FLocalizationsEsVe(): super('es_VE');


}

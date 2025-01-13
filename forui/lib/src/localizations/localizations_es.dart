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

  @override
  String shortDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Cuadro de diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Sombreado';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Latin America and the Caribbean (`es_419`).
class FLocalizationsEs419 extends FLocalizationsEs {
  FLocalizationsEs419() : super('es_419');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Argentina (`es_AR`).
class FLocalizationsEsAr extends FLocalizationsEs {
  FLocalizationsEsAr() : super('es_AR');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Bolivia (`es_BO`).
class FLocalizationsEsBo extends FLocalizationsEs {
  FLocalizationsEsBo() : super('es_BO');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Chile (`es_CL`).
class FLocalizationsEsCl extends FLocalizationsEs {
  FLocalizationsEsCl() : super('es_CL');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Colombia (`es_CO`).
class FLocalizationsEsCo extends FLocalizationsEs {
  FLocalizationsEsCo() : super('es_CO');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Costa Rica (`es_CR`).
class FLocalizationsEsCr extends FLocalizationsEs {
  FLocalizationsEsCr() : super('es_CR');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in the Dominican Republic (`es_DO`).
class FLocalizationsEsDo extends FLocalizationsEs {
  FLocalizationsEsDo() : super('es_DO');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Ecuador (`es_EC`).
class FLocalizationsEsEc extends FLocalizationsEs {
  FLocalizationsEsEc() : super('es_EC');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Guatemala (`es_GT`).
class FLocalizationsEsGt extends FLocalizationsEs {
  FLocalizationsEsGt() : super('es_GT');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Honduras (`es_HN`).
class FLocalizationsEsHn extends FLocalizationsEs {
  FLocalizationsEsHn() : super('es_HN');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Mexico (`es_MX`).
class FLocalizationsEsMx extends FLocalizationsEs {
  FLocalizationsEsMx() : super('es_MX');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Nicaragua (`es_NI`).
class FLocalizationsEsNi extends FLocalizationsEs {
  FLocalizationsEsNi() : super('es_NI');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Panama (`es_PA`).
class FLocalizationsEsPa extends FLocalizationsEs {
  FLocalizationsEsPa() : super('es_PA');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Peru (`es_PE`).
class FLocalizationsEsPe extends FLocalizationsEs {
  FLocalizationsEsPe() : super('es_PE');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Puerto Rico (`es_PR`).
class FLocalizationsEsPr extends FLocalizationsEs {
  FLocalizationsEsPr() : super('es_PR');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Paraguay (`es_PY`).
class FLocalizationsEsPy extends FLocalizationsEs {
  FLocalizationsEsPy() : super('es_PY');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'inferior';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in El Salvador (`es_SV`).
class FLocalizationsEsSv extends FLocalizationsEs {
  FLocalizationsEsSv() : super('es_SV');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in the United States (`es_US`).
class FLocalizationsEsUs extends FLocalizationsEs {
  FLocalizationsEsUs() : super('es_US');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Uruguay (`es_UY`).
class FLocalizationsEsUy extends FLocalizationsEs {
  FLocalizationsEsUy() : super('es_UY');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

/// The translations for Spanish Castilian, as used in Venezuela (`es_VE`).
class FLocalizationsEsVe extends FLocalizationsEs {
  FLocalizationsEsVe() : super('es_VE');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Seleccionar fecha';

  @override
  String get datePickerInvalidDateError => 'Fecha no válida.';

  @override
  String get dialogLabel => 'Diálogo';

  @override
  String get sheetLabel => 'Hoja';

  @override
  String get barrierLabel => 'Lámina';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cerrar \$modalRouteContentName';
  }
}

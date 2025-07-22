import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

@internal
bool debugCheckHasAncestor<T extends InheritedWidget>(String ancestor, BuildContext context, {bool generic = false}) {
  assert(() {
    if (context.dependOnInheritedWidgetOfExactType<T>() == null) {
      throw FlutterError.fromParts([
        ErrorSummary('No $ancestor ancestor found.'),
        ErrorDescription('The ${context.widget.runtimeType} widget requires an $ancestor widget ancestor.'),
        context.describeWidget('The specific widget that could not find a $ancestor ancestor was'),
        context.describeOwnershipChain('The ownership chain for the affected widget is'),
        if (generic)
          ErrorHint(
            "This is likely because $ancestor's type parameter could not be inferred. To fix this, wrap "
            '${context.widget.runtimeType} in a $ancestor widget and explicitly specify the type parameter.',
          )
        else
          ErrorHint('To fix this, wrap ${context.widget.runtimeType} in a $ancestor widget.'),
      ]);
    }
    return true;
  }());

  return true;
}

@internal
bool debugCheckInclusiveRange<T>(int min, int? max) {
  assert(() {
    if (min < 0 && (max != null && max < 0)) {
      throw FlutterError.fromParts([
        ErrorSummary("$T's min < 0 and max < 0."),
        IntProperty('The offending min value is', min, style: DiagnosticsTreeStyle.errorProperty),
        IntProperty('The offending max value is', max, style: DiagnosticsTreeStyle.errorProperty),
        ErrorHint('To fix this, ensure that both min and max are non-negative.'),
      ]);
    }

    if (min < 0) {
      throw FlutterError.fromParts([
        ErrorSummary("$T's min < 0."),
        IntProperty('The offending min value is', min, style: DiagnosticsTreeStyle.errorProperty),
        ErrorHint('To fix this, ensure that min is non-negative.'),
      ]);
    }

    if (max != null && max < 0) {
      throw FlutterError.fromParts([
        ErrorSummary("$T's max < 0."),
        IntProperty('The offending max value is', max, style: DiagnosticsTreeStyle.errorProperty),
        ErrorHint('To fix this, ensure that max is non-negative.'),
      ]);
    }

    if (max != null && max < min) {
      throw FlutterError.fromParts([
        ErrorSummary("$T's max < min."),
        IntProperty('The offending min value is', min, style: DiagnosticsTreeStyle.errorProperty),
        IntProperty('The offending max value is', max, style: DiagnosticsTreeStyle.errorProperty),
        ErrorHint('To fix this, ensure that min <= max.'),
      ]);
    }

    return true;
  }());

  return true;
}

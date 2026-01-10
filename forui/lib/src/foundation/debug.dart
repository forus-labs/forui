import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

/// A widget that validates that its child's constraints are finite.
///
/// This should always be guarded by a [kDebugMode] check at the call-site to prevent unnecessary performance overhead.
@internal
class FiniteConstraintsValidator extends SingleChildRenderObjectWidget {
  final String type;

  const FiniteConstraintsValidator({required this.type, required super.child, super.key});

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderFiniteConstraintsValidator(type: type);

  @override
  // ignore: library_private_types_in_public_api
  void updateRenderObject(BuildContext context, _RenderFiniteConstraintsValidator renderObject) =>
      renderObject.type = type;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', type));
  }
}

class _RenderFiniteConstraintsValidator extends RenderProxyBox {
  String _type;

  _RenderFiniteConstraintsValidator({required String type}) : _type = type;

  @override
  void performLayout() {
    final flex = parent is RenderFlex;
    if (!constraints.hasBoundedWidth && !constraints.hasBoundedHeight) {
      throw FlutterError.fromParts([
        ErrorSummary('$type was given unbounded width and height.'),
        ErrorDescription(
          '$type tries to be as big as possible, but it was placed inside a widget that allows its children to pick '
          'their own size.',
        ),
        DiagnosticsProperty('The constraints were', constraints, style: .errorProperty),
        ErrorHint('To fix this, wrap $type in a SizedBox with a finite width and height.'),
      ]);
    } else if (!constraints.hasBoundedWidth) {
      throw FlutterError.fromParts([
        ErrorSummary('$type was given unbounded width.'),
        if (flex)
          ErrorDescription(
            '$type tries to be as big as possible, but it was placed inside a Flex widget, e.g., Row, that allows '
            'its children to pick their own width.',
          )
        else
          ErrorDescription(
            '$type tries to be as big as possible, but it was placed inside a widget that allows its children to pick '
            'their own width.',
          ),
        DiagnosticsProperty('The constraints were', constraints, style: .errorProperty),
        if (flex)
          ErrorHint('To fix this, wrap $type in an Expanded, Flexible, or SizedBox with a finite width.')
        else
          ErrorHint('To fix this, wrap $type in a SizedBox with a finite width.'),
      ]);
    } else if (!constraints.hasBoundedHeight) {
      throw FlutterError.fromParts([
        ErrorSummary('$type was given unbounded height.'),
        if (flex)
          ErrorDescription(
            '$type tries to be as big as possible, but it was placed inside a Flex widget, e.g., Column, that allows '
            'its children to pick their own height.',
          )
        else
          ErrorDescription(
            '$type tries to be as big as possible, but it was placed inside a widget that allows its children to pick '
            'their own height.',
          ),
        DiagnosticsProperty('The constraints were', constraints, style: .errorProperty),
        if (flex)
          ErrorHint('To fix this, wrap $type in an Expanded, Flexible, or SizedBox with a finite height.')
        else
          ErrorHint('To fix this, wrap $type in a SizedBox with a finite height.'),
      ]);
    }

    super.performLayout();
  }

  String get type => _type;

  set type(String value) {
    if (_type != value) {
      _type = value;
      markNeedsLayout();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', type));
  }
}

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
        IntProperty('The offending min value is', min, style: .errorProperty),
        IntProperty('The offending max value is', max, style: .errorProperty),
        ErrorHint('To fix this, ensure that both min and max are non-negative.'),
      ]);
    }

    if (min < 0) {
      throw FlutterError.fromParts([
        ErrorSummary("$T's min < 0."),
        IntProperty('The offending min value is', min, style: .errorProperty),
        ErrorHint('To fix this, ensure that min is non-negative.'),
      ]);
    }

    if (max != null && max < 0) {
      throw FlutterError.fromParts([
        ErrorSummary("$T's max < 0."),
        IntProperty('The offending max value is', max, style: .errorProperty),
        ErrorHint('To fix this, ensure that max is non-negative.'),
      ]);
    }

    if (max != null && max < min) {
      throw FlutterError.fromParts([
        ErrorSummary("$T's max < min."),
        IntProperty('The offending min value is', min, style: .errorProperty),
        IntProperty('The offending max value is', max, style: .errorProperty),
        ErrorHint('To fix this, ensure that min <= max.'),
      ]);
    }

    return true;
  }());

  return true;
}

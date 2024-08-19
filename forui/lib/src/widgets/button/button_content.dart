import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

@internal
class Content extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final Widget label;

  const Content({
    required this.label,
    this.prefix,
    this.suffix,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FButtonData(style: FButtonCustomStyle(:content), :enabled) = FButton.of(context);

    return Padding(
      padding: content.padding,
      child: DefaultTextStyle.merge(
        style: enabled ? content.enabledTextStyle : content.disabledTextStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: separate(
            [
              if (prefix != null) prefix!,
              label,
              if (suffix != null) suffix!,
            ],
            by: [
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}

@internal
class IconContent extends StatelessWidget {
  final Widget child;

  const IconContent({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final FButtonData(:style, enabled: _) = FButton.of(context);

    return Padding(
      padding: style.iconContent.padding,
      child: child,
    );
  }
}

/// [FButton] content's style.
final class FButtonContentStyle with Diagnosticable {
  /// The [TextStyle] when this button is enabled.
  final TextStyle enabledTextStyle;

  /// The [TextStyle] when this button is disabled.
  final TextStyle disabledTextStyle;

  /// The padding.
  final EdgeInsets padding;

  /// Creates a [FButtonContentStyle].
  FButtonContentStyle({
    required this.enabledTextStyle,
    required this.disabledTextStyle,
    required this.padding,
  });

  /// Creates a [FButtonContentStyle] that inherits its properties from the given [enabled] and [disabled].
  FButtonContentStyle.inherit({
    required FTypography typography,
    required Color enabled,
    required Color disabled,
  })  : padding = const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12.5,
        ),
        enabledTextStyle = typography.base.copyWith(
          color: enabled,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
        disabledTextStyle = typography.base.copyWith(
          color: disabled,
          fontWeight: FontWeight.w500,
          height: 1,
        );

  /// Returns a copy of this [FButtonContentStyle] with the given properties replaced.
  @useResult
  FButtonContentStyle copyWith({
    TextStyle? enabledTextStyle,
    TextStyle? disabledTextStyle,
    EdgeInsets? padding,
  }) =>
      FButtonContentStyle(
        enabledTextStyle: enabledTextStyle ?? this.enabledTextStyle,
        disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledTextStyle', enabledTextStyle))
      ..add(DiagnosticsProperty('disabledTextStyle', disabledTextStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonContentStyle &&
          runtimeType == other.runtimeType &&
          enabledTextStyle == other.enabledTextStyle &&
          disabledTextStyle == other.disabledTextStyle &&
          padding == other.padding;

  @override
  int get hashCode => enabledTextStyle.hashCode ^ disabledTextStyle.hashCode ^ padding.hashCode;
}

/// [FButton] icon content's style.
final class FButtonIconContentStyle with Diagnosticable {
  /// The padding.
  final EdgeInsets padding;

  /// Creates a [FButtonIconContentStyle].
  const FButtonIconContentStyle({this.padding = const EdgeInsets.all(7.5)});

  /// Returns a copy of this [FButtonIconContentStyle] with the given properties replaced.
  @useResult
  FButtonIconContentStyle copyWith({EdgeInsets? padding}) => FButtonIconContentStyle(padding: padding ?? this.padding);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FButtonIconContentStyle && runtimeType == other.runtimeType && padding == other.padding;

  @override
  int get hashCode => padding.hashCode;
}

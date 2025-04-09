import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'button_content.style.dart';

@internal
class Content extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final Widget child;

  const Content({required this.child, this.prefix, this.suffix, super.key});

  @override
  Widget build(BuildContext context) {
    final FButtonData(style: FButtonStyle(:contentStyle), :enabled) = FButtonData.of(context);
    return Padding(
      padding: contentStyle.padding,
      child: DefaultTextStyle.merge(
        style: enabled ? contentStyle.enabledTextStyle : contentStyle.disabledTextStyle,
        child: IconTheme(
          data: enabled ? contentStyle.enabledIconStyle : contentStyle.disabledIconStyle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [if (prefix case final prefix?) prefix, child, if (suffix case final suffix?) suffix],
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
    final FButtonData(:style, :enabled) = FButtonData.of(context);

    return Padding(
      padding: style.iconContentStyle.padding,
      child: IconTheme(
        data: enabled ? style.iconContentStyle.enabledStyle : style.iconContentStyle.disabledStyle,
        child: child,
      ),
    );
  }
}

/// [FButton] content's style.
final class FButtonContentStyle with Diagnosticable, _$FButtonContentStyleFunctions {
  /// The [TextStyle] when this button is enabled.
  @override
  final TextStyle enabledTextStyle;

  /// The [TextStyle] when this button is disabled.
  @override
  final TextStyle disabledTextStyle;

  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 16, vertical: 12.5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The icon's style when this button is enabled.
  @override
  final IconThemeData enabledIconStyle;

  /// The icon's style when this button is disabled.
  @override
  final IconThemeData disabledIconStyle;

  /// Creates a [FButtonContentStyle].
  FButtonContentStyle({
    required this.enabledTextStyle,
    required this.disabledTextStyle,
    required this.enabledIconStyle,
    required this.disabledIconStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12.5),
  });

  /// Creates a [FButtonContentStyle] that inherits its properties from the given [enabled] and [disabled].
  FButtonContentStyle.inherit({required FTypography typography, required Color enabled, required Color disabled})
    : this(
        enabledTextStyle: typography.base.copyWith(color: enabled, fontWeight: FontWeight.w500, height: 1),
        disabledTextStyle: typography.base.copyWith(color: disabled, fontWeight: FontWeight.w500, height: 1),
        enabledIconStyle: IconThemeData(color: enabled, size: 20),
        disabledIconStyle: IconThemeData(color: disabled, size: 20),
      );
}

/// [FButton] icon content's style.
final class FButtonIconContentStyle with Diagnosticable, _$FButtonIconContentStyleFunctions {
  /// The padding. Defaults to `EdgeInsets.all(7.5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The icon's style when this button is enabled.
  @override
  final IconThemeData enabledStyle;

  /// The icon's style when this button is disabled.
  @override
  final IconThemeData disabledStyle;

  /// Creates a [FButtonIconContentStyle].
  const FButtonIconContentStyle({
    required this.enabledStyle,
    required this.disabledStyle,
    this.padding = const EdgeInsets.all(7.5),
  });
}

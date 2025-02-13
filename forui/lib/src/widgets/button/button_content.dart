import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

part 'button_content.style.dart';

@internal
class Content extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final Widget label;

  const Content({required this.label, this.prefix, this.suffix, super.key});

  @override
  Widget build(BuildContext context) {
    final FButtonData(style: FButtonCustomStyle(:contentStyle), :enabled) = FButtonData.of(context);
    return Padding(
      padding: contentStyle.padding,
      child: DefaultTextStyle.merge(
        style: enabled ? contentStyle.enabledTextStyle : contentStyle.disabledTextStyle,
        child: FIconStyleData(
          style: FIconStyle(
            color: enabled ? contentStyle.enabledIconColor : contentStyle.disabledIconColor,
            size: contentStyle.iconSize,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: separate(
              [if (prefix != null) prefix!, label, if (suffix != null) suffix!],
              by: [const SizedBox(width: 10)],
            ),
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
      child: FIconStyleData(
        style: FIconStyle(
          color: enabled ? style.iconContentStyle.enabledColor : style.iconContentStyle.disabledColor,
          size: style.iconContentStyle.size,
        ),
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
  final EdgeInsets padding;

  /// The icon's color when this button is enabled.
  @override
  final Color enabledIconColor;

  /// The icon's color when this button is disabled.
  @override
  final Color disabledIconColor;

  /// The icon's size. Defaults to 20.
  @override
  final double iconSize;

  /// Creates a [FButtonContentStyle].
  FButtonContentStyle({
    required this.enabledTextStyle,
    required this.disabledTextStyle,
    required this.enabledIconColor,
    required this.disabledIconColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12.5),
    this.iconSize = 20,
  });

  /// Creates a [FButtonContentStyle] that inherits its properties from the given [enabled] and [disabled].
  FButtonContentStyle.inherit({required FTypography typography, required Color enabled, required Color disabled})
    : this(
        enabledTextStyle: typography.base.copyWith(color: enabled, fontWeight: FontWeight.w500, height: 1),
        disabledTextStyle: typography.base.copyWith(color: disabled, fontWeight: FontWeight.w500, height: 1),
        enabledIconColor: enabled,
        disabledIconColor: disabled,
      );
}

/// [FButton] icon content's style.
final class FButtonIconContentStyle with Diagnosticable, _$FButtonIconContentStyleFunctions {
  /// The padding. Defaults to `EdgeInsets.all(7.5)`.
  @override
  final EdgeInsets padding;

  /// The icon's color when this button is enabled.
  @override
  final Color enabledColor;

  /// The icon's color when this button is disabled.
  @override
  final Color disabledColor;

  /// The icon's size. Defaults to 20.
  @override
  final double size;

  /// Creates a [FButtonIconContentStyle].
  const FButtonIconContentStyle({
    required this.enabledColor,
    required this.disabledColor,
    this.padding = const EdgeInsets.all(7.5),
    this.size = 20,
  });
}

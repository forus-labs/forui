import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'button_content.style.dart';

@internal
class Content extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final Widget label;

  const Content({required this.label, this.prefix, this.suffix, super.key});

  @override
  Widget build(BuildContext context) {
    final FButtonData(style: FButtonStyle(:contentStyle), :states) = FButtonData.of(context);
    return Padding(
      padding: contentStyle.padding,
      child: DefaultTextStyle.merge(
        style: contentStyle.textStyle.resolve(states),
        child: FIconStyleData(
          style: FIconStyle(color: contentStyle.iconColor.resolve(states), size: contentStyle.iconSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [if (prefix case final prefix?) prefix, label, if (suffix case final suffix?) suffix],
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
    final FButtonData(:style, :states) = FButtonData.of(context);

    return Padding(
      padding: style.iconContentStyle.padding,
      child: FIconStyleData(
        style: FIconStyle(color: style.iconContentStyle.color.resolve(states), size: style.iconContentStyle.size),
        child: child,
      ),
    );
  }
}

/// [FButton] content's style.
final class FButtonContentStyle with Diagnosticable, _$FButtonContentStyleFunctions {
  /// The [TextStyle].
  ///
  /// {macro forui.foundation.FTappable.builder}
  @override
  final FWidgetStateMap<TextStyle> textStyle;

  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 16, vertical: 12.5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The icon's color.
  ///
  /// {macro forui.foundation.FTappable.builder}
  @override
  final FWidgetStateMap<Color> iconColor;

  /// The icon's size. Defaults to 20.
  @override
  final double iconSize;

  /// Creates a [FButtonContentStyle].
  FButtonContentStyle({
    required this.textStyle,
    required this.iconColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12.5),
    this.iconSize = 20,
  });

  /// Creates a [FButtonContentStyle] that inherits its properties from the given [typography] and [color].
  FButtonContentStyle.inherit({required FTypography typography, required FWidgetStateMap<Color> color})
    : this(
        textStyle: FWidgetStateMap(
          color.map(
            (state, color) =>
                MapEntry(state, typography.base.copyWith(color: color, fontWeight: FontWeight.w500, height: 1)),
          ),
        ),
        iconColor: color,
      );
}

/// [FButton] icon content's style.
final class FButtonIconContentStyle with Diagnosticable, _$FButtonIconContentStyleFunctions {
  /// The padding. Defaults to `EdgeInsets.all(7.5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The icon's color.
  ///
  /// {macro forui.foundation.FTappable.builder}
  @override
  final FWidgetStateMap<Color> color;

  /// The icon's size. Defaults to 20.
  @override
  final double size;

  /// Creates a [FButtonIconContentStyle].
  const FButtonIconContentStyle({required this.color, this.padding = const EdgeInsets.all(7.5), this.size = 20});
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

final class FSeparator extends StatelessWidget {

  final FSeparatorStyle? style;
  final bool vertical;

  FSeparator({this.style, this.vertical = false});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? (vertical ? context.theme.verticalSeparatorStyle : context.theme.separatorStyle);
    return Padding(
      padding: style.padding,
      child: vertical ?
        SizedBox(
          width: style.thickness,
          child: ColoredBox(
            color: style.color,
          ),
        ) :
        SizedBox(
          height: style.thickness,
          child: ColoredBox(
            color: style.color,
          ),
        ),
    );
  }

}

final class FSeparatorStyle with Diagnosticable {

  final Color color;
  final EdgeInsetsGeometry padding;
  /// The thickness of
  final double thickness;

  FSeparatorStyle({required this.color, required this.padding, this.thickness = 1});

  FSeparatorStyle.inherit({required FColorScheme colorScheme}):
    color = colorScheme.secondary,
    padding = const EdgeInsets.only(top: 20, bottom: 20),
    thickness = 1;

  FSeparatorStyle.inheritVertical({required FColorScheme colorScheme}):
    color = colorScheme.secondary,
    padding = const EdgeInsets.only(left: 20, right: 20),
    thickness = 1;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSeparatorStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          padding == other.padding &&
          thickness == other.thickness;

  @override
  int get hashCode => color.hashCode ^ padding.hashCode ^ thickness.hashCode;
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/tile/tile_content.dart';


class FTile extends StatelessWidget {


  /// Creates a [FTile].
  ///
  /// ```
  /// -----------------------------------------------------
  /// | [prefixIcon] [title]       [details] [suffixIcon] |
  /// |              [subtitle]                           |
  /// ----------------------------------------------------
  /// ```
  FTile({
    required Widget title,
    this.style,
    Widget? prefixIcon,
    Widget? subtitle,
    Widget? details,
    Widget? suffixIcon,
    String? semanticLabel,
    bool enabled = true,
    VoidCallback? onPress,
    VoidCallback? onLongPress,
    super.key,
  }) : child = FTileContent(
          title: title,
          prefixIcon: prefixIcon,
          subtitle: subtitle,
          details: details,
          suffixIcon: suffixIcon,
          semanticLabel: semanticLabel,
          enabled: enabled,
          onPress: onPress,
          onLongPress: onLongPress,
        );
}





import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:forui/src/foundation/util.dart';

@internal
class FTileContent extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget title;
  final Widget? subtitle;
  final Widget? details;
  final Widget? suffixIcon;
  final String? semanticLabel;
  final bool enabled;
  final VoidCallback? onPress;
  final VoidCallback? onLongPress;

  const FTileContent({
    required this.title,
    required this.prefixIcon,
    required this.subtitle,
    required this.details,
    required this.suffixIcon,
    required this.semanticLabel,
    required this.enabled,
    required this.onPress,
    required this.onLongPress,
    super.key,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress));
  }
}

class _Content extends StatelessWidget {
  final FTileContentStateStyle style;
  final Color background;
  final Widget? prefixIcon;
  final Widget title;
  final Widget? subtitle;
  final Widget? details;
  final Widget? suffixIcon;

  const _Content({
    required this.style,
    required this.background,
    required this.prefixIcon,
    required this.title,
    required this.subtitle,
    required this.details,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final FTileData(style: tileStyle, :index, :length, :divider) = FTileData.maybeOf(context)!;
    final FTileStyle(:contentStyle, :dividerStyle) = tileStyle;

    Widget tile = Padding(
      padding: contentStyle.padding,
      child: Row(
        children: [
          if (prefixIcon case final prefixIcon?)
            Padding(
              padding: EdgeInsets.only(right: contentStyle.prefixIconSpacing),
              child: FIconStyleData(
                style: style.prefixIconStyle,
                child: prefixIcon,
              ),
            ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      merge(
                        style: style.titleTextStyle,
                        textHeightBehavior: const TextHeightBehavior(
                          applyHeightToFirstAscent: false,
                          applyHeightToLastDescent: false,
                        ),
                        overflow: TextOverflow.ellipsis,
                        child: title,
                      ),
                      if (subtitle case final subtitle?)
                        Padding(
                          padding: EdgeInsets.only(top: contentStyle.titleSpacing),
                          child: merge(
                            style: style.subtitleTextStyle,
                            textHeightBehavior: const TextHeightBehavior(
                              applyHeightToFirstAscent: false,
                              applyHeightToLastDescent: false,
                            ),
                            overflow: TextOverflow.ellipsis,
                            child: subtitle,
                          ),
                        ),
                    ],
                  ),
                ),
                if (details case final details?)
                  Flexible(
                    child: merge(
                      style: style.detailsTextStyle,
                      textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                      ),
                      overflow: TextOverflow.ellipsis,
                      child: details,
                    ),
                  ),
              ],
            ),
          ),
          if (suffixIcon case final suffixIcon?)
            Padding(
              padding: EdgeInsets.only(left: contentStyle.suffixIconSpacing),
              child: FIconStyleData(
                style: style.suffixIconStyle,
                child: suffixIcon,
              ),
            ),
        ],
      ),
    );

    // if (divider == FTileDivider.full && index < length - 1) {
    //   tile = Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [tile, FDivider(style: dividerStyle)],
    //   );
    // }

    return tile;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ColorProperty('background', background));
  }
}

class _TitleAlignedContent extends StatelessWidget {
  final FTileContentStateStyle style;
  final Color background;
  final Widget? prefixIcon;
  final Widget title;
  final Widget? subtitle;
  final Widget? details;
  final Widget? suffixIcon;

  const _TitleAlignedContent({
    required this.style,
    required this.background,
    required this.prefixIcon,
    required this.title,
    required this.subtitle,
    required this.details,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final FTileData(style: tileStyle, :index, :length, :divider) = FTileData.maybeOf(context)!;
    final FTileStyle(:contentStyle, :dividerStyle) = tileStyle;
    assert(divider == FTileDivider.partial, 'FTileDivider.title is required in _TitleAlignedContent.');

    return Row(
      children: [
        if (prefixIcon case final prefixIcon?)
          Padding(
            padding: contentStyle.padding.copyWith(right: contentStyle.prefixIconSpacing),
            child: FIconStyleData(
              style: style.prefixIconStyle,
              child: prefixIcon,
            ),
          )
        else
          SizedBox(width: contentStyle.padding.left),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: contentStyle.padding.copyWith(left: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          merge(
                            style: style.titleTextStyle,
                            textHeightBehavior: const TextHeightBehavior(
                              applyHeightToFirstAscent: false,
                              applyHeightToLastDescent: false,
                            ),
                            overflow: TextOverflow.ellipsis,
                            child: title,
                          ),
                          if (subtitle case final subtitle?)
                            Padding(
                              padding: EdgeInsets.only(top: contentStyle.titleSpacing),
                              child: merge(
                                style: style.subtitleTextStyle,
                                textHeightBehavior: const TextHeightBehavior(
                                  applyHeightToFirstAscent: false,
                                  applyHeightToLastDescent: false,
                                ),
                                overflow: TextOverflow.ellipsis,
                                child: subtitle,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (details case final details?)
                            Flexible(
                              child: merge(
                                style: style.detailsTextStyle,
                                textHeightBehavior: const TextHeightBehavior(
                                  applyHeightToFirstAscent: false,
                                  applyHeightToLastDescent: false,
                                ),
                                overflow: TextOverflow.ellipsis,
                                child: details,
                              ),
                            ),
                          if (suffixIcon case final suffixIcon?)
                            Padding(
                              padding: EdgeInsets.only(left: contentStyle.suffixIconSpacing),
                              child: FIconStyleData(
                                style: style.suffixIconStyle,
                                child: suffixIcon,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // if (index < length - 1) FDivider(style: dividerStyle),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('decoration', background));
  }
}

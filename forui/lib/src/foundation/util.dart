import 'package:flutter/widgets.dart';

// TODO: Remove this function once DefaultTextStyle.merge(...) exposes TextHeightBehavior? textHeightBehavior.

/// Creates a default text style that overrides the text styles in scope at
/// this point in the widget tree.
///
/// The given [style] is merged with the [style] from the default text style
/// for the [BuildContext] where the widget is inserted, and any of the other
/// arguments that are not null replace the corresponding properties on that
/// same default text style.
///
/// This constructor cannot be used to override the [maxLines] property of the
/// ancestor with the value null, since null here is used to mean "defer to
/// ancestor". To replace a non-null [maxLines] from an ancestor with the null
/// value (to remove the restriction on number of lines), manually obtain the
/// ambient [DefaultTextStyle] using [DefaultTextStyle.of], then create a new
/// [DefaultTextStyle] using the [DefaultTextStyle.new] constructor directly.
/// See the source below for an example of how to do this (since that's
/// essentially what this constructor does).
Widget merge({
  required Widget child,
  Key? key,
  TextStyle? style,
  TextAlign? textAlign,
  bool? softWrap,
  TextOverflow? overflow,
  int? maxLines,
  TextWidthBasis? textWidthBasis,
  TextHeightBehavior? textHeightBehavior,
}) =>
    Builder(
      builder: (context) {
        final DefaultTextStyle parent = DefaultTextStyle.of(context);
        return DefaultTextStyle(
          key: key,
          style: parent.style.merge(style),
          textAlign: textAlign ?? parent.textAlign,
          softWrap: softWrap ?? parent.softWrap,
          overflow: overflow ?? parent.overflow,
          maxLines: maxLines ?? parent.maxLines,
          textWidthBasis: textWidthBasis ?? parent.textWidthBasis,
          textHeightBehavior: textHeightBehavior ?? parent.textHeightBehavior,
          child: child,
        );
      },
    );

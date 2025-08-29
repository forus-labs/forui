import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'rating.style.dart';
part 'rating_content.dart';

/// A customizable rating widget that allows users to select a rating by tapping on icons.
///
/// See:
/// * https://forui.dev/docs/rating for working examples.
/// * [FRatingStyle] for customizing a rating's appearance.
class FRating extends StatefulWidget {
  /// The current rating value.
  final double value;

  /// The maximum rating value.
  final int count;

  /// Called when the rating value changes.
  final ValueChanged<double>? onStateChanged;

  /// Whether this rating widget is enabled. Defaults to true.
  final bool enabled;

  /// The style of the rating widget.
  final FRatingStyle? style;

  /// The icon to display for a filled (rated) state.
  final Widget filledIcon;

  /// The icon to display for an empty (unrated) state.
  final Widget emptyIcon;

  /// The icon to display for a half-filled state (when allowHalfRating is true).
  final Widget? halfFilledIcon;

  /// The semantic label for accessibility.
  final String? semanticsLabel;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// The spacing between rating icons.
  final double spacing;

  /// Creates a [FRating] widget.
  const FRating({
    super.key,
    this.value = 0.0,
    this.count = 5,
    this.onStateChanged,
    this.enabled = true,
    this.style,
    this.filledIcon = const Icon(FIcons.star, color: Color(0xFFFFD700)), // Gold
    this.emptyIcon = const Icon(FIcons.starOff, color: Color(0xFFBDBDBD)), // Gray
    this.halfFilledIcon,
    this.semanticsLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.spacing = 4.0,
  });

  @override
  State<FRating> createState() => _FRatingState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('value', value))
      ..add(IntProperty('count', count))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty<ValueChanged<double>?>.has('onStateChanged', onStateChanged))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(DiagnosticsProperty<bool>('autofocus', autofocus))
      ..add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode))
      ..add(ObjectFlagProperty<ValueChanged<bool>?>.has('onFocusChange', onFocusChange))
      ..add(DoubleProperty('spacing', spacing));
  }
}

class _FRatingState extends State<FRating> {
  double _hoverValue = 0.0;
  bool _isHovering = false;

  double _calculateRating(double dx, double totalWidth) {
    if (totalWidth <= 0) {
      return 0;
    }

    final itemWidth = totalWidth / widget.count;
    final x = dx.clamp(0.0, totalWidth);
    final index = x ~/ itemWidth;
    final localPosition = x - (index * itemWidth);

    double rating = index + 1.0;
    if (widget.halfFilledIcon != null && localPosition < itemWidth / 2) {
      rating -= 0.5;
    }

    return rating.clamp(0.0, widget.count.toDouble());
  }

  void _handleHover(PointerHoverEvent event) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) {
      return;
    }

    final localPosition = box.globalToLocal(event.position);
    setState(() => _hoverValue = _calculateRating(localPosition.dx, box.size.width));
  }

  void _handleTap(TapUpDetails details) {
    final box = context.findRenderObject()! as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    final rating = _calculateRating(localPosition.dx, box.size.width);

    widget.onStateChanged?.call(rating);
    setState(() => _isHovering = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = widget.style ?? const FRatingStyle();
    final effectiveEnabled = widget.enabled && widget.onStateChanged != null;
    final effectiveValue = _isHovering ? _hoverValue : widget.value;

    return MouseRegion(
      onEnter: effectiveEnabled ? (_) => setState(() => _isHovering = true) : null,
      onExit: effectiveEnabled ? (_) => setState(() => _isHovering = false) : null,
      onHover: effectiveEnabled ? _handleHover : null,
      child: GestureDetector(
        onTapUp: effectiveEnabled ? _handleTap : null,
        child: _RatingContent(
          value: effectiveValue,
          count: widget.count,
          spacing: widget.spacing,
          filledIcon: widget.filledIcon,
          emptyIcon: widget.emptyIcon,
          halfFilledIcon: widget.halfFilledIcon,
          style: style,
          theme: theme,
          semanticsLabel: widget.semanticsLabel,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          onFocusChange: widget.onFocusChange,
        ),
      ),
    );
  }
}

/// Internal widget to display the rating content

/// Defines the visual properties for [FRating].
///
/// See also:
/// * [FRating], which uses this class for its visual styling.
final class FRatingStyle with Diagnosticable, _$FRatingStyleFunctions {
  /// The color of the rating icons.
  @override
  final Color? color;

  /// The size of the rating icons.
  @override
  final double? size;

  /// Creates a [FRatingStyle].
  const FRatingStyle({this.color, this.size});
}

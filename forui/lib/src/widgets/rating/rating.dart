import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

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
  final ValueChanged<double>? onChanged;

  /// Whether to allow half ratings.
  final bool allowHalfRating;

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
    this.onChanged,
    this.allowHalfRating = false,
    this.enabled = true,
    this.style,
    Widget? filledIcon,
    Widget? emptyIcon,
    this.halfFilledIcon,
    this.semanticsLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.spacing = 4.0,
  }) : filledIcon = filledIcon ?? const Icon(FIcons.star, color: Color.fromARGB(255, 255, 215, 0)),
       emptyIcon = emptyIcon ?? const Icon(FIcons.starOff, color: Color.fromARGB(255, 189, 189, 189));

  @override
  State<FRating> createState() => _FRatingState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('value', value))
      ..add(IntProperty('count', count))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('allowHalfRating', value: allowHalfRating, ifTrue: 'allowHalfRating'))
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(DoubleProperty('spacing', spacing))
      ..add(ObjectFlagProperty<ValueChanged<double>?>.has('onChanged', onChanged));
  }
}

class _FRatingState extends State<FRating> {
  double _hoverValue = 0.0;
  bool _isHovering = false;

  /// Calculate rating based on pointer position
  double _calculateRating(double dx, double totalWidth) {
    // Early return if invalid input
    if (totalWidth <= 0) {
      return 0.0;
    }
    
    final itemWidth = totalWidth / widget.count;
    final x = dx.clamp(0.0, totalWidth);
    
    final int index = x ~/ itemWidth;
    final double localPosition = x - (index * itemWidth);
    
    double rating = index + 1.0;
    
    if (widget.allowHalfRating && localPosition < itemWidth / 2) {
      rating -= 0.5;
    }
    
    return rating.clamp(0.0, widget.count.toDouble());
  }

  void _handleHover(PointerHoverEvent event) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null) {
      return;
    }
    
    final localPosition = box.globalToLocal(event.position);
    setState(() {
      _hoverValue = _calculateRating(localPosition.dx, box.size.width);
    });
  }

  void _handleTap(TapUpDetails details) {
    final RenderBox box = context.findRenderObject()! as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    final rating = _calculateRating(localPosition.dx, box.size.width);
    
    widget.onChanged?.call(rating);
    setState(() {
      _isHovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = widget.style ?? const FRatingStyle();
    
    final bool effectiveEnabled = widget.enabled && widget.onChanged != null;
    final double effectiveValue = _isHovering ? _hoverValue : widget.value;
    
    return MouseRegion(
      onEnter: effectiveEnabled ? (_) => setState(() => _isHovering = true) : null,
      onExit: effectiveEnabled ? (_) => setState(() => _isHovering = false) : null,
      onHover: effectiveEnabled ? _handleHover : null,
      child: GestureDetector(
        onTapUp: effectiveEnabled ? _handleTap : null,
        child: Semantics(
          label: widget.semanticsLabel ?? 'Rating: ${effectiveValue.toStringAsFixed(1)} of ${widget.count}',
          child: Focus(
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            onFocusChange: widget.onFocusChange,
            child: LayoutBuilder(
              builder: (context, constraints) => _buildRatingRow(
                context, 
                effectiveValue, 
                style, 
                theme,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingRow(
    BuildContext context, 
    double value, 
    FRatingStyle style,
    FThemeData theme,
  ) => Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.count,
        (index) => _buildRatingItem(
          index: index,
          value: value,
          style: style,
          theme: theme,
        ),
      ),
    );

  Widget _buildRatingItem({
    required int index,
    required double value,
    required FRatingStyle style,
    required FThemeData theme,
  }) {
    final double itemValue = index + 1.0;
    
    // Determine which icon to show based on the current rating value
    Widget icon;
    if (itemValue <= value) {
      // Fully filled icon
      icon = widget.filledIcon;
    } else if (widget.allowHalfRating && 
              (itemValue - 0.5) <= value && 
              value < itemValue) {
      // Half-filled icon
      icon = widget.halfFilledIcon ?? widget.filledIcon;
    } else {
      // Empty icon
      icon = widget.emptyIcon;
    }
    
    return Padding(
      padding: EdgeInsets.only(
        right: index < widget.count - 1 ? widget.spacing : 0,
      ),
      child: IconTheme(
        data: IconThemeData(
          color: style.color ?? theme.colors.primary,
          size: style.size ?? 24.0,
        ),
        child: icon,
      ),
    );
  }
}

/// Defines the visual properties for [FRating].
///
/// See also:
/// * [FRating], which uses this class for its visual styling.
class FRatingStyle with Diagnosticable {
  /// The color of the rating icons.
  final Color? color;

  /// The size of the rating icons.
  final double? size;

  /// Creates a [FRatingStyle].
  const FRatingStyle({
    this.color,
    this.size,
  });

  /// Creates a copy of this style with the given fields replaced by new values.
  FRatingStyle copyWith({
    Color? color,
    double? size,
  }) => FRatingStyle(
      color: color ?? this.color,
      size: size ?? this.size,
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('size', size));
  }
}
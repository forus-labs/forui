import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable/divider.dart';

part 'resizable.style.dart';

/// A resizable allows its children to be resized along either the horizontal or vertical main axis.
///
/// Each child is a [FResizableRegion] that has an initial and minimum extent. Setting an initial extent less than the
/// minimum extent will result in undefined behaviour. The children are arranged from top to bottom, or left to right,
/// depending on the main [axis].
///
/// It is recommended that a [FResizable] contains at least 2 [FResizableRegion]s.
///
/// See:
/// * https://forui.dev/docs/layout/resizable for working examples.
/// * [FResizableStyle] for customizing a resizable's appearance.
class FResizable extends StatefulWidget {
  static String _label(FResizableRegionData left, FResizableRegionData right) =>
      '${left.extent.current}, ${right.extent.current}';

  /// The controller that manages the resizing of regions. Defaults to [FResizableController.cascade].
  final FResizableController? controller;

  /// The resizable' style.
  final FResizableStyle? style;

  /// The main axis along which the [children] can be resized.
  final Axis axis;

  /// The divider between resizable regions. Defaults to [FResizableDivider.dividerWithThumb].
  final FResizableDivider divider;

  /// The extent of the [children] along the non-resizable axis, in logical pixels. By default, it occupies as much
  /// space as possible.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [crossAxisExtent] is not positive.
  final double? crossAxisExtent;

  /// The extent of the gesture's hit region along the resizable axis, in logical pixels.
  ///
  /// Hit regions are centered around the dividers between resizable regions.
  ///
  /// Defaults to `60` on Android and iOS, and `10` on other platforms.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [hitRegionExtent] <= 0.
  final double hitRegionExtent;

  /// The percentage of the total extent by which regions are resized when using the keyboard. Defaults to 0.005 (0.5%).
  ///
  /// ## Contract
  /// Throws [AssertionError] if [resizePercentage] is <= 0 or >= 1.
  final double resizePercentage;

  /// A callback that formats the semantic label for the resizable. Defaults to announcing the extents of both regions.
  final String Function(FResizableRegionData, FResizableRegionData) semanticFormatterCallback;

  /// The children that may be resized.
  final List<FResizableRegion> children;

  /// Creates a [FResizable].
  FResizable({
    required this.axis,
    required this.children,
    this.controller,
    this.style,
    this.divider = FResizableDivider.dividerWithThumb,
    this.crossAxisExtent,
    this.resizePercentage = 0.005,
    this.semanticFormatterCallback = _label,
    double? hitRegionExtent,
    super.key,
  }) : assert(
         crossAxisExtent == null || 0 < crossAxisExtent,
         'The crossAxisExtent should be positive, but is $crossAxisExtent.',
       ),
       assert(
         hitRegionExtent == null || 0 < hitRegionExtent,
         'The hitRegionExtent should be positive, but is $hitRegionExtent.',
       ),
       hitRegionExtent = hitRegionExtent ?? (FTouch.primary ? 60 : 10);

  @override
  State<StatefulWidget> createState() => _FResizableState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('axis', axis))
      ..add(EnumProperty('divider', divider))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent))
      ..add(DoubleProperty('hitRegionExtent', hitRegionExtent))
      ..add(PercentProperty('resizePercentage', resizePercentage))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticFormatterCallback))
      ..add(IterableProperty('children', children));
  }
}

class _FResizableState extends State<FResizable> {
  late FResizableController _controller = widget.controller ?? FResizableController.cascade();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _update();
  }

  @override
  void didUpdateWidget(FResizable old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      }

      _controller = widget.controller ?? FResizableController.cascade();
    }

    if (widget.axis != old.axis ||
        widget.crossAxisExtent != old.crossAxisExtent ||
        widget.controller != old.controller ||
        !widget.children.equals(old.children)) {
      _update();
    }
  }

  void _update() {
    var minOffset = 0.0;
    final minTotalExtent = widget.children.sum((c) => max(c.minExtent ?? 0, widget.hitRegionExtent), initial: 0.0);
    final totalExtent = widget.children.sum((c) => c.initialExtent, initial: 0.0);
    final regions = [
      for (final (index, region) in widget.children.indexed)
        FResizableRegionData(
          index: index,
          extent: (
            min: region.minExtent ?? widget.hitRegionExtent,
            max: totalExtent - minTotalExtent + max(region.minExtent ?? 0, widget.hitRegionExtent),
            total: totalExtent,
          ),
          offset: (min: minOffset, max: minOffset += region.initialExtent),
        ),
    ];

    _controller.regions.clear();
    _controller.regions.addAll(regions);
  }

  @override
  Widget build(BuildContext context) {
    assert(
      _controller.regions.length == widget.children.length,
      'The number of FResizableData should be equal to the number of children.',
    );

    final style = widget.style ?? context.theme.resizableStyle;
    if (widget.axis == Axis.horizontal) {
      return SizedBox(
        height: widget.crossAxisExtent,
        child: LayoutBuilder(
          builder:
              (_, constraints) => ListenableBuilder(
                listenable: _controller,
                builder:
                    (_, _) => Stack(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (final (i, child) in widget.children.indexed)
                              InheritedData(
                                controller: _controller,
                                axis: widget.axis,
                                data: _controller.regions[i],
                                child: child,
                              ),
                          ],
                        ),
                        for (var i = 0; i < widget.children.length - 1; i++)
                          HorizontalDivider(
                            controller: _controller,
                            style: style.horizontalDividerStyle,
                            type: widget.divider,
                            left: i,
                            right: i + 1,
                            crossAxisExtent:
                                constraints.maxHeight.isFinite ? constraints.maxHeight : widget.crossAxisExtent,
                            hitRegionExtent: widget.hitRegionExtent,
                            resizePercentage: widget.resizePercentage,
                            cursor: SystemMouseCursors.resizeLeftRight,
                            semanticFormatterCallback: widget.semanticFormatterCallback,
                          ),
                      ],
                    ),
              ),
        ),
      );
    } else {
      return SizedBox(
        width: widget.crossAxisExtent,
        child: LayoutBuilder(
          builder:
              (_, constraints) => ListenableBuilder(
                listenable: _controller,
                builder:
                    (_, _) => Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (final (i, child) in widget.children.indexed)
                              InheritedData(
                                controller: _controller,
                                axis: widget.axis,
                                data: _controller.regions[i],
                                child: child,
                              ),
                          ],
                        ),
                        for (var i = 0; i < widget.children.length - 1; i++)
                          VerticalDivider(
                            controller: _controller,
                            style: style.verticalDividerStyle,
                            type: widget.divider,
                            left: i,
                            right: i + 1,
                            crossAxisExtent:
                                constraints.maxWidth.isFinite ? constraints.maxWidth : widget.crossAxisExtent,
                            hitRegionExtent: widget.hitRegionExtent,
                            resizePercentage: widget.resizePercentage,
                            cursor: SystemMouseCursors.resizeUpDown,
                            semanticFormatterCallback: widget.semanticFormatterCallback,
                          ),
                      ],
                    ),
              ),
        ),
      );
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

/// A [FResizable]'s style.
final class FResizableStyle with Diagnosticable, _$FResizableStyleFunctions {
  /// The horizontal divider style.
  @override
  final FResizableDividerStyle horizontalDividerStyle;

  /// The vertical divider style.
  @override
  final FResizableDividerStyle verticalDividerStyle;

  /// Creates a [FResizableStyle].
  FResizableStyle({required this.horizontalDividerStyle, required this.verticalDividerStyle});

  /// Creates a [FResizableStyle] that inherits its properties.
  FResizableStyle.inherit({required FColors colors, required FStyle style})
    : this(
        horizontalDividerStyle: FResizableDividerStyle(
          color: colors.border,
          focusedOutlineStyle: style.focusedOutlineStyle,
          thumbStyle: FResizableDividerThumbStyle(
            decoration: BoxDecoration(color: colors.border, borderRadius: style.borderRadius),
            foregroundColor: colors.foreground,
            height: 20,
            width: 10,
          ),
        ),
        verticalDividerStyle: FResizableDividerStyle(
          color: colors.border,
          focusedOutlineStyle: style.focusedOutlineStyle,
          thumbStyle: FResizableDividerThumbStyle(
            decoration: BoxDecoration(color: colors.border, borderRadius: style.borderRadius),
            foregroundColor: colors.foreground,
            height: 10,
            width: 20,
          ),
        ),
      );
}

@internal
class InheritedData extends InheritedWidget {
  static InheritedData of(BuildContext context) {
    final InheritedData? result = context.dependOnInheritedWidgetOfExactType<InheritedData>();
    assert(result != null, 'No InheritedData found in context. Is there a parent FResizableBox?');
    return result!;
  }

  final FResizableController controller;
  final Axis axis;
  final FResizableRegionData data;

  const InheritedData({
    required this.controller,
    required this.axis,
    required this.data,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(InheritedData old) => controller != old.controller || axis != old.axis || data != old.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(EnumProperty('axis', axis))
      ..add(DiagnosticsProperty('data', data));
  }
}

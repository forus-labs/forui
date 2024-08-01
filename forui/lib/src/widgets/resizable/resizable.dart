import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable/divider.dart';

export 'divider.dart' hide Divider, HorizontalDivider, ResizeDownIntent, ResizeUpIntent, VerticalDivider;
export 'resizable_controller.dart';
export 'resizable_region.dart';
export 'resizable_region_data.dart' hide UpdatableResizableRegionData;

/// A resizable which children can be resized along either the horizontal or vertical main axis.
///
/// Each child is a [FResizableRegion] has a initial and minimum extent. Setting an initial extent less than the
/// minimum extent will result in undefined behaviour. The children are arranged from top to bottom, or left to right,
/// depending on the main [axis].
///
/// Although not required, it is recommended that a [FResizable] contains at least 2 [FResizable] regions.
///
/// See:
/// * https://forui.dev/docs/resizable for working examples.
/// * [FResizableStyle] for customizing a resizable's appearance.
class FResizable extends StatefulWidget {
  static double _platform(double? hitRegion) => switch (const Runtime().type) {
        _ when hitRegion != null => hitRegion,
        PlatformType.android || PlatformType.ios => 60,
        _ => 10,
      };

  /// The controller that manages the resizing of regions. Defaults to [FResizableController.cascade].
  final FResizableController controller;

  /// The resizable' style.
  final FResizableStyle? style;

  /// The main axis along which the [children] can be resized.
  final Axis axis;

  /// The divider between the resizable regions. Defaults to [FResizableDivider.dividerWithThumb].
  final FResizableDivider divider;

  /// The extent in the non-resizable axis, in logical pixels.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [crossAxisExtent] is not positive.
  final double? crossAxisExtent;

  /// The resizing gesture's hit region extent along the resizable axis, in logical pixels.
  ///
  /// Hit regions are centered between [FResizableRegion]s.
  ///
  /// Defaults to `60` on Android and iOS, and `10` on other platforms.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [hitRegionExtent] <= 0.
  final double hitRegionExtent;

  /// The children that may be resized.
  final List<FResizableRegion> children;

  /// Creates a [FResizable].
  FResizable({
    required this.axis,
    required this.children,
    this.style,
    this.divider = FResizableDivider.dividerWithThumb,
    this.crossAxisExtent,
    FResizableController? controller,
    double? hitRegionExtent,
    super.key,
  })  : assert(
          crossAxisExtent == null || 0 < crossAxisExtent,
          'The crossAxisExtent should be positive, but is $crossAxisExtent.',
        ),
        assert(
          hitRegionExtent == null || 0 < hitRegionExtent,
          'The hitRegionExtent should be positive, but is $hitRegionExtent.',
        ),
        controller = controller ?? FResizableController.cascade(),
        hitRegionExtent = hitRegionExtent ?? _platform(hitRegionExtent);

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
      ..add(IterableProperty('children', children));
  }
}

class _FResizableState extends State<FResizable> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _update();
  }

  @override
  void didUpdateWidget(FResizable old) {
    super.didUpdateWidget(old);
    if (widget.axis != old.axis ||
        widget.crossAxisExtent != old.crossAxisExtent ||
        widget.controller != old.controller ||
        !widget.children.equals(old.children)) {
      _update();
    }
  }

  void _update() {
    var minOffset = 0.0;
    final minTotalExtent =
        widget.children.sum((child) => max(child.minExtent ?? 0, widget.hitRegionExtent), initial: 0.0);
    final totalExtent = widget.children.sum((child) => child.initialExtent, initial: 0.0);
    final regions = [
      for (final (index, region) in widget.children.indexed)
        FResizableRegionData(
          index: index,
          extent: (
            min: region.minExtent ?? widget.hitRegionExtent,
            max: totalExtent - minTotalExtent + max(region.minExtent ?? 0, widget.hitRegionExtent),
            total: totalExtent
          ),
          offset: (min: minOffset, max: minOffset += region.initialExtent),
        ),
    ];

    widget.controller.regions.clear();
    widget.controller.regions.addAll(regions);
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.controller.regions.length == widget.children.length,
      'The number of FResizableData should be equal to the number of children.',
    );

    final (:horizontal, :vertical) = (widget.style ?? context.theme.resizableStyle).dividerStyles;
    if (widget.axis == Axis.horizontal) {
      return SizedBox(
        height: widget.crossAxisExtent,
        child: ListenableBuilder(
          listenable: widget.controller,
          builder: (context, _) => Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < widget.children.length; i++)
                    InheritedData(
                      controller: widget.controller,
                      axis: widget.axis,
                      data: widget.controller.regions[i],
                      child: widget.children[i],
                    ),
                ],
              ),
              for (var i = 0; i < widget.children.length - 1; i++)
                HorizontalDivider(
                  controller: widget.controller,
                  style: horizontal,
                  type: widget.divider,
                  indexes: (left: i, right: i + 1),
                  crossAxisExtent: widget.crossAxisExtent,
                  hitRegionExtent: widget.hitRegionExtent,
                  cursor: SystemMouseCursors.resizeLeftRight,
                ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        width: widget.crossAxisExtent,
        child: ListenableBuilder(
          listenable: widget.controller,
          builder: (context, _) => Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < widget.children.length; i++)
                    InheritedData(
                      axis: widget.axis,
                      controller: widget.controller,
                      data: widget.controller.regions[i],
                      child: widget.children[i],
                    ),
                ],
              ),
              for (var i = 0; i < widget.children.length - 1; i++)
                VerticalDivider(
                  controller: widget.controller,
                  style: vertical,
                  type: widget.divider,
                  indexes: (left: i, right: i + 1),
                  crossAxisExtent: widget.crossAxisExtent,
                  hitRegionExtent: widget.hitRegionExtent,
                  cursor: SystemMouseCursors.resizeUpDown,
                ),
            ],
          ),
        ),
      );
    }
  }
}

/// A [FResizable]'s style.
final class FResizableStyle with Diagnosticable {
  /// The divider styles.
  final ({FResizableDividerStyle horizontal, FResizableDividerStyle vertical}) dividerStyles;

  /// Creates a [FResizableStyle].
  FResizableStyle({required this.dividerStyles});

  /// Creates a [FResizableStyle] that inherits its properties from [colorScheme].
  FResizableStyle.inherit({required FColorScheme colorScheme})
      : dividerStyles = (
          horizontal: FResizableDividerStyle(
            color: colorScheme.border,
            thumbStyle: FResizableDividerThumbStyle(
              backgroundColor: colorScheme.border,
              foregroundColor: colorScheme.foreground,
              height: 20,
              width: 10,
            ),
          ),
          vertical: FResizableDividerStyle(
            color: colorScheme.border,
            thumbStyle: FResizableDividerThumbStyle(
              backgroundColor: colorScheme.border,
              foregroundColor: colorScheme.foreground,
              height: 10,
              width: 20,
            ),
          ),
        );

  /// Returns a copy of this [FResizableStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FResizableStyle(
  ///   dividerStyles: (
  ///     horizontal: ...,
  ///     vertical: ...,
  ///   ),
  /// );
  ///
  /// final copy = style.copyWith(vertical: ...);
  /// print(style.horizontal == copy.horizontal); // true
  /// print(style.vertical == copy.vertical); // false
  /// ```
  @useResult
  FResizableStyle copyWith({FResizableDividerStyle? horizontal, FResizableDividerStyle? vertical}) => FResizableStyle(
        dividerStyles: (
          horizontal: horizontal ?? dividerStyles.horizontal,
          vertical: vertical ?? dividerStyles.vertical,
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('dividerStyles.horizontal', dividerStyles.horizontal))
      ..add(DiagnosticsProperty('dividerStyles.vertical', dividerStyles.vertical));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FResizableStyle && runtimeType == other.runtimeType && dividerStyles == other.dividerStyles;

  @override
  int get hashCode => dividerStyles.hashCode;
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

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/picker/picker.dart';

class _ScrollBehavior extends ScrollBehavior {
  static final _devices = PointerDeviceKind.values.toSet();

  const _ScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => _devices;
}

/// A marker interface that indicates that a widget is a picker wheel.
mixin FPickerWheelMixin on Widget {}

/// A picker wheel that displays a list of items that can be scrolled vertically.
///
/// It should only be used in a [FPicker].
abstract class FPickerWheel extends StatefulWidget with FPickerWheelMixin {
  /// Estimates the extent of each item in the picker based on the given [style] and [context].
  static double estimateExtent(FPickerStyle style, BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    final scale = MediaQuery.textScalerOf(context);

    final height = style.textStyle.height ?? defaultTextStyle.style.height;
    final fontSize = style.textStyle.fontSize ?? defaultTextStyle.style.fontSize ?? 0;
    return scale.scale(height == null ? fontSize : height * fontSize);
  }

  /// The flex factor to use for this child.
  ///
  /// If zero, the child is inflexible and determines its own size. If non-zero, the amount of space the child can
  /// occupy in the main axis is determined by dividing the free space (after placing the inflexible children) according
  /// to the flex factors of the flexible children.
  ///
  /// Defaults to 1.
  final int flex;

  /// The extent of each item in the picker. Defaults to the height of the picker's text style, scaled by the current
  /// [TextScaler].
  final double? itemExtent;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// Creates a picker wheel with the given children.
  const factory FPickerWheel({
    required List<Widget> children,
    bool loop,
    int flex,
    double? itemExtent,
    bool autofocus,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    Key? key,
  }) = ListWheel;

  /// Creates a picker wheel with the given builder.
  const factory FPickerWheel.builder({
    required IndexedWidgetBuilder builder,
    int flex,
    double? itemExtent,
    bool autofocus,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    Key? key,
  }) = BuilderWheel;

  const FPickerWheel._({
    this.flex = 1,
    this.itemExtent,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('flex', flex))
      ..add(DoubleProperty('itemExtent', itemExtent))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

abstract class _State<T extends FPickerWheel> extends State<T> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focused = widget.autofocus;
  }

  @override
  Widget build(BuildContext context) {
    final PickerData(:controller, :style) = PickerData.of(context);
    final extent = widget.itemExtent ?? FPickerWheel.estimateExtent(style, context);
    return Flexible(
      flex: widget.flex,
      child: FocusableActionDetector(
        descendantsAreFocusable: false,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        onFocusChange: (focused) {
          widget.onFocusChange?.call(focused);
          if (_focused != focused) {
            setState(() => _focused = focused);
          }
        },
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.arrowUp): ScrollIntent(direction: AxisDirection.up),
          SingleActivator(LogicalKeyboardKey.arrowDown): ScrollIntent(direction: AxisDirection.down),
        },
        actions: {
          ScrollIntent: CallbackAction<ScrollIntent>(
            onInvoke: (intent) {
              controller.animateToItem(
                controller.selectedItem + (intent.direction == AxisDirection.up ? -1 : 1),
                duration: const Duration(milliseconds: 100),
                curve: Curves.decelerate,
              );

              return null;
            },
          ),
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_focused)
              Container(
                height: extent,
                decoration: BoxDecoration(
                  border: Border.all(color: style.focusedOutlineStyle.color, width: style.focusedOutlineStyle.width),
                  borderRadius: style.focusedOutlineStyle.borderRadius,
                ),
              ),
            ScrollConfiguration(
              behavior: const _ScrollBehavior(),
              child: ListWheelScrollView.useDelegate(
                controller: controller,
                physics: const FixedExtentScrollPhysics(),
                itemExtent: extent,
                diameterRatio: style.diameterRatio,
                magnification: style.magnification,
                squeeze: style.squeeze,
                overAndUnderCenterOpacity: style.overAndUnderCenterOpacity,
                childDelegate: delegate(style),
                onSelectedItemChanged: (_) => HapticFeedback.selectionClick(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListWheelChildDelegate delegate(FPickerStyle style);
}

@internal
class ListWheel extends FPickerWheel {
  final bool loop;
  final List<Widget> children;

  const ListWheel({
    required this.children,
    this.loop = false,
    super.flex = 1,
    super.itemExtent,
    super.autofocus,
    super.focusNode,
    super.onFocusChange,
    super.key,
  }) : super._();

  @override
  State<StatefulWidget> createState() => _ListState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('loop', value: loop, ifTrue: 'loop'));
  }
}

class _ListState extends _State<ListWheel> {
  @override
  ListWheelChildDelegate delegate(FPickerStyle style) {
    final children = [
      for (final child in widget.children)
        Center(
          child: DefaultTextStyle.merge(
            textHeightBehavior: style.textHeightBehavior,
            style: style.textStyle,
            child: Semantics(inMutuallyExclusiveGroup: true, child: child),
          ),
        ),
    ];

    return widget.loop
        ? ListWheelChildLoopingListDelegate(children: children)
        : ListWheelChildListDelegate(children: children);
  }
}

@internal
class BuilderWheel extends FPickerWheel {
  final IndexedWidgetBuilder builder;

  const BuilderWheel({
    required this.builder,
    super.flex,
    super.itemExtent,
    super.autofocus,
    super.focusNode,
    super.onFocusChange,
    super.key,
  }) : super._();

  @override
  State<BuilderWheel> createState() => _BuilderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('builder', builder));
  }
}

class _BuilderState extends _State<BuilderWheel> {
  @override
  ListWheelChildDelegate delegate(FPickerStyle style) => ListWheelChildBuilderDelegate(
    builder: (context, index) => Center(
      child: DefaultTextStyle.merge(
        textHeightBehavior: style.textHeightBehavior,
        style: style.textStyle,
        child: widget.builder(context, index),
      ),
    ),
  );
}

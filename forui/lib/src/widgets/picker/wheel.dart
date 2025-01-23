import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

class _ScrollBehavior extends ScrollBehavior {
  static final _devices = PointerDeviceKind.values.toSet();

  const _ScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => _devices;
}

@internal
abstract class Wheel extends StatefulWidget {
  static double estimateExtent(FPickerStyle style, BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    final scale = MediaQuery.textScalerOf(context);

    final height = style.textStyle.height ?? defaultTextStyle.style.height;
    final fontSize = style.textStyle.fontSize ?? defaultTextStyle.style.fontSize ?? 0;
    return scale.scale(height == null ? fontSize : height * fontSize);
  }

  final FixedExtentScrollController controller;
  final FPickerStyle style;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final double? itemExtent;

  const Wheel({
    required this.controller,
    required this.style,
    required this.autofocus,
    required this.focusNode,
    required this.onFocusChange,
    required this.itemExtent,
    super.key,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('itemExtent', itemExtent))
      ..add(DiagnosticsProperty<bool>('autofocus', autofocus));
  }
}

abstract class _State<T extends Wheel> extends State<T> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focused = widget.autofocus;
  }

  @override
  Widget build(BuildContext context) {
    final extent = widget.itemExtent ?? Wheel.estimateExtent(widget.style, context);
    return ScrollConfiguration(
      behavior: const _ScrollBehavior(),
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
        mouseCursor: SystemMouseCursors.click,
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.arrowUp): ScrollIntent(direction: AxisDirection.up),
          SingleActivator(LogicalKeyboardKey.arrowDown): ScrollIntent(direction: AxisDirection.down),
        },
        actions: {
          ScrollIntent: CallbackAction<ScrollIntent>(
            onInvoke: (intent) {
              final offset = intent.direction == AxisDirection.up ? -1 : 1;
              widget.controller.animateToItem(
                widget.controller.selectedItem + offset,
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
                  border: Border.all(color: widget.style.focusedOutlineStyle.color),
                  borderRadius: widget.style.focusedOutlineStyle.borderRadius,
                ),
              ),
            ListWheelScrollView.useDelegate(
              controller: widget.controller,
              physics: const FixedExtentScrollPhysics(),
              itemExtent: extent,
              diameterRatio: widget.style.diameterRatio,
              magnification: widget.style.magnification,
              squeeze: widget.style.squeeze,
              overAndUnderCenterOpacity: widget.style.overAndUnderCenterOpacity,
              childDelegate: delegate(widget.style),
            ),
          ],
        ),
      ),
    );
  }

  ListWheelChildDelegate delegate(FPickerStyle style);
}

@internal
class ListWheel extends Wheel {
  final bool loop;
  final List<Widget> children;

  const ListWheel({
    required this.loop,
    required this.children,
    required super.controller,
    required super.style,
    required super.itemExtent,
    required super.autofocus,
    required super.focusNode,
    required super.onFocusChange,
    super.key,
  });

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
            child: Semantics(
              inMutuallyExclusiveGroup: true,
              child: child,
            ),
          ),
        )
    ];

    return widget.loop
        ? ListWheelChildLoopingListDelegate(children: children)
        : ListWheelChildListDelegate(children: children);
  }
}

@internal
class BuilderWheel extends Wheel {
  final IndexedWidgetBuilder builder;

  const BuilderWheel({
    required this.builder,
    required super.controller,
    required super.style,
    required super.itemExtent,
    required super.autofocus,
    required super.focusNode,
    required super.onFocusChange,
    super.key,
  });

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

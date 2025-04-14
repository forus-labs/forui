import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'label.style.dart';

/// A component that describes a form field with a label, description, and error message (if any).
///
/// There are two different [Axis] variants for labels:
/// * [Axis.horizontal] - Used in [FCheckbox].
/// ```diagram
/// |--------------------------|
/// |  [child]  [label]        |
/// |           [description]  |
/// |           [error]        |
/// |--------------------------|
/// ```
///
/// * [Axis.vertical] - Used in [FTextField].
/// ```diagram
/// |-----------------|
/// |  [label]        |
/// |  [child]        |
/// |  [description]  |
/// |  [error]        |
/// |-----------------|
/// ```
///
/// See:
/// * https://forui.dev/docs/form/label for working examples.
/// * [FLabelStyles] for customizing a label's appearance.
final class FLabel extends StatelessWidget {
  /// The label's style. Defaults to the appropriate style in [FThemeData.labelStyles].
  // ignore: diagnostic_describe_all_properties
  final FLabelStyle? style;

  /// The label that describes the form field.
  final Widget? label;

  /// The description that elaborates on the label.
  final Widget? description;

  /// The error message.
  final Widget? error;

  /// The axis that determines the layout direction.
  final Axis axis;

  /// The label's states.
  final Set<WidgetState> states;

  /// The child.
  final Widget child;

  /// Creates a [FLabel].
  const FLabel({
    required this.axis,
    required this.child,
    this.style,
    this.label,
    this.description,
    this.error,
    this.states = const {},
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style =
        this.style ??
        switch (axis) {
          Axis.horizontal => context.theme.labelStyles.horizontalStyle,
          Axis.vertical => context.theme.labelStyles.verticalStyle,
        };

    if (label == null && description == null && error == null) {
      return Padding(padding: style.childPadding, child: child);
    }

    return switch (axis) {
      Axis.horizontal => _FHorizontalLabel(
        style: style,
        label: label,
        description: description,
        error: error,
        states: states,
        child: child,
      ),
      Axis.vertical => _FVerticalLabel(
        style: style,
        label: label,
        description: description,
        error: error,
        states: states,
        child: child,
      ),
    };
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('axis', axis))
      ..add(IterableProperty('states', states));
  }
}

class _FHorizontalLabel extends StatelessWidget {
  final FLabelStyle style;
  final Widget? label;
  final Widget? description;
  final Widget? error;
  final Set<WidgetState> states;
  final Widget child;

  const _FHorizontalLabel({
    required this.style,
    required this.label,
    required this.description,
    required this.error,
    required this.states,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Table(
    defaultColumnWidth: const IntrinsicColumnWidth(),
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
    children: [
      TableRow(
        children: [
          TableCell(child: Padding(padding: style.childPadding, child: child)),
          if (label != null)
            _buildCell(padding: style.labelPadding, textStyle: style.labelTextStyle.resolve(states), child: label)
          else
            _buildCell(
              padding: style.descriptionPadding,
              textStyle: style.descriptionTextStyle.resolve(states),
              child: description,
            ),
        ],
      ),
      if (label != null && description != null)
        TableRow(
          children: [
            const TableCell(child: SizedBox()),
            _buildCell(
              padding: style.descriptionPadding,
              textStyle: style.descriptionTextStyle.resolve(states),
              child: description,
            ),
          ],
        ),
      if (error != null && states.contains(WidgetState.error))
        TableRow(
          children: [
            const TableCell(child: SizedBox()),
            TableCell(
              child: Padding(
                padding: style.errorPadding,
                child: DefaultTextStyle(style: style.errorTextStyle, child: error!),
              ),
            ),
          ],
        ),
    ],
  );

  Widget _buildCell({required EdgeInsetsGeometry padding, required TextStyle textStyle, Widget? child}) {
    if (child == null) {
      return const TableCell(child: SizedBox());
    }

    return TableCell(child: Padding(padding: padding, child: DefaultTextStyle(style: textStyle, child: child)));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('style', style.toString()))
      ..add(IterableProperty('states', states));
  }
}

class _FVerticalLabel extends StatelessWidget {
  final FLabelStyle style;
  final Widget? label;
  final Widget? description;
  final Widget? error;
  final Set<WidgetState> states;
  final Widget child;

  const _FVerticalLabel({
    required this.style,
    required this.label,
    required this.description,
    required this.error,
    required this.states,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      if (label != null)
        Padding(
          padding: style.labelPadding,
          child: DefaultTextStyle(
            style: style.labelTextStyle.resolve(states),
            textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
            child: label!,
          ),
        ),
      Padding(padding: style.childPadding, child: child),
      if (description != null)
        Padding(
          padding: style.descriptionPadding,
          child: DefaultTextStyle(
            style: style.descriptionTextStyle.resolve(states),
            textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
            child: description!,
          ),
        ),
      if (error != null && states.contains(WidgetState.error))
        Padding(
          padding: style.errorPadding,
          child: DefaultTextStyle(
            style: style.errorTextStyle,
            textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
            child: error!,
          ),
        ),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('style', style.toString()))
      ..add(IterableProperty('states', states));
  }
}

/// The [FLabel]'s styles.
class FLabelStyles with Diagnosticable, _$FLabelStylesFunctions {
  /// The horizontal label's style.
  @override
  final FLabelStyle horizontalStyle;

  /// The vertical label's style.
  @override
  final FLabelStyle verticalStyle;

  /// Creates a [FLabelStyles].
  const FLabelStyles({required this.horizontalStyle, required this.verticalStyle});

  /// Creates a [FLabelStyles] that inherits its properties.
  FLabelStyles.inherit({required FStyle style})
    : horizontalStyle = FLabelStyle.inherit(
        style: style,
        descriptionPadding: const EdgeInsets.only(top: 2),
        errorPadding: const EdgeInsets.only(top: 2),
        childPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      verticalStyle = FLabelStyle.inherit(
        style: style,
        labelPadding: const EdgeInsets.only(bottom: 5),
        descriptionPadding: const EdgeInsets.only(top: 5),
        errorPadding: const EdgeInsets.only(top: 5),
      );
}

/// The [FLabel]'s style.
class FLabelStyle extends FFormFieldStyle with _$FLabelStyleFunctions {
  /// The label's padding.
  @override
  final EdgeInsetsGeometry labelPadding;

  /// The description's padding.
  @override
  final EdgeInsetsGeometry descriptionPadding;

  /// The error's padding.
  @override
  final EdgeInsetsGeometry errorPadding;

  /// The child's padding.
  @override
  final EdgeInsetsGeometry childPadding;

  /// Creates a [FLabelStyle].
  const FLabelStyle({
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.labelPadding = EdgeInsets.zero,
    this.descriptionPadding = EdgeInsets.zero,
    this.errorPadding = EdgeInsets.zero,
    this.childPadding = EdgeInsets.zero,
  });

  /// Creates a [FLabelStyle].
  FLabelStyle.inherit({
    required FStyle style,
    this.labelPadding = EdgeInsets.zero,
    this.descriptionPadding = EdgeInsets.zero,
    this.errorPadding = EdgeInsets.zero,
    this.childPadding = EdgeInsets.zero,
  }) : super(
         labelTextStyle: style.formFieldStyle.labelTextStyle,
         descriptionTextStyle: style.formFieldStyle.descriptionTextStyle,
         errorTextStyle: style.formFieldStyle.errorTextStyle,
       );
}

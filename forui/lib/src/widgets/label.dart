import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'label.style.dart';

/// The [FLabel]'s style.
typedef FLabelStyle = ({FLabelLayoutStyle layout, FLabelStateStyles state});

/// The label's state.
enum FLabelState {
  /// The label is enabled.
  enabled,

  /// The label is disabled.
  disabled,

  /// The label has an error.
  error,
}

/// A label that describes a form field with a label, description, and error message (if any).
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

  /// The axis that represents.
  final Axis axis;

  /// The state of the label.
  ///
  /// If state != [FLabelState.error], the [error] will not be displayed.
  final FLabelState state;

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
    this.state = FLabelState.enabled,
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
      return Padding(padding: style.layout.childPadding, child: child);
    }

    return switch (axis) {
      Axis.horizontal => _FHorizontalLabel(
        style: style,
        label: label,
        description: description,
        error: error,
        state: state,
        child: child,
      ),
      Axis.vertical => _FVerticalLabel(
        style: style,
        label: label,
        description: description,
        error: error,
        state: state,
        child: child,
      ),
    };
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('axis', axis))
      ..add(EnumProperty('state', state));
  }
}

final class _FHorizontalLabel extends StatelessWidget {
  final FLabelStyle style;
  final Widget? label;
  final Widget? description;
  final Widget? error;
  final FLabelState state;
  final Widget child;

  const _FHorizontalLabel({
    required this.style,
    required this.label,
    required this.description,
    required this.error,
    required this.state,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final stateStyle = switch (state) {
      FLabelState.enabled => style.state.enabledStyle,
      FLabelState.disabled => style.state.disabledStyle,
      FLabelState.error => style.state.errorStyle,
    };

    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
      children: [
        TableRow(
          children: [
            TableCell(child: Padding(padding: style.layout.childPadding, child: child)),
            if (label != null)
              _buildCell(padding: style.layout.labelPadding, textStyle: stateStyle.labelTextStyle, child: label)
            else
              _buildCell(
                padding: style.layout.descriptionPadding,
                textStyle: stateStyle.descriptionTextStyle,
                child: description,
              ),
          ],
        ),
        if (label != null && description != null)
          TableRow(
            children: [
              const TableCell(child: SizedBox()),
              _buildCell(
                padding: style.layout.descriptionPadding,
                textStyle: stateStyle.descriptionTextStyle,
                child: description,
              ),
            ],
          ),
        if (error != null && state == FLabelState.error)
          TableRow(
            children: [
              const TableCell(child: SizedBox()),
              TableCell(
                child: Padding(
                  padding: style.layout.errorPadding,
                  child: DefaultTextStyle(style: style.state.errorStyle.errorTextStyle, child: error!),
                ),
              ),
            ],
          ),
      ],
    );
  }

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
      ..add(EnumProperty('state', state));
  }
}

class _FVerticalLabel extends StatelessWidget {
  final FLabelStyle style;
  final Widget? label;
  final Widget? description;
  final Widget? error;
  final FLabelState state;
  final Widget child;

  const _FVerticalLabel({
    required this.style,
    required this.label,
    required this.description,
    required this.error,
    required this.state,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final stateStyle = switch (state) {
      FLabelState.enabled => style.state.enabledStyle,
      FLabelState.disabled => style.state.disabledStyle,
      FLabelState.error => style.state.errorStyle,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Padding(
            padding: style.layout.labelPadding,
            child: DefaultTextStyle(
              style: stateStyle.labelTextStyle,
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              child: label!,
            ),
          ),
        Padding(padding: style.layout.childPadding, child: child),
        if (description != null)
          Padding(
            padding: style.layout.descriptionPadding,
            child: DefaultTextStyle(
              style: stateStyle.descriptionTextStyle,
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              child: description!,
            ),
          ),
        if (error != null && state == FLabelState.error)
          Padding(
            padding: style.layout.errorPadding,
            child: DefaultTextStyle(
              style: style.state.errorStyle.errorTextStyle,
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              child: error!,
            ),
          ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('style', style.toString()))
      ..add(EnumProperty('state', state));
  }
}

/// The [FLabel]'s styles.
final class FLabelStyles with Diagnosticable, _$FLabelStylesFunctions {
  /// The horizontal label's style.
  @override
  final FLabelStyle horizontalStyle;

  /// The vertical label's style.
  @override
  final FLabelStyle verticalStyle;

  /// Creates a [FLabelStyles].
  const FLabelStyles({required this.horizontalStyle, required this.verticalStyle});

  /// Creates a [FLabelStyles] that inherits its properties from the given [style].
  FLabelStyles.inherit({required FStyle style})
    : horizontalStyle = (
        layout: const FLabelLayoutStyle(
          childPadding: EdgeInsets.symmetric(horizontal: 8),
          descriptionPadding: EdgeInsets.only(top: 2),
          errorPadding: EdgeInsets.only(top: 2),
        ),
        state: FLabelStateStyles.inherit(style: style),
      ),
      verticalStyle = (
        layout: const FLabelLayoutStyle(
          labelPadding: EdgeInsets.only(bottom: 5),
          descriptionPadding: EdgeInsets.only(top: 5),
          errorPadding: EdgeInsets.only(top: 5),
        ),
        state: FLabelStateStyles.inherit(style: style),
      );
}

/// The [FLabel]'s layout style.
final class FLabelLayoutStyle with Diagnosticable, _$FLabelLayoutStyleFunctions {
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

  /// Creates a [FLabelLayoutStyle].
  const FLabelLayoutStyle({
    this.labelPadding = EdgeInsets.zero,
    this.descriptionPadding = EdgeInsets.zero,
    this.errorPadding = EdgeInsets.zero,
    this.childPadding = EdgeInsets.zero,
  });
}

/// The [FLabel]'s state styles.
class FLabelStateStyles with Diagnosticable, _$FLabelStateStylesFunctions {
  /// The style for the form field when it is enabled.
  @override
  final FFormFieldStyle enabledStyle;

  /// The style for the form field when it is disabled.
  @override
  final FFormFieldStyle disabledStyle;

  /// The style for the form field when it has an error.
  @override
  final FFormFieldErrorStyle errorStyle;

  /// Creates a [FLabelStateStyles].
  FLabelStateStyles({required this.enabledStyle, required this.disabledStyle, required this.errorStyle});

  /// Creates a [FLabelStateStyles] that inherits its properties from [style].
  FLabelStateStyles.inherit({required FStyle style})
    : this(
        enabledStyle: style.enabledFormFieldStyle,
        disabledStyle: style.disabledFormFieldStyle,
        errorStyle: style.errorFormFieldStyle,
      );
}

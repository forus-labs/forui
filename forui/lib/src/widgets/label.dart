import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

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
    final style = this.style ??
        switch (axis) {
          Axis.horizontal => context.theme.labelStyles.horizontalStyle,
          Axis.vertical => context.theme.labelStyles.verticalStyle,
        };

    if (label == null && description == null && error == null) {
      return Padding(
        padding: style.layout.childPadding,
        child: child,
      );
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
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: style.layout.childPadding,
                child: child,
              ),
            ),
            if (label != null)
              _buildCell(
                padding: style.layout.labelPadding,
                textStyle: stateStyle.labelTextStyle,
                child: label,
              )
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
                  child: DefaultTextStyle(
                    style: style.state.errorStyle.errorTextStyle,
                    child: error!,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildCell({
    required EdgeInsets padding,
    required TextStyle textStyle,
    Widget? child,
  }) {
    if (child == null) {
      return const TableCell(child: SizedBox());
    }

    return TableCell(
      child: Padding(
        padding: padding,
        child: DefaultTextStyle(
          style: textStyle,
          child: child,
        ),
      ),
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
        Padding(
          padding: style.layout.childPadding,
          child: child,
        ),
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
final class FLabelStyles with Diagnosticable {
  /// The horizontal label's style.
  final FLabelStyle horizontalStyle;

  /// The vertical label's style.
  final FLabelStyle verticalStyle;

  /// Creates a [FLabelStyles].
  const FLabelStyles({
    required this.horizontalStyle,
    required this.verticalStyle,
  });

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
          state: FLabelStateStyles.inherit(style: style)
        );

  /// Returns a copy of this [FLabelStyles] with the given properties replaced.
  @useResult
  FLabelStyles copyWith({
    FLabelStyle? horizontalStyle,
    FLabelStyle? verticalStyle,
  }) =>
      FLabelStyles(
        horizontalStyle: horizontalStyle ?? this.horizontalStyle,
        verticalStyle: verticalStyle ?? this.verticalStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('horizontalStyle', horizontalStyle.toString()))
      ..add(StringProperty('verticalStyle', verticalStyle.toString()));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLabelStyles &&
          runtimeType == other.runtimeType &&
          horizontalStyle == other.horizontalStyle &&
          verticalStyle == other.verticalStyle;

  @override
  int get hashCode => horizontalStyle.hashCode ^ verticalStyle.hashCode;
}

/// The [FLabel]'s layout style.
final class FLabelLayoutStyle with Diagnosticable {
  /// The label's padding.
  final EdgeInsets labelPadding;

  /// The description's padding.
  final EdgeInsets descriptionPadding;

  /// The error's padding.
  final EdgeInsets errorPadding;

  /// The child's padding.
  final EdgeInsets childPadding;

  /// Creates a [FLabelLayoutStyle].
  const FLabelLayoutStyle({
    this.labelPadding = EdgeInsets.zero,
    this.descriptionPadding = EdgeInsets.zero,
    this.errorPadding = EdgeInsets.zero,
    this.childPadding = EdgeInsets.zero,
  });

  /// Returns a copy of this [FLabelLayoutStyle] with the given properties replaced.
  @useResult
  FLabelLayoutStyle copyWith({
    EdgeInsets? labelPadding,
    EdgeInsets? descriptionPadding,
    EdgeInsets? errorPadding,
    EdgeInsets? childPadding,
  }) =>
      FLabelLayoutStyle(
        labelPadding: labelPadding ?? this.labelPadding,
        descriptionPadding: descriptionPadding ?? this.descriptionPadding,
        errorPadding: errorPadding ?? this.errorPadding,
        childPadding: childPadding ?? this.childPadding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelPadding', labelPadding))
      ..add(DiagnosticsProperty('descriptionPadding', descriptionPadding))
      ..add(DiagnosticsProperty('errorPadding', errorPadding))
      ..add(DiagnosticsProperty('childPadding', childPadding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLabelLayoutStyle &&
          runtimeType == other.runtimeType &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding;

  @override
  int get hashCode =>
      labelPadding.hashCode ^ descriptionPadding.hashCode ^ errorPadding.hashCode ^ childPadding.hashCode;
}

/// The [FLabel]'s state styles.
class FLabelStateStyles with Diagnosticable {
  /// The style for the form field when it is enabled.
  final FFormFieldStyle enabledStyle;

  /// The style for the form field when it is disabled.
  final FFormFieldStyle disabledStyle;

  /// The style for the form field when it has an error.
  final FFormFieldErrorStyle errorStyle;

  /// Creates a [FLabelStateStyles].
  FLabelStateStyles({
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
  });

  /// Creates a [FLabelStateStyles] that inherits its properties from [style].
  FLabelStateStyles.inherit({required FStyle style})
      : this(
          enabledStyle: style.enabledFormFieldStyle,
          disabledStyle: style.disabledFormFieldStyle,
          errorStyle: style.errorFormFieldStyle,
        );

  /// Returns a copy of this [FLabelStateStyles] with the given properties replaced.
  @useResult
  FLabelStateStyles copyWith({
    FFormFieldStyle? enabledStyle,
    FFormFieldStyle? disabledStyle,
    FFormFieldErrorStyle? errorStyle,
  }) =>
      FLabelStateStyles(
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
        errorStyle: errorStyle ?? this.errorStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle))
      ..add(DiagnosticsProperty('errorStyle', errorStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLabelStateStyles &&
          runtimeType == other.runtimeType &&
          enabledStyle == other.enabledStyle &&
          disabledStyle == other.disabledStyle &&
          errorStyle == other.errorStyle;

  @override
  int get hashCode => enabledStyle.hashCode ^ disabledStyle.hashCode ^ errorStyle.hashCode;
}

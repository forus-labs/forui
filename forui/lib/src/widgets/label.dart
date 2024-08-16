import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

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
/// ```
/// |--------------------------|
/// |  [child]  [label]        |
/// |           [description]  |
/// |           [error]        |
/// |--------------------------|
/// ```
///
/// * [Axis.vertical] - Used in [FTextField].
/// ```
/// |-----------------|
/// |  [label]        |
/// |  [child]        |
/// |  [description]  |
/// |  [error]        |
/// |-----------------|
/// ```
///
/// See:
/// * https://forui.dev/docs/label for working examples.
/// * [FLabelStyles] for customizing a label's appearance.
final class FLabel extends StatelessWidget {
  /// The label's style. Defaults to the appropriate style in [FThemeData.labelStyles].
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
          Axis.horizontal => context.theme.labelStyles.horizontal,
          Axis.vertical => context.theme.labelStyles.vertical,
        };

    if (label == null && description == null) {
      return Padding(
        padding: style.childPadding,
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
        )
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

  Widget _buildLabelCell(FLabelStyle style, FFormFieldStateStyle stateStyle) {
    if (label == null) {
      return const TableCell(child: SizedBox());
    }

    return TableCell(
      child: Padding(
        padding: style.labelPadding,
        child: DefaultTextStyle(
          style: stateStyle.labelTextStyle,
          child: label!,
        ),
      ),
    );
  }

  Widget _buildDescriptionCell(FLabelStyle style, FFormFieldStateStyle stateStyle) {
    if (description == null) {
      return const TableCell(child: SizedBox());
    }

    return TableCell(
      child: Padding(
        padding: style.descriptionPadding,
        child: DefaultTextStyle(
          style: stateStyle.descriptionTextStyle,
          child: description!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stateStyle = switch (state) {
      FLabelState.enabled => style.formFieldStyle.enabledStyle,
      FLabelState.disabled => style.formFieldStyle.disabledStyle,
      FLabelState.error => style.formFieldStyle.errorStyle,
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
                padding: style.childPadding,
                child: child,
              ),
            ),
            if (label != null) _buildLabelCell(style, stateStyle) else _buildDescriptionCell(style, stateStyle),
          ],
        ),
        if (label != null && description != null)
          TableRow(
            children: [
              const TableCell(child: SizedBox()),
              _buildDescriptionCell(style, stateStyle),
            ],
          ),
        if (error != null && state == FLabelState.error)
          TableRow(
            children: [
              const TableCell(child: SizedBox()),
              TableCell(
                child: Padding(
                  padding: style.errorPadding,
                  child: DefaultTextStyle(
                    style: style.formFieldStyle.errorStyle.errorTextStyle,
                    child: error!,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
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
      FLabelState.enabled => style.formFieldStyle.enabledStyle,
      FLabelState.disabled => style.formFieldStyle.disabledStyle,
      FLabelState.error => style.formFieldStyle.errorStyle,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Padding(
            padding: style.labelPadding,
            child: DefaultTextStyle(
              style: stateStyle.labelTextStyle,
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              child: label!,
            ),
          ),
        Padding(
          padding: style.childPadding,
          child: child,
        ),
        if (description != null)
          Padding(
            padding: style.descriptionPadding,
            child: DefaultTextStyle(
              style: stateStyle.descriptionTextStyle,
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              child: description!,
            ),
          ),
        if (error != null && state == FLabelState.error)
          Padding(
            padding: style.errorPadding,
            child: DefaultTextStyle(
              style: style.formFieldStyle.errorStyle.errorTextStyle,
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
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('state', state));
  }
}

/// The [FLabel]'s styles containing [FLabelStyle].
final class FLabelStyles with Diagnosticable {
  /// The horizontal label's style.
  final FLabelStyle horizontal;

  /// The vertical label's style.
  final FLabelStyle vertical;

  /// Creates a [FLabelStyles].
  const FLabelStyles({
    required this.horizontal,
    required this.vertical,
  });

  /// Creates a [FLabelStyles] that inherits its properties from the given [style].
  FLabelStyles.inherit({required FStyle style})
      : horizontal = FLabelStyle(
          formFieldStyle: style.formFieldStyle,
          childPadding: const EdgeInsets.only(right: 8),
          descriptionPadding: const EdgeInsets.only(top: 2),
          errorPadding: const EdgeInsets.only(top: 2),
        ),
        vertical = FLabelStyle(
          formFieldStyle: style.formFieldStyle,
          labelPadding: const EdgeInsets.only(bottom: 5),
          descriptionPadding: const EdgeInsets.only(top: 5),
          errorPadding: const EdgeInsets.only(top: 5),
        );

  /// Returns a copy of this [FLabelStyles] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FLabelStyles(
  ///   horizontal: ...,
  ///   vertical: ...,
  /// );
  ///
  /// final copy = style.copyWith(vertical: ...);
  ///
  /// print(style.horizontal == copy.horizontal); // true
  /// print(style.vertical == copy.vertical); // false
  /// ```
  @useResult
  FLabelStyles copyWith({
    FLabelStyle? horizontal,
    FLabelStyle? vertical,
  }) =>
      FLabelStyles(
        horizontal: horizontal ?? this.horizontal,
        vertical: vertical ?? this.vertical,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('horizontal', horizontal))
      ..add(DiagnosticsProperty('vertical', vertical));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLabelStyles &&
          runtimeType == other.runtimeType &&
          horizontal == other.horizontal &&
          vertical == other.vertical;

  @override
  int get hashCode => horizontal.hashCode ^ vertical.hashCode;
}

/// The [FLabel]'s style.
final class FLabelStyle with Diagnosticable {
  /// The form field's style.
  final FFormFieldStyle formFieldStyle;

  /// The label's padding.
  final EdgeInsets labelPadding;

  /// The description's padding.
  final EdgeInsets descriptionPadding;

  /// The error's padding.
  final EdgeInsets errorPadding;

  /// The child's padding.
  final EdgeInsets childPadding;

  /// Creates a [FLabelStyle].
  const FLabelStyle({
    required this.formFieldStyle,
    this.labelPadding = EdgeInsets.zero,
    this.descriptionPadding = EdgeInsets.zero,
    this.errorPadding = EdgeInsets.zero,
    this.childPadding = EdgeInsets.zero,
  });

  /// Returns a copy of this [FLabelStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FLabelStyle(
  ///   formFieldStyle: ...,
  ///   labelPadding: ...,
  ///   ...
  /// );
  ///
  /// final copy = style.copyWith(labelPadding: ...);
  ///
  /// print(style.formFieldStyle == copy.formFieldStyle); // true
  /// print(style.labelPadding == copy.labelPadding); // false
  /// ```
  @useResult
  FLabelStyle copyWith({
    FFormFieldStyle? formFieldStyle,
    EdgeInsets? labelPadding,
    EdgeInsets? descriptionPadding,
    EdgeInsets? errorPadding,
    EdgeInsets? childPadding,
  }) =>
      FLabelStyle(
        formFieldStyle: formFieldStyle ?? this.formFieldStyle,
        labelPadding: labelPadding ?? this.labelPadding,
        descriptionPadding: descriptionPadding ?? this.descriptionPadding,
        errorPadding: errorPadding ?? this.errorPadding,
        childPadding: childPadding ?? this.childPadding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('formFieldStyle', formFieldStyle))
      ..add(DiagnosticsProperty('labelPadding', labelPadding))
      ..add(DiagnosticsProperty('descriptionPadding', descriptionPadding))
      ..add(DiagnosticsProperty('errorPadding', errorPadding))
      ..add(DiagnosticsProperty('childPadding', childPadding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLabelStyle &&
          runtimeType == other.runtimeType &&
          formFieldStyle == other.formFieldStyle &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding;

  @override
  int get hashCode =>
      formFieldStyle.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode;
}

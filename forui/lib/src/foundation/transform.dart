import 'package:flutter/cupertino.dart';
import 'package:forui/forui.dart';

/// A marker interface that denotes that mixed-in types are transformable.
mixin FTransformable {}

/// Provides functions to transform a [T] using a given function.
extension FTransformables<T extends FTransformable> on T {
  /// Transform this [T] using the given [function].
  ///
  /// This should be used in conjunction with `copyWith` to update deeply nested properties that rely on this [T].
  ///
  // This function cannot be implemented directly in [FTransformable] as the callback accepts a self-referencing type.
  // It prevents mixed-in types from being inherited.
  T transform(T Function(T) function) => function(this);
}

class B extends StatelessWidget {

  void a(FColorScheme colorScheme, FTypography typography, FStyle style) {
    final checkboxSelectGroupStyle = FCheckboxSelectGroupStyle.inherit(
      style: FCheckboxStyle.inherit(colorScheme: colorScheme, style: style).transform((style) =>
          style.copyWith(
            enabledStyle: style.enabledStyle.copyWith(
              labelTextStyle: typography.sm.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
              descriptionTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
            ),
            disabledStyle: style.disabledStyle.copyWith(
              labelTextStyle: typography.sm.copyWith(
                color: colorScheme.disable(colorScheme.primary),
                fontWeight: FontWeight.w500,
              ),
              descriptionTextStyle: typography.sm.copyWith(color: colorScheme.disable(colorScheme.mutedForeground)),
            ),
            errorStyle: style.errorStyle.copyWith(
              labelTextStyle: typography.sm.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
              descriptionTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
              errorTextStyle: typography.sm.copyWith(
                color: colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ),
    );
  }
}


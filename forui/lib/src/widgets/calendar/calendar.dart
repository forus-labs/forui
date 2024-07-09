import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

part 'day/day.dart';
part 'day/day_picker.dart';
part 'day/header.dart';
part 'day/paged_day_picker.dart';

final class FCalendarStyle with Diagnosticable {
  final FCalendarHeaderStyle headerStyle;
  final FCalendarDayPickerStyle dayPickerStyle;
  final BoxDecoration decoration;
  final EdgeInsets padding;

  FCalendarStyle({
    required this.headerStyle,
    required this.dayPickerStyle,
    required this.decoration,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
  });

  FCalendarStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) : this(
          headerStyle: FCalendarHeaderStyle.inherit(colorScheme: colorScheme, typography: typography),
          dayPickerStyle: FCalendarDayPickerStyle.inherit(colorScheme: colorScheme, typography: typography),
          decoration: BoxDecoration(
            borderRadius: style.borderRadius,
            border: Border.all(
              color: colorScheme.border,
            ),
          ),
        );
}

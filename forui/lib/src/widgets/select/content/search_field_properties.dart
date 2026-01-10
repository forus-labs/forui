import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forui/forui.dart';

/// The search field's properties.
class FSelectSearchFieldProperties with Diagnosticable {
  /// The search field's default prefix builder that displays a search icon.
  static Widget defaultIconBuilder(BuildContext _, FSelectSearchStyle style, Set<WidgetState> states) => Padding(
    padding: const .directional(start: 10.0, end: 4.0),
    child: IconTheme(data: style.fieldStyle.iconStyle.resolve(states), child: const Icon(FIcons.search)),
  );

  static bool _clearable(TextEditingValue _) => false;

  /// The search field's control.
  final FTextFieldControl control;

  /// {@macro forui.text_field.hint}
  final String? hint;

  /// {@macro forui.text_field.magnifier_configuration}
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// {@macro forui.text_field.keyboardType}
  final TextInputType? keyboardType;

  /// {@macro forui.text_field.textInputAction}
  final TextInputAction? textInputAction;

  /// {@macro forui.text_field.textCapitalization}
  final TextCapitalization textCapitalization;

  /// {@macro forui.text_field.textAlign}
  final TextAlign textAlign;

  /// {@macro forui.text_field.textAlignVertical}
  final TextAlignVertical? textAlignVertical;

  /// {@macro forui.text_field.textDirection}
  final TextDirection? textDirection;

  /// {@macro forui.text_field.autofocus}
  final bool autofocus;

  /// {@macro forui.text_field.autocorrect}
  final bool autocorrect;

  /// {@macro forui.text_field.smartDashesType}
  final SmartDashesType? smartDashesType;

  /// {@macro forui.text_field.smartQuotesType}
  final SmartQuotesType? smartQuotesType;

  /// {@macro forui.text_field.enableSuggestions}
  final bool enableSuggestions;

  /// The minimum number of lines to occupy when the content spans fewer lines.
  ///
  /// This affects the height of the field itself and does not limit the number of lines that can be entered into the field.
  ///
  /// If this is null (default), text container starts with enough vertical space for one line and grows to accommodate
  /// additional lines as they are entered.
  ///
  /// This can be used in combination with [maxLines] for a varying set of behaviors.
  ///
  /// If the value is set, it must be greater than zero. If the value is greater than 1, [maxLines] should also be set
  /// to either null or greater than this value.
  ///
  /// When [maxLines] is set as well, the height will grow between the indicated range of lines. When [maxLines] is null,
  /// it will grow as high as needed, starting from [minLines].
  final int? minLines;

  /// The maximum number of lines to show at one time, wrapping if necessary.
  ///
  /// This affects the height of the field itself and does not limit the number of lines that can be entered into the
  /// field.
  ///
  /// If this is 1 (the default), the text will not wrap, but will scroll horizontally instead.
  ///
  /// If this is null, there is no limit to the number of lines, and the text container will start with enough vertical
  /// space for one line and automatically grow to accommodate additional lines as they are entered, up to the height of
  /// its constraints.
  ///
  /// If this is not null, the value must be greater than zero, and it will lock the input to the given number of lines
  /// and take up enough horizontal space to accommodate that number of lines. Setting [minLines] as well allows the
  /// input to grow and shrink between the indicated range.
  final int? maxLines;

  /// {@macro forui.text_field.readOnly}
  final bool readOnly;

  /// {@macro forui.text_field.showCursor}
  final bool? showCursor;

  /// {@macro forui.text_field.maxLength}
  final int? maxLength;

  /// {@macro forui.text_field.maxLengthEnforcement}
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Called when the text field's value changes.
  final ValueChanged<TextEditingValue>? onChange;

  /// Called for the first tap in a series of taps.
  final GestureTapCallback? onTap;

  /// {@macro forui.text_field.onTapAlwaysCalled}
  final bool onTapAlwaysCalled;

  /// {@macro forui.text_field.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro forui.text_field.onSubmit}
  final ValueChanged<String>? onSubmit;

  /// {@macro forui.text_field.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// {@macro forui.text_field.enabled}
  final bool enabled;

  /// {@macro forui.text_field.ignorePointers}
  final bool? ignorePointers;

  /// {@macro forui.text_field.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro forui.text_field.selectionControls}
  final TextSelectionControls? selectionControls;

  /// {@macro forui.text_field.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro forui.text_field.mouseCursor}
  final MouseCursor? mouseCursor;

  /// {@macro forui.text_field.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro forui.text_field.scrollController}
  final ScrollController? scrollController;

  /// {@macro forui.text_field.autofillHints}
  final Iterable<String>? autofillHints;

  /// {@macro forui.text_field.restorationId}
  final String? restorationId;

  /// {@macro forui.text_field.stylusHandwritingEnabled}
  final bool stylusHandwritingEnabled;

  /// {@macro forui.text_field.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// {@macro forui.text_field.contentInsertionConfiguration}
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// {@macro forui.text_field.contextMenuBuilder}
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// {@macro forui.text_field.undoController}
  final UndoHistoryController? undoController;

  /// {@macro forui.text_field.spellCheckConfiguration}
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// The prefix builder. Defaults to a search icon.
  final FFieldIconBuilder<FSelectSearchStyle>? prefixBuilder;

  /// {@macro forui.text_field.suffixBuilder}
  final FFieldIconBuilder<FSelectSearchStyle>? suffixBuilder;

  /// {@macro forui.text_field.clearable}
  final bool Function(TextEditingValue value) clearable;

  /// Creates a [FSelectSearchFieldProperties].
  const FSelectSearchFieldProperties({
    this.control = const .managed(),
    this.hint,
    this.magnifierConfiguration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = .none,
    this.textAlign = .start,
    this.textAlignVertical,
    this.textDirection,
    this.autofocus = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.minLines,
    this.maxLines = 1,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChange,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onEditingComplete,
    this.onSubmit,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.dragStartBehavior = .start,
    this.mouseCursor,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder,
    this.undoController,
    this.spellCheckConfiguration,
    this.prefixBuilder = defaultIconBuilder,
    this.suffixBuilder,
    this.clearable = _clearable,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty('magnifierConfiguration', magnifierConfiguration))
      ..add(DiagnosticsProperty('keyboardType', keyboardType))
      ..add(EnumProperty('textInputAction', textInputAction))
      ..add(EnumProperty('textCapitalization', textCapitalization))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(FlagProperty('autocorrect', value: autocorrect, ifTrue: 'autocorrect'))
      ..add(EnumProperty('smartDashesType', smartDashesType))
      ..add(EnumProperty('smartQuotesType', smartQuotesType))
      ..add(FlagProperty('enableSuggestions', value: enableSuggestions, ifTrue: 'enableSuggestions'))
      ..add(IntProperty('minLines', minLines))
      ..add(IntProperty('maxLines', maxLines))
      ..add(FlagProperty('readOnly', value: readOnly, ifTrue: 'readOnly'))
      ..add(FlagProperty('showCursor', value: showCursor, ifTrue: 'showCursor'))
      ..add(IntProperty('maxLength', maxLength))
      ..add(EnumProperty('maxLengthEnforcement', maxLengthEnforcement))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(ObjectFlagProperty.has('onTap', onTap))
      ..add(FlagProperty('onTapAlwaysCalled', value: onTapAlwaysCalled, ifTrue: 'onTapAlwaysCalled'))
      ..add(ObjectFlagProperty.has('onEditingComplete', onEditingComplete))
      ..add(ObjectFlagProperty.has('onSubmit', onSubmit))
      ..add(IterableProperty('inputFormatters', inputFormatters))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('ignorePointers', value: ignorePointers, ifTrue: 'ignorePointers'))
      ..add(
        FlagProperty('enableInteractSelection', value: enableInteractiveSelection, ifTrue: 'enableInteractSelection'),
      )
      ..add(DiagnosticsProperty('selectionControls', selectionControls))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(DiagnosticsProperty('scrollPhysics', scrollPhysics))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(IterableProperty('autofillHints', autofillHints))
      ..add(StringProperty('restorationId', restorationId))
      ..add(
        FlagProperty('stylusHandwritingEnabled', value: stylusHandwritingEnabled, ifTrue: 'stylusHandwritingEnabled'),
      )
      ..add(
        FlagProperty(
          'enableIMEPersonalizedLearning',
          value: enableIMEPersonalizedLearning,
          ifTrue: 'enableIMEPersonalizedLearning',
        ),
      )
      ..add(DiagnosticsProperty('contentInsertionConfiguration', contentInsertionConfiguration))
      ..add(ObjectFlagProperty.has('contextMenuBuilder', contextMenuBuilder))
      ..add(DiagnosticsProperty('undoController', undoController))
      ..add(DiagnosticsProperty('spellCheckConfiguration', spellCheckConfiguration))
      ..add(ObjectFlagProperty.has('prefixBuilder', prefixBuilder))
      ..add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder))
      ..add(ObjectFlagProperty.has('clearable', clearable));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

part 'text_field_state.dart';
part 'text_field_style.dart';

/// A text field.
final class FTextField extends StatefulWidget {
  static Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) => AdaptiveTextSelectionToolbar.editableText(editableTextState: editableTextState);

  /// The style.
  final FTextFieldStyle? style;

  /// The text to display when the text field is empty.
  final String? hint;

  /// The configuration for the magnifier of this text field.
  ///
  /// By default, builds a [CupertinoTextMagnifier] on iOS and [TextMagnifier] on Android, and builds nothing on all
  /// other platforms. To suppress the magnifier, consider passing [TextMagnifierConfiguration.disabled].
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Controls the text being edited. If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  ///
  /// See [TextField.focusNode] for more information.
  final FocusNode? focusNode;

  /// The type of keyboard to use for editing the text. Defaults to [TextInputType.text] if maxLines is one and
  /// [TextInputType.multiline] otherwise.
  final TextInputType? keyboardType;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is [TextInputType.multiline] and [TextInputAction.done]
  /// otherwise.
  final TextInputAction? textInputAction;

  /// Configures how the platform keyboard will select an uppercase or lowercase keyboard. Defaults to
  /// [TextCapitalization.none].
  ///
  /// Only supports text keyboards, other keyboard types will ignore this configuration. Capitalization is locale-aware.
  ///
  /// See [TextCapitalization] for a description of each capitalization behavior.
  final TextCapitalization textCapitalization;

  /// How the text should be aligned horizontally.
  ///
  /// Defaults to [TextAlign.start].
  final TextAlign textAlign;

  /// How the text should be aligned vertically.
  ///
  /// See [TextAlignVertical] for more information.
  final TextAlignVertical? textAlignVertical;

  /// The directionality of the text. Defaults to the ambient [Directionality], if any.
  ///
  /// See [TextField.textDirection] for more information.
  final TextDirection? textDirection;

  /// Whether this text field should focus itself if nothing else is already focused. Defaults to false.
  ///
  /// If true, the keyboard will open as soon as this text field obtains focus. Otherwise, the keyboard is only shown
  /// after the user taps the text field.
  final bool autofocus;

  /// Represents the interactive "state" of this widget in terms of a set of [WidgetState]s, including
  /// [WidgetState.disabled], [WidgetState.hovered], [WidgetState.error], and [WidgetState.focused].
  ///
  /// See [TextField.statesController] for more information.
  final WidgetStatesController? statesController;

  /// Whether to hide the text being edited (e.g., for passwords). Defaults to false.
  ///
  /// When this is set to true, all the characters in the text field are obscured, and the text in the field cannot be
  /// copied with copy or cut. If [readOnly] is also true, then the text cannot be selected.
  final bool obscureText;

  /// Whether to enable autocorrection. Defaults to true.
  final bool autocorrect;

  /// Whether to allow the platform to automatically format dashes.
  ///
  /// See [TextField.smartDashesType] for more information.
  final SmartDashesType? smartDashesType;

  /// Whether to allow the platform to automatically format quotes.
  ///
  /// See [TextField.smartQuotesType] for more information.
  final SmartQuotesType? smartQuotesType;

  /// Whether to show input suggestions as the user types. Defaults to true.
  ///
  /// This flag only affects Android. On iOS, suggestions are tied directly to [autocorrect], so that suggestions are
  /// only shown when [autocorrect] is true. On Android autocorrection and suggestion are controlled separately.
  ///
  /// See also:
  ///  * <https://developer.android.com/reference/android/text/InputType.html#TYPE_TEXT_FLAG_NO_SUGGESTIONS>
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
  ///
  /// A few examples of behaviors possible with [minLines] and [maxLines] are as follows. These apply equally to
  /// [TextField], [TextFormField], [CupertinoTextField], and [EditableText].
  ///
  /// Input that always occupies at least 2 lines and has an infinite max. Expands vertically as needed.
  /// ```dart
  /// TextField(minLines: 2)
  /// ```
  ///
  /// Input whose height starts from 2 lines and grows up to 4 lines at which point the height limit is reached.
  /// If additional lines are entered it will scroll vertically.
  /// ```dart
  /// const TextField(minLines:2, maxLines: 4)
  /// ```
  ///
  /// Defaults to null.
  ///
  /// See also:
  ///  * [maxLines], which sets the maximum number of lines visible, and has several examples of how minLines and
  ///    maxLines interact to produce various behaviors.
  ///  * [expands], which determines whether the field should fill the height of its parent.
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
  ///
  /// The full set of behaviors possible with [minLines] and [maxLines] are as follows. These examples apply equally to
  /// [TextField], [TextFormField], [CupertinoTextField], and [EditableText].
  ///
  /// Input that occupies a single line and scrolls horizontally as needed.
  /// ```dart
  /// const TextField()
  /// ```
  ///
  /// Input whose height grows from one line up to as many lines as needed for the text that was entered. If a height
  /// limit is imposed by its parent, it will scroll vertically when its height reaches that limit.
  /// ```dart
  /// const TextField(maxLines: null)
  /// ```
  ///
  /// The input's height is large enough for the given number of lines. If additional lines are entered the input scrolls
  /// vertically.
  /// ```dart
  /// const TextField(maxLines: 2)
  /// ```
  ///
  /// Input whose height grows with content between a min and max. An infinite max is possible with `maxLines: null`.
  /// ```dart
  /// const TextField(minLines: 2, maxLines: 4)
  /// ```
  ///
  /// See also:
  ///  * [minLines], which sets the minimum number of lines visible.
  ///  * [expands], which determines whether the field should fill the height of its parent.
  final int? maxLines;

  /// Whether this widget's height will be sized to fill its parent. Defaults to false.
  ///
  /// If set to true and wrapped in a parent widget like [Expanded] or [SizedBox], the input will expand to fill the
  /// parent.
  ///
  /// [maxLines] and [minLines] must both be null when this is set to true, otherwise an error is thrown.
  ///
  /// See the examples in [maxLines] for the complete picture of how [maxLines], [minLines], and [expands] interact to
  /// produce various behaviors.
  ///
  /// Input that matches the height of its parent:
  /// ```dart
  /// const Expanded(
  ///   child: FTextField(maxLines: null, expands: true),
  /// )
  /// ```
  final bool expands;

  /// Whether the text can be changed. Defaults to false.
  ///
  /// When this is set to true, the text cannot be modified by any shortcut or keyboard operation. The text is still
  /// selectable.
  final bool readOnly;

  /// Whether to show cursor.
  ///
  /// The cursor refers to the blinking caret when this [FTextField] is focused.
  final bool? showCursor;

  /// The maximum number of characters (Unicode grapheme clusters) to allow in the text field.
  ///
  /// If set, a character counter will be displayed below the field showing how many characters have been entered. If
  /// set to a number greater than 0, it will also display the maximum number allowed. If set to [TextField.noMaxLength]
  /// then only the current character count is displayed.
  ///
  /// After [maxLength] characters have been input, additional input is ignored, unless [maxLengthEnforcement] is set to
  /// [MaxLengthEnforcement.none].
  ///
  /// The text field enforces the length with a [LengthLimitingTextInputFormatter], which is evaluated after the supplied
  /// [inputFormatters], if any.
  ///
  /// This value must be either null, [TextField.noMaxLength], or greater than 0. If null (the default) then there is no
  /// limit to the number of characters that can be entered. If set to [TextField.noMaxLength], then no limit will be
  /// enforced, but the number of characters entered will still be displayed.
  ///
  /// Whitespace characters (e.g. newline, space, tab) are included in the character count.
  ///
  /// If [maxLengthEnforcement] is [MaxLengthEnforcement.none], then more than [maxLength] characters may be entered,
  /// but the error counter and divider will switch to the [style]'s [FTextFieldStyle.error] when the limit is exceeded.
  final int? maxLength;

  /// Determines how the [maxLength] limit should be enforced.
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Called when the user initiates a change to the TextField's value: when they have inserted or deleted text.
  ///
  /// This callback doesn't run when the TextField's text is changed programmatically, via the TextField's [controller].
  /// Typically it isn't necessary to be notified of such changes, since they're initiated by the app itself.
  ///
  /// To be notified of all changes to the TextField's text, cursor, and selection, one can add a listener to its
  /// [controller] with [TextEditingController.addListener].
  ///
  /// [onChange] is called before [onSubmit] when user indicates completion of editing, such as when pressing the "done"
  /// button on the keyboard. That default behavior can be overridden. See [onEditingComplete] for details.
  ///
  /// See also:
  ///  * [inputFormatters], which are called before [onChange] runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmit]: which are more specialized input change notifications.
  final ValueChanged<String>? onChange;

  /// Called when the user submits editable content (e.g., user presses the "done" button on the keyboard).
  ///
  /// The default implementation of [onEditingComplete] executes 2 different behaviors based on the situation:
  ///
  ///  - When a completion action is pressed, such as "done", "go", "send", or "search", the user's content is submitted
  ///    to the [controller] and then focus is given up.
  ///
  ///  - When a non-completion action is pressed, such as "next" or "previous", the user's content is submitted to the
  ///    [controller], but focus is not given up because developers may want to immediately move focus to another input
  ///    widget within [onSubmit].
  ///
  /// Providing [onEditingComplete] prevents the aforementioned default behavior.
  final VoidCallback? onEditingComplete;

  /// Called when the user indicates that they are done editing the text in the field.
  ///
  /// By default, [onSubmit] is called after [onChange] when the user has finalized editing; or, if the default behavior
  /// has been overridden, after [onEditingComplete]. See [onEditingComplete] for details.
  ///
  /// ## Testing
  /// The following is the recommended way to trigger [onSubmit] in a test:
  ///
  /// ```dart
  /// await tester.testTextInput.receiveAction(TextInputAction.done);
  /// ```
  ///
  /// Sending a `LogicalKeyboardKey.enter` via `tester.sendKeyEvent` will not trigger [onSubmit]. This is because on a
  /// real device, the engine translates the enter key to a done action, but `tester.sendKeyEvent` sends the key to the
  /// framework only.
  final ValueChanged<String>? onSubmit;

  /// This is used to receive a private command from the input method.
  ///
  /// Called when the result of [TextInputClient.performPrivateCommand] is received.
  ///
  /// This can be used to provide domain-specific features that are only known between certain input methods and their
  /// clients.
  ///
  /// See also:
  ///   * [performPrivateCommand](https://developer.android.com/reference/android/view/inputmethod/InputConnection#performPrivateCommand\(java.lang.String,%20android.os.Bundle\)),
  ///     which is the Android documentation for performPrivateCommand, used to send a command from the input method.
  ///   * [sendAppPrivateCommand](https://developer.android.com/reference/android/view/inputmethod/InputMethodManager#sendAppPrivateCommand),
  ///     which is the Android documentation for sendAppPrivateCommand, used to send a command to the input method.
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// Optional input validation and formatting overrides.
  ///
  /// Formatters are run in the provided order when the user changes the text this widget contains. When this parameter
  /// changes, the new formatters will not be applied until the next time the user inserts or deletes text. Similar to
  /// the [onChange] callback, formatters don't run when the text is changed programmatically via [controller].
  ///
  /// See also:
  ///  * [TextEditingController], which implements the [Listenable] interface and notifies its listeners on
  ///    [TextEditingValue] changes.
  final List<TextInputFormatter>? inputFormatters;

  /// If false the text field is "disabled": it ignores taps. Defaults to true.
  final bool enabled;

  /// Determines whether this widget ignores pointer events. Defaults to null, and when null, does nothing.
  final bool? ignorePointers;

  /// Whether to enable user interface affordances for changing the text selection. Defaults to true.
  ///
  /// For example, setting this to true will enable features such as long-pressing the TextField to select text and show
  /// the cut/copy/paste menu, and tapping to move the text caret.
  ///
  /// When this is false, the text selection cannot be adjusted by the user, text cannot be copied, and the user cannot
  /// paste into the text field from the clipboard.
  final bool enableInteractSelection;

  /// Optional delegate for building the text selection handles.
  ///
  /// Historically, this field also controlled the toolbar. This is now handled by [contextMenuBuilder] instead. However,
  /// for backwards compatibility, when [selectionControls] is set to an object that does not mix in
  // ignore: deprecated_member_use
  /// [TextSelectionHandleControls], [contextMenuBuilder] is ignored and the [TextSelectionControls.buildToolbar] method
  /// is used instead.
  final TextSelectionControls? selectionControls;

  /// Determines the way that drag start behavior is handled. By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// If set to [DragStartBehavior.start], scrolling drag behavior will begin at the position where the drag gesture won
  /// the arena. If set to [DragStartBehavior.down] it will begin at the position where a down event is first detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag animation smoother and setting it to
  /// [DragStartBehavior.down] will make drag behavior feel slightly more reactive.
  ///
  /// See also:
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for the different behaviors.
  final DragStartBehavior dragStartBehavior;

  // TODO: MouseCursor? mouseCursor;

  // TODO: InputCounterWidgetBuilder? buildCounter;

  /// The [ScrollPhysics] to use when vertically scrolling the input. If not specified, it will behave according to the
  /// current platform.
  ///
  /// See [Scrollable.physics].
  final ScrollPhysics? scrollPhysics;

  /// The [ScrollController] to use when vertically scrolling the input. If null, it will instantiate a new ScrollController.
  ///
  /// See [Scrollable.controller].
  final ScrollController? scrollController;

  /// A list of strings that helps the autofill service identify the type of this text input.
  ///
  /// See [TextField.autofillHints] for more information.
  final Iterable<String>? autofillHints;

  /// Restoration ID to save and restore the state of the text field.
  ///
  /// See [TextField.restorationId] for more information.
  final String? restorationId;

  /// Whether iOS 14 Scribble features are enabled for this widget. Defaults to true.
  ///
  /// Only available on iPads.
  final bool scribbleEnabled;

  /// Whether to enable that the IME update personalized data such as typing history and user dictionary data.
  ///
  /// See [TextField.enableIMEPersonalizedLearning] for more information.
  final bool enableIMEPersonalizedLearning;

  // TODO: ContentInsertionConfiguration? contentInsertionConfiguration

  /// Builds the text selection toolbar when requested by the user.
  ///
  /// See [TextField.contextMenuBuilder] for more information.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Determine whether this text field can request the primary focus.
  ///
  /// Defaults to true. If false, the text field will not request focus when tapped, or when its context menu is
  /// displayed. If false it will not be possible to move the focus to the text field with tab key.
  final bool canRequestFocus;

  /// Controls the undo state.
  ///
  /// If null, this widget will create its own [UndoHistoryController].
  final UndoHistoryController? undoController;

  /// Configuration that details how spell check should be performed.
  ///
  /// Specifies the [SpellCheckService] used to spell check text input and the [TextStyle] used to style text with
  /// misspelled words.
  ///
  /// If the [SpellCheckService] is left null, spell check is disabled by default unless the [DefaultSpellCheckService]
  /// is supported, in which case it is used. It is currently supported only on Android and iOS.
  ///
  /// If this configuration is left null, then spell check is disabled by default.
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// The label.
  final String? label;

  /// The suffix icon.
  ///
  /// See [InputDecoration.suffixIcon] for more information.
  final Widget? suffixIcon;

  /// Creates a [FTextField].
  const FTextField({
    this.style,
    this.hint,
    this.magnifierConfiguration,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.autofocus = false,
    this.statesController,
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.minLines,
    this.maxLines,
    this.expands = false,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChange,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.label,
    this.suffixIcon,
  });

  /// Creates a [FTextField] configured for passwords.
  ///
  /// [autofillHints] defaults to [AutofillHints.password]. It should be overridden with [AutofillHints.newPassword]
  /// when handling the creation of new passwords.
  const FTextField.password({
    this.style,
    this.hint,
    this.magnifierConfiguration,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.autofocus = false,
    this.statesController,
    this.obscureText = true,
    this.autocorrect = false,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.minLines,
    this.maxLines = 1,
    this.expands = false,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChange,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints = const [AutofillHints.password],
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.label,
    this.suffixIcon,
  });

  /// Creates a [FTextField] configured for multiline inputs.
  const FTextField.multiline({
    this.style,
    this.hint,
    this.magnifierConfiguration,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.sentences,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.autofocus = false,
    this.statesController,
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.minLines = 4,
    this.maxLines,
    this.expands = false,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChange,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.label,
    this.suffixIcon,
  });

  @override
  State<FTextField> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('hintText', hint))
      ..add(DiagnosticsProperty('magnifierConfiguration', magnifierConfiguration))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(DiagnosticsProperty('keyboardType', keyboardType))
      ..add(EnumProperty('textInputAction', textInputAction))
      ..add(EnumProperty('textCapitalization', textCapitalization))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('statesController', statesController))
      ..add(FlagProperty('obscureText', value: obscureText, ifTrue: 'obscureText'))
      ..add(FlagProperty('autocorrect', value: autocorrect, ifTrue: 'autocorrect'))
      ..add(EnumProperty('smartDashesType', smartDashesType))
      ..add(EnumProperty('smartQuotesType', smartQuotesType))
      ..add(FlagProperty('enableSuggestions', value: enableSuggestions, ifTrue: 'enableSuggestions'))
      ..add(IntProperty('minLines', minLines))
      ..add(IntProperty('maxLines', maxLines))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(FlagProperty('readOnly', value: readOnly, ifTrue: 'readOnly'))
      ..add(FlagProperty('showCursor', value: showCursor, ifTrue: 'showCursor'))
      ..add(IntProperty('maxLength', maxLength))
      ..add(EnumProperty('maxLengthEnforcement', maxLengthEnforcement))
      ..add(DiagnosticsProperty('onChange', onChange))
      ..add(DiagnosticsProperty('onEditingComplete', onEditingComplete))
      ..add(DiagnosticsProperty('onSubmit', onSubmit))
      ..add(DiagnosticsProperty('onAppPrivateCommand', onAppPrivateCommand))
      ..add(IterableProperty('inputFormatters', inputFormatters))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('ignorePointers', value: ignorePointers, ifTrue: 'ignorePointers'))
      ..add(FlagProperty('enableInteractSelection', value: enableInteractSelection, ifTrue: 'enableInteractSelection'))
      ..add(DiagnosticsProperty('selectionControls', selectionControls))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('scrollPhysics', scrollPhysics))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(IterableProperty('autofillHints', autofillHints))
      ..add(StringProperty('restorationId', restorationId))
      ..add(FlagProperty('scribbleEnabled', value: scribbleEnabled, ifTrue: 'scribbleEnabled'))
      ..add(FlagProperty('enableIMEPersonalizedLearning', value: enableIMEPersonalizedLearning, ifTrue: 'enableIMEPersonalizedLearning'))
      ..add(DiagnosticsProperty('contextMenuBuilder', contextMenuBuilder))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(DiagnosticsProperty('undoController', undoController))
      ..add(DiagnosticsProperty('spellCheckConfiguration', spellCheckConfiguration));
  }
}

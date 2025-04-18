import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/text_field/field.dart';

/// The [FTextField.counterBuilder] callback.
///
/// [currentLength] represents the length of the text field's input.
/// [maxLength] represents the maximum length of the text field's input.
/// [focused] represents whether the text field is currently focused.
typedef FTextFieldCounterBuilder =
    Widget? Function(
      BuildContext context,
      int currentLength,
      int? maxLength,
      // ignore: avoid_positional_boolean_parameters
      bool focused,
    );

/// A text field.
///
/// It lets the user enter text, either with a hardware keyboard or with an onscreen keyboard. A [FTextField] is
/// internally a [FormField], therefore it can be used in a [Form].
///
/// See:
/// * https://forui.dev/docs/form/text-field for working examples.
/// * [FTextFieldStyle] for customizing a text field's appearance.
/// * [TextField] for more details about working with a text field.
final class FTextField extends StatelessWidget with FFormFieldProperties<String> {
  static Widget _contextMenuBuilder(BuildContext _, EditableTextState state) =>
      AdaptiveTextSelectionToolbar.editableText(editableTextState: state);

  static Widget _fieldBuilder(BuildContext _, (FTextFieldStyle, Set<WidgetState>) _, Widget? child) => child!;

  static Widget _errorBuilder(BuildContext _, String text) => Text(text);

  static bool _clearable(TextEditingValue _) => false;

  /// {@template forui.text_field.style}
  /// The text field's style. Defaults to [FThemeData.textFieldStyle].
  /// {@endtemplate}
  final FTextFieldStyle? style;

  /// {@template forui.text_field.builder}
  /// The builder used to decorate the text-field. It should use the given child.
  ///
  /// Defaults to returning the given child.
  /// {@endtemplate}
  final ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)> builder;

  /// {@template forui.text_field.errorBuilder}
  /// A builder that creates a widget to display validation errors.
  /// {@endtemplate}
  @override
  final Widget? label;

  /// {@template forui.text_field.hint}
  /// The text to display when the text field is empty.
  ///
  /// See [InputDecoration.hintText] for more information.
  /// {@endtemplate}
  final String? hint;

  /// {@template forui.text_field.description}
  /// The description text.
  ///
  /// See [InputDecoration.helper] for more information.
  /// {@endtemplate}
  @override
  final Widget? description;

  /// {@template forui.text_field.magnifier_configuration}
  /// The configuration for the magnifier of this text field.
  ///
  /// By default, builds a [CupertinoTextMagnifier] on iOS and [TextMagnifier] on Android, and builds nothing on all
  /// other platforms. To suppress the magnifier, consider passing [TextMagnifierConfiguration.disabled].
  /// {@endtemplate}
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// {@template forui.text_field.controller}
  /// Controls the text being edited. If null, this widget will create its own [TextEditingController].
  /// {@endtemplate}
  final TextEditingController? controller;

  /// {@template forui.text_field.keyboardType}
  /// The type of keyboard to use for editing the text. Defaults to [TextInputType.text] if maxLines is one and
  /// [TextInputType.multiline] otherwise.
  /// {@endtemplate}
  final TextInputType? keyboardType;

  /// {@template forui.text_field.textInputAction}
  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is [TextInputType.multiline] and [TextInputAction.done]
  /// otherwise.
  /// {@endtemplate}
  final TextInputAction? textInputAction;

  /// {@template forui.text_field.textCapitalization}
  /// Configures how the platform keyboard will select an uppercase or lowercase keyboard. Defaults to
  /// [TextCapitalization.none].
  ///
  /// Only supports text keyboards, other keyboard types will ignore this configuration. Capitalization is locale-aware.
  ///
  /// See [TextCapitalization] for a description of each capitalization behavior.
  /// {@endtemplate}
  final TextCapitalization textCapitalization;

  /// {@template forui.text_field.textAlign}
  /// How the text should be aligned horizontally.
  ///
  /// Defaults to [TextAlign.start].
  /// {@endtemplate}
  final TextAlign textAlign;

  /// {@template forui.text_field.textAlignVertical}
  /// How the text should be aligned vertically.
  ///
  /// See [TextAlignVertical] for more information.
  /// {@endtemplate}
  final TextAlignVertical? textAlignVertical;

  /// {@template forui.text_field.textDirection}
  /// The directionality of the text. Defaults to the ambient [Directionality], if any.
  ///
  /// See [TextField.textDirection] for more information.
  /// {@endtemplate}
  final TextDirection? textDirection;

  /// {@template forui.text_field.autofocus}
  /// Whether this text field should focus itself if nothing else is already focused. Defaults to false.
  ///
  /// If true, the keyboard will open as soon as this text field obtains focus. Otherwise, the keyboard is only shown
  /// after the user taps the text field.
  /// {@endtemplate}
  final bool autofocus;

  /// {@template forui.text_field.focusNode}
  /// Defines the keyboard focus for this [FTextField].
  ///
  /// See [TextField.focusNode] for more information.
  /// {@endtemplate}
  final FocusNode? focusNode;

  /// {@template forui.text_field.statesController}
  /// Represents the interactive "state" of this widget in terms of a set of [WidgetState]s, including
  /// [WidgetState.disabled], [WidgetState.hovered], [WidgetState.error], and [WidgetState.focused].
  ///
  /// See [TextField.statesController] for more information.
  /// {@endtemplate}
  final WidgetStatesController? statesController;

  /// {@template forui.text_field.obscuringCharacter}
  /// Character used for obscuring text if [obscureText] is true.
  ///
  /// Must be only a single character.
  ///
  /// Defaults to the character U+2022 BULLET (•).
  /// {@endtemplate}
  final String obscuringCharacter;

  /// {@template forui.text_field.obscureText}
  /// Whether to hide the text being edited (e.g., for passwords). Defaults to false.
  ///
  /// When this is set to true, all the characters in the text field are obscured, and the text in the field cannot be
  /// copied with copy or cut. If [readOnly] is also true, then the text cannot be selected.
  /// {@endtemplate}
  final bool obscureText;

  /// {@template forui.text_field.autocorrect}
  /// Whether to enable autocorrection. Defaults to true.
  /// {@endtemplate}
  final bool autocorrect;

  /// {@template forui.text_field.smartDashesType}
  /// Whether to allow the platform to automatically format dashes.
  ///
  /// See [TextField.smartDashesType] for more information.
  /// {@endtemplate}
  final SmartDashesType? smartDashesType;

  /// {@template forui.text_field.smartQuotesType}
  /// Whether to allow the platform to automatically format quotes.
  ///
  /// See [TextField.smartQuotesType] for more information.
  /// {@endtemplate}
  final SmartQuotesType? smartQuotesType;

  /// {@template forui.text_field.enableSuggestions}
  /// Whether to show input suggestions as the user types. Defaults to true.
  ///
  /// This flag only affects Android. On iOS, suggestions are tied directly to [autocorrect], so that suggestions are
  /// only shown when [autocorrect] is true. On Android autocorrection and suggestion are controlled separately.
  ///
  /// See also:
  ///  * <https://developer.android.com/reference/android/text/InputType.html#TYPE_TEXT_FLAG_NO_SUGGESTIONS>
  /// {@endtemplate}
  final bool enableSuggestions;

  /// {@template forui.text_field.minLines}
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
  /// Defaults to null.
  ///
  /// See also:
  ///  * [maxLines], which sets the maximum number of lines visible, and has several examples of how minLines and
  ///    maxLines interact to produce various behaviors.
  ///  * [expands], which determines whether the field should fill the height of its parent.
  /// {@endtemplate}
  final int? minLines;

  /// {@template forui.text_field.maxLines}
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
  /// See also:
  ///  * [minLines], which sets the minimum number of lines visible.
  ///  * [expands], which determines whether the field should fill the height of its parent.
  /// {@endtemplate}
  final int? maxLines;

  /// {@template forui.text_field.expands}
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
  /// {@endtemplate}
  final bool expands;

  /// {@template forui.text_field.readOnly}
  /// Whether the text can be changed. Defaults to false.
  ///
  /// When this is set to true, the text cannot be modified by any shortcut or keyboard operation. The text is still
  /// selectable.
  /// {@endtemplate}
  final bool readOnly;

  /// {@template forui.text_field.showCursor}
  /// Whether to show cursor.
  ///
  /// The cursor refers to the blinking caret when this [FTextField] is focused.
  /// {@endtemplate}
  final bool? showCursor;

  /// {@template forui.text_field.maxLength}
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
  /// but the error counter and divider will switch to the [style]'s error style when the limit is exceeded.
  /// {@endtemplate}
  final int? maxLength;

  /// {@template forui.text_field.maxLengthEnforcement}
  /// Determines how the [maxLength] limit should be enforced.
  /// {@endtemplate}
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// {@template forui.text_field.onChange}
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
  /// {@endtemplate}
  final ValueChanged<String>? onChange;

  /// {@template forui.text_field.onTap}
  /// Called for the first tap in a series of taps.
  ///
  /// The text field builds a [GestureDetector] to handle input events like tap, to trigger focus requests, to move the
  /// caret, adjust the selection, etc. Handling some of those events by wrapping the text field with a competing
  /// GestureDetector is problematic.
  ///
  /// To unconditionally handle taps, without interfering with the text field's internal gesture detector, provide this
  /// callback.
  ///
  /// If the text field is created with [enabled] false, taps will not be recognized.
  ///
  /// To be notified when the text field gains or loses the focus, provide a [focusNode] and add a listener to that.
  ///
  /// To listen to arbitrary pointer events without competing with the text field's internal gesture detector, use a
  /// [Listener].
  ///
  /// If [onTapAlwaysCalled] is enabled, this will also be called for consecutive taps.
  /// {@endtemplate}
  final GestureTapCallback? onTap;

  /// {@template forui.text_field.onTapAlwaysCalled}
  /// Whether [onTap] should be called for every tap.
  ///
  /// Defaults to false, so [onTap] is only called for each distinct tap. When enabled, [onTap] is called for every tap
  /// including consecutive taps.
  /// {@endtemplate}
  final bool onTapAlwaysCalled;

  /// {@template forui.text_field.onEditingComplete}
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
  /// {@endtemplate}
  final VoidCallback? onEditingComplete;

  /// {@template forui.text_field.onSubmit}
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
  /// {@endtemplate}
  final ValueChanged<String>? onSubmit;

  /// {@template forui.text_field.onAppPrivateCommand}
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
  /// {@endtemplate}
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// {@template forui.text_field.inputFormatters}
  /// Optional input validation and formatting overrides.
  ///
  /// Formatters are run in the provided order when the user changes the text this widget contains. When this parameter
  /// changes, the new formatters will not be applied until the next time the user inserts or deletes text. Similar to
  /// the [onChange] callback, formatters don't run when the text is changed programmatically via [controller].
  ///
  /// See also:
  ///  * [TextEditingController], which implements the [Listenable] interface and notifies its listeners on
  ///    [TextEditingValue] changes.
  /// {@endtemplate}
  final List<TextInputFormatter>? inputFormatters;

  /// {@template forui.text_field.enabled}
  /// If false the text field is "disabled": it ignores taps. Defaults to true.
  /// {@endtemplate}
  @override
  final bool enabled;

  /// {@template forui.text_field.ignorePointers}
  /// Determines whether this widget ignores pointer events. Defaults to null, and when null, does nothing.
  /// {@endtemplate}
  final bool? ignorePointers;

  /// {@template forui.text_field.enableInteractiveSelection}
  /// Whether to enable user interface affordances for changing the text selection. Defaults to true.
  ///
  /// For example, setting this to true will enable features such as long-pressing the TextField to select text and show
  /// the cut/copy/paste menu, and tapping to move the text caret.
  ///
  /// When this is false, the text selection cannot be adjusted by the user, text cannot be copied, and the user cannot
  /// paste into the text field from the clipboard.
  /// {@endtemplate}
  final bool enableInteractiveSelection;

  /// {@template forui.text_field.selectionControls}
  /// Optional delegate for building the text selection handles.
  ///
  /// Historically, this field also controlled the toolbar. This is now handled by [contextMenuBuilder] instead. However,
  /// for backwards compatibility, when [selectionControls] is set to an object that does not mix in
  // ignore: deprecated_member_use
  /// [TextSelectionHandleControls], [contextMenuBuilder] is ignored and the [TextSelectionControls.buildToolbar] method
  /// is used instead.
  /// {@endtemplate}
  final TextSelectionControls? selectionControls;

  /// {@template forui.text_field.dragStartBehavior}
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
  /// {@endtemplate}
  final DragStartBehavior dragStartBehavior;

  /// {@template forui.text_field.mouseCursor}
  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  /// {@endtemplate}
  final MouseCursor? mouseCursor;

  /// {@template forui.text_field.counterBuilder}
  /// The [FTextFieldCounterBuilder] used to build a custom counter for the text field.
  ///
  /// The returned widget will be wrapped in a Semantics widget for accessibility, but it also needs to be accessible
  /// itself. For example, if returning a [Text] widget, set the [Text.semanticsLabel] property.
  /// {@endtemplate}
  final FTextFieldCounterBuilder? counterBuilder;

  /// {@template forui.text_field.scrollPhysics}
  /// The [ScrollPhysics] to use when vertically scrolling the input. If not specified, it will behave according to the
  /// current platform.
  ///
  /// See [Scrollable.physics].
  /// {@endtemplate}
  final ScrollPhysics? scrollPhysics;

  /// {@template forui.text_field.scrollController}
  /// The [ScrollController] to use when vertically scrolling the input. If null, it will instantiate a new ScrollController.
  ///
  /// See [Scrollable.controller].
  /// {@endtemplate}
  final ScrollController? scrollController;

  /// {@template forui.text_field.autofillHints}
  /// A list of strings that helps the autofill service identify the type of this text input.
  ///
  /// See [TextField.autofillHints] for more information.
  /// {@endtemplate}
  final Iterable<String>? autofillHints;

  /// {@template forui.text_field.restorationId}
  /// Restoration ID to save and restore the state of the text field.
  ///
  /// See [TextField.restorationId] for more information.
  /// {@endtemplate}
  final String? restorationId;

  /// {@template forui.text_field.stylusHandwritingEnabled}
  /// Whether this input supports stylus handwriting, where the user can write directly on top of a field.
  ///
  /// Currently only the following devices are supported:
  ///
  ///  * iPads running iOS 14 and above using an Apple Pencil.
  ///  * Android devices running API 34 and above and using an active stylus.
  ///
  /// On Android, Scribe gestures are detected outside of [EditableText], typically by
  /// [TextSelectionGestureDetectorBuilder]. This is handled automatically in [FTextField].
  ///
  /// See also:
  ///   * [ScribbleClient], which can be mixed into an arbitrary widget to provide iOS Scribble functionality.
  ///   * [Scribe], which can be used to interact with Android Scribe directly.
  /// {@endtemplate}
  final bool stylusHandwritingEnabled;

  /// {@template forui.text_field.enableIMEPersonalizedLearning}
  /// Whether to enable that the IME update personalized data such as typing history and user dictionary data.
  ///
  /// See [TextField.enableIMEPersonalizedLearning] for more information.
  /// {@endtemplate}
  final bool enableIMEPersonalizedLearning;

  /// {@template forui.text_field.contentInsertionConfiguration}
  /// Configuration of handler for media content inserted via the system input method.
  ///
  /// Defaults to null in which case media content insertion will be disabled, and the system will display a message
  /// informing the user that the text field
  /// does not support inserting media content.
  ///
  /// Set [ContentInsertionConfiguration.onContentInserted] to provide a handler. Additionally,
  /// set [ContentInsertionConfiguration.allowedMimeTypes] to limit the allowable mime types for inserted content.
  ///
  /// If [contentInsertionConfiguration] is not provided, by default an empty list of mime types will be sent to the
  /// Flutter Engine. A handler function must be provided in order to customize the allowable mime types for inserted
  /// content.
  ///
  /// If rich content is inserted without a handler, the system will display a message informing the user that the
  /// current text input does not support inserting rich content.
  /// {@endtemplate}
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// {@template forui.text_field.contextMenuBuilder}
  /// Builds the text selection toolbar when requested by the user.
  ///
  /// See [TextField.contextMenuBuilder] for more information.
  /// {@endtemplate}
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// {@template forui.text_field.canRequestFocus}
  /// Determine whether this text field can request the primary focus.
  ///
  /// Defaults to true. If false, the text field will not request focus when tapped, or when its context menu is
  /// displayed. If false it will not be possible to move the focus to the text field with tab key.
  /// {@endtemplate}
  final bool canRequestFocus;

  /// {@template forui.text_field.undoController}
  /// Controls the undo state.
  ///
  /// If null, this widget will create its own [UndoHistoryController].
  /// {@endtemplate}
  final UndoHistoryController? undoController;

  /// {@template forui.text_field.spellCheckConfiguration}
  /// Configuration that details how spell check should be performed.
  ///
  /// Specifies the [SpellCheckService] used to spell check text input and the [TextStyle] used to style text with
  /// misspelled words.
  ///
  /// If the [SpellCheckService] is left null, spell check is disabled by default unless the [DefaultSpellCheckService]
  /// is supported, in which case it is used. It is currently supported only on Android and iOS.
  ///
  /// If this configuration is left null, then spell check is disabled by default.
  /// {@endtemplate}
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// {@template forui.text_field.prefixBuilder}
  /// The prefix's builder.
  ///
  /// See [InputDecoration.prefixIcon] for more information.
  /// {@endtemplate}
  final ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>? prefixBuilder;

  /// {@template forui.text_field.suffixBuilder}
  /// The suffix's builder.
  ///
  /// See [InputDecoration.suffixIcon] for more information.
  /// {@endtemplate}
  final ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>? suffixBuilder;

  /// {@template forui.text_field.clearable}
  /// A predicate that returns true if a clear icon should be shown at the end when the text field is not empty.
  ///
  /// It is never shown when the text field is disabled.
  ///
  /// Defaults to always returning false.
  /// {@endtemplate}
  final bool Function(TextEditingValue) clearable;

  @override
  final FormFieldSetter<String>? onSaved;

  @override
  final FormFieldValidator<String>? validator;

  /// {@template forui.text_field.initialValue}
  /// An optional value to initialize the form field to, or null otherwise.
  /// {@endtemplate}
  final String? initialValue;

  @override
  final AutovalidateMode autovalidateMode;

  @override
  final String? forceErrorText;

  @override
  final Widget Function(BuildContext, String) errorBuilder;

  /// {@template f_text_field.floating_label_alignment}
  /// The alignment of the label. Defaults to [AlignmentDirectional.topStart].
  /// {@endtemplate}
  final AlignmentGeometry? floatingLabelAlignment;

  /// {@template f_text_field.floating_label_behavior}
  /// The width value interval for the text span. Defaults to FloatingLabelWidth.sufficient
  /// {@endtemplate}
  final FloatingLabelBehavior? floatingLabelBehavior;

  /// Creates a [FTextField].
  const FTextField({
    this.style,
    this.builder = _fieldBuilder,
    this.label,
    this.hint,
    this.description,
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
    this.obscuringCharacter = '•',
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
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.counterBuilder,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder = _contextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.prefixBuilder,
    this.suffixBuilder,
    this.clearable = _clearable,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.forceErrorText,
    this.errorBuilder = _errorBuilder,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    super.key,
  }) : assert(
         initialValue == null || controller == null,
         'Cannot provide both an initial value and a controller. '
         'If you want to use a controller, set its initial value directly on the controller.',
       );

  /// Creates a [FTextField] configured for emails.
  const FTextField.email({
    this.style,
    this.builder = _fieldBuilder,
    this.label = const Text('Email'),
    this.hint,
    this.description,
    this.magnifierConfiguration,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.emailAddress,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.autofocus = false,
    this.statesController,
    this.obscuringCharacter = '•',
    this.obscureText = false,
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
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.counterBuilder,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints = const [AutofillHints.email],
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder = _contextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.prefixBuilder,
    this.suffixBuilder,
    this.clearable = _clearable,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.forceErrorText,
    this.errorBuilder = _errorBuilder,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    super.key,
  }) : assert(
         initialValue == null || controller == null,
         'Cannot provide both an initial value and a controller. '
         'If you want to use a controller, set its initial value directly on the controller.',
       );

  /// Creates a [FTextField] configured for passwords.
  ///
  /// [autofillHints] defaults to [AutofillHints.password]. It should be overridden with [AutofillHints.newPassword]
  /// when handling the creation of new passwords.
  const FTextField.password({
    this.style,
    this.builder = _fieldBuilder,
    this.label = const Text('Password'),
    this.hint,
    this.description,
    this.magnifierConfiguration,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.autofocus = false,
    this.statesController,
    this.obscuringCharacter = '•',
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
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.counterBuilder,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints = const [AutofillHints.password],
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder = _contextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.prefixBuilder,
    this.suffixBuilder,
    this.clearable = _clearable,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.forceErrorText,
    this.errorBuilder = _errorBuilder,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    super.key,
  }) : assert(
         initialValue == null || controller == null,
         'Cannot provide both an initial value and a controller. '
         'If you want to use a controller, set its initial value directly on the controller.',
       );

  /// Creates a [FTextField] configured for multiline inputs.
  ///
  /// The text field's height can be configured by adjusting [minLines]. By default, the text field will expand every
  /// time a new line is added. To limit the maximum height of the text field and make it scrollable, consider setting
  /// [maxLines].
  const FTextField.multiline({
    this.style,
    this.builder = _fieldBuilder,
    this.label,
    this.hint,
    this.description,
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
    this.obscuringCharacter = '•',
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
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.counterBuilder,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder = _contextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.prefixBuilder,
    this.suffixBuilder,
    this.clearable = _clearable,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.forceErrorText,
    this.errorBuilder = _errorBuilder,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    super.key,
  }) : assert(
         initialValue == null || controller == null,
         'Cannot provide both an initial value and a controller. '
         'If you want to use a controller, set its initial value directly on the controller.',
       );

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = this.style ?? theme.textFieldStyle;

    final textFormField = MergeSemantics(
      child: Material(
        color: Colors.transparent,
        child: Theme(
          // The selection colors are defined in a Theme instead of TextField since TextField does not expose parameters
          // for overriding selectionHandleColor.
          data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: style.cursorColor,
              selectionColor: style.cursorColor.withValues(alpha: 0.4),
              selectionHandleColor: style.cursorColor,
            ),
          ),
          child: CupertinoTheme(
            // Theme.cupertinoOverrideTheme cannot be used because of https://github.com/flutter/flutter/issues/161573.
            data: CupertinoTheme.of(context).copyWith(primaryColor: style.cursorColor),
            child: Field(parent: this, style: style, key: key),
          ),
        ),
      ),
    );

    final materialLocalizations = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
    return materialLocalizations == null
        ? Localizations(
          locale: Localizations.maybeLocaleOf(context) ?? const Locale('en', 'US'),
          delegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          child: textFormField,
        )
        : textFormField;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(StringProperty('hint', hint))
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
      ..add(StringProperty('obscuringCharacter', obscuringCharacter, defaultValue: '•'))
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
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(ObjectFlagProperty.has('onTap', onTap))
      ..add(FlagProperty('onTapAlwaysCalled', value: onTapAlwaysCalled, ifTrue: 'onTapAlwaysCalled'))
      ..add(ObjectFlagProperty.has('onEditingComplete', onEditingComplete))
      ..add(ObjectFlagProperty.has('onSubmit', onSubmit))
      ..add(ObjectFlagProperty.has('onAppPrivateCommand', onAppPrivateCommand))
      ..add(IterableProperty('inputFormatters', inputFormatters))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('ignorePointers', value: ignorePointers, ifTrue: 'ignorePointers'))
      ..add(
        FlagProperty('enableInteractSelection', value: enableInteractiveSelection, ifTrue: 'enableInteractSelection'),
      )
      ..add(DiagnosticsProperty('selectionControls', selectionControls))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(ObjectFlagProperty.has('buildCounter', counterBuilder))
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
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(DiagnosticsProperty('undoController', undoController))
      ..add(DiagnosticsProperty('spellCheckConfiguration', spellCheckConfiguration))
      ..add(ObjectFlagProperty.has('prefixBuilder', prefixBuilder))
      ..add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder))
      ..add(ObjectFlagProperty.has('clearable', clearable))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(StringProperty('initialValue', initialValue))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(DiagnosticsProperty('floatingLabelAlignment', floatingLabelAlignment))
      ..add(EnumProperty('floatingLabelBehavior', floatingLabelBehavior));
  }
}

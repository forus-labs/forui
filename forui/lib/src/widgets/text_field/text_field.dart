import 'package:flutter/cupertino.dart' show CupertinoTextMagnifier;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/localizations/localized_text.dart';
import 'package:forui/src/widgets/text_field/input/input.dart';
import 'package:forui/src/widgets/text_field/password_field.dart';
import 'package:forui/src/widgets/text_field/text_field_control.dart';

/// A callback for building a custom counter for a text field.
///
/// [currentLength] is the length of the text field's input.
/// [maxLength] is the maximum length of the text field's input.
/// [focused] is whether the text field is currently focused.
///
/// See [FTextField.counterBuilder].
typedef FTextFieldCounterBuilder =
    // ignore: avoid_positional_boolean_parameters
    Widget? Function(BuildContext context, int currentLength, int? maxLength, bool focused);

/// A callback for decorating a field. It should always use the given field.
///
/// [style] is the field's style.
/// [states] is the current states of the widget.
/// [field] is the field that will be decorated.
///
/// See [FTextField.builder].
typedef FFieldBuilder<T> = Widget Function(BuildContext context, T style, Set<WidgetState> states, Widget field);

/// A callback for building a field's icon.
///
/// [style] is the field's style.
/// [states] is the current states of the widget.
///
/// See [FTextField.prefixBuilder] and [FTextField.suffixBuilder].
typedef FFieldIconBuilder<T> = Widget Function(BuildContext context, T style, Set<WidgetState> states);

/// A callback for building a clear icon.
///
/// [style] is the text field's style.
/// [clear] is the callback to clear the text field's content.
typedef FFieldClearIconBuilder = Widget Function(BuildContext, FTextFieldStyle style, VoidCallback clear);

/// A text field.
///
/// It lets the user enter text, either with a hardware keyboard or with an onscreen keyboard.
///
/// See:
/// * https://forui.dev/docs/form/text-field for working examples.
/// * [FTextFieldStyle] for customizing a text field's appearance.
/// * [FTextFormField] for creating a text field that can be used in a form.
/// * [TextField] for more details about working with a text field.
class FTextField extends StatelessWidget {
  /// Creates a [FTextField] configured for password entry with a visibility toggle.
  ///
  /// By default, [suffixBuilder] is an eye icon that toggles showing and hiding the password. Replace the toggle by
  /// providing a custom [suffixBuilder], or disable it by setting it to `null`.
  ///
  /// The [obscureTextControl] parameter controls the obscuring state.
  ///
  /// [autofillHints] defaults to [AutofillHints.password]. Use [AutofillHints.newPassword] for new-password inputs.
  static Widget password({
    FTextFieldControl control = const .managed(),
    FObscureTextControl obscureTextControl = const .managed(),
    FTextFieldStyle Function(FTextFieldStyle style)? style,
    FFieldBuilder<FTextFieldStyle> builder = Input.defaultBuilder,
    Widget? label = const LocalizedText.password(),
    String? hint,
    Widget? description,
    Widget? error,
    TextMagnifierConfiguration? magnifierConfiguration,
    Object groupId = EditableText,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextInputAction textInputAction = .next,
    TextCapitalization textCapitalization = .none,
    TextAlign textAlign = .start,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool autofocus = false,
    WidgetStatesController? statesController,
    String obscuringCharacter = '•',
    bool autocorrect = false,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = false,
    int? minLines,
    int maxLines = 1,
    bool expands = false,
    bool readOnly = false,
    bool? showCursor,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    GestureTapCallback? onTap,
    TapRegionCallback? onTapOutside,
    bool onTapAlwaysCalled = false,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmit,
    AppPrivateCommandCallback? onAppPrivateCommand,
    List<TextInputFormatter>? inputFormatters,
    bool enabled = true,
    bool? ignorePointers,
    bool enableInteractiveSelection = true,
    bool? selectAllOnFocus,
    TextSelectionControls? selectionControls,
    DragStartBehavior dragStartBehavior = .start,
    MouseCursor? mouseCursor,
    FTextFieldCounterBuilder? counterBuilder,
    ScrollPhysics? scrollPhysics,
    ScrollController? scrollController,
    Iterable<String> autofillHints = const [AutofillHints.password],
    String? restorationId,
    bool stylusHandwritingEnabled = true,
    bool enableIMEPersonalizedLearning = true,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    EditableTextContextMenuBuilder contextMenuBuilder = Input.defaultContextMenuBuilder,
    bool canRequestFocus = true,
    UndoHistoryController? undoController,
    SpellCheckConfiguration? spellCheckConfiguration,
    FPasswordFieldIconBuilder<FTextFieldStyle>? prefixBuilder,
    FPasswordFieldIconBuilder<FTextFieldStyle>? suffixBuilder = PasswordField.defaultToggleBuilder,
    bool Function(TextEditingValue) clearable = Input.defaultClearable,
    FFieldClearIconBuilder clearIconBuilder = Input.defaultClearIconBuilder,
    Key? key,
  }) => TextFieldControl(
    key: key,
    control: control,
    builder: (context, controller, _) => PasswordField(
      controller: controller,
      properties: PasswordFieldProperties(
        style: style,
        builder: builder,
        label: label,
        hint: hint,
        description: description,
        error: error,
        magnifierConfiguration: magnifierConfiguration,
        groupId: groupId,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        textAlign: textAlign,
        textAlignVertical: textAlignVertical,
        textDirection: textDirection,
        autofocus: autofocus,
        statesController: statesController,
        obscuringCharacter: obscuringCharacter,
        autocorrect: autocorrect,
        smartDashesType: smartDashesType,
        smartQuotesType: smartQuotesType,
        enableSuggestions: enableSuggestions,
        minLines: minLines,
        maxLines: maxLines,
        expands: expands,
        readOnly: readOnly,
        showCursor: showCursor,
        maxLength: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
        onTap: onTap,
        onTapOutside: onTapOutside,
        onTapAlwaysCalled: onTapAlwaysCalled,
        onEditingComplete: onEditingComplete,
        onSubmit: onSubmit,
        onAppPrivateCommand: onAppPrivateCommand,
        inputFormatters: inputFormatters,
        enabled: enabled,
        ignorePointers: ignorePointers,
        enableInteractiveSelection: enableInteractiveSelection,
        selectAllOnFocus: selectAllOnFocus,
        selectionControls: selectionControls,
        dragStartBehavior: dragStartBehavior,
        mouseCursor: mouseCursor,
        counterBuilder: counterBuilder,
        scrollPhysics: scrollPhysics,
        scrollController: scrollController,
        autofillHints: autofillHints,
        restorationId: restorationId,
        stylusHandwritingEnabled: stylusHandwritingEnabled,
        enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
        contentInsertionConfiguration: contentInsertionConfiguration,
        contextMenuBuilder: contextMenuBuilder,
        canRequestFocus: canRequestFocus,
        undoController: undoController,
        spellCheckConfiguration: spellCheckConfiguration,
        prefixBuilder: prefixBuilder,
        suffixBuilder: suffixBuilder,
        clearable: clearable,
        clearIconBuilder: clearIconBuilder,
        obscureTextControl: obscureTextControl,
      ),
    ),
  );

  /// {@template forui.text_field.style}
  /// The text field's style. Defaults to [FThemeData.textFieldStyle].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create text-field
  /// ```
  /// {@endtemplate}
  final FTextFieldStyle Function(FTextFieldStyle style)? style;

  /// {@template forui.text_field.builder}
  /// The builder used to decorate the text-field. It should always use the given child.
  ///
  /// Defaults to returning the given child.
  /// {@endtemplate}
  final FFieldBuilder<FTextFieldStyle> builder;

  /// {@template forui.text_field.label}
  /// A builder that creates a widget to display validation errors.
  /// {@endtemplate}
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
  final Widget? description;

  /// {@template forui.text_field.error}
  /// The error message.
  /// {@endtemplate}
  final Widget? error;

  /// {@template forui.text_field.magnifier_configuration}
  /// The configuration for the magnifier of this text field.
  ///
  /// By default, builds a [CupertinoTextMagnifier] on iOS and [TextMagnifier] on Android, and builds nothing on all
  /// other platforms. To suppress the magnifier, consider passing [TextMagnifierConfiguration.disabled].
  /// {@endtemplate}
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// {@template forui.text_field_groupId}
  /// The group identifier for the [TextFieldTapRegion] of this text field.
  ///
  /// Text fields with the same group identifier share the same tap region. Defaults to the type of [EditableText].
  /// {@endtemplate}
  final Object groupId;

  /// {@template forui.text_field.control}
  /// Controls the text being edited.
  ///
  /// Defaults to [FTextFieldControl.managed] which creates and manages an internal [TextEditingController].
  /// {@endtemplate}
  final FTextFieldControl control;

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
  ///  * [expands], which determines whether the field should fill the height of its widget.
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
  ///  * [expands], which determines whether the field should fill the height of its widget.
  /// {@endtemplate}
  final int? maxLines;

  /// {@template forui.text_field.expands}
  /// Whether this widget's height will be sized to fill its widget. Defaults to false.
  ///
  /// If set to true and wrapped in a widget widget like [Expanded] or [SizedBox], the input will expand to fill the
  /// widget.
  ///
  /// [maxLines] and [minLines] must both be null when this is set to true, otherwise an error is thrown.
  ///
  /// See the examples in [maxLines] for the complete picture of how [maxLines], [minLines], and [expands] interact to
  /// produce various behaviors.
  ///
  /// Input that matches the height of its widget:
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

  /// {@template forui.text_field.onTapOutside}
  /// Called for each tap down that occurs outside of the [TextFieldTapRegion]
  /// group when the text field is focused.
  ///
  /// If this is null, [EditableTextTapOutsideIntent] will be invoked. In the
  /// default implementation, [FocusNode.unfocus] will be called on the
  /// [focusNode] for this text field when a [PointerDownEvent] is received on
  /// another part of the UI. However, it will not unfocus as a result of mobile
  /// application touch events (which does not include mouse clicks), to conform
  /// with the platform conventions. To change this behavior, a callback may be
  /// set here or [EditableTextTapOutsideIntent] may be overridden.
  ///
  /// When adding additional controls to a text field (for example, a spinner, a
  /// button that copies the selected text, or modifies formatting), it is
  /// helpful if tapping on that control doesn't unfocus the text field. In
  /// order for an external widget to be considered as part of the text field
  /// for the purposes of tapping "outside" of the field, wrap the control in a
  /// [TextFieldTapRegion].
  ///
  /// The [PointerDownEvent] passed to the function is the event that caused the
  /// notification. It is possible that the event may occur outside of the
  /// immediate bounding box defined by the text field, although it will be
  /// within the bounding box of a [TextFieldTapRegion] member.
  /// {@endtemplate}
  final TapRegionCallback? onTapOutside;

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
  ///    and then focus is given up.
  ///
  ///  - When a non-completion action is pressed, such as "next" or "previous", the user's content is submitted but
  ///    focus is not given up because developers may want to immediately move focus to another input widget within
  ///    [onSubmit].
  ///
  /// Providing [onEditingComplete] prevents the aforementioned default behavior.
  /// {@endtemplate}
  final VoidCallback? onEditingComplete;

  /// {@template forui.text_field.onSubmit}
  /// Called when the user indicates that they are done editing the text in the field.
  ///
  /// By default, [onSubmit] is called after `onChange` when the user has finalized editing; or, if the default behavior
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
  /// the `onChange` callback, formatters don't run when the text is changed programmatically via a
  /// [TextEditingController].
  ///
  /// See also:
  ///  * [TextEditingController], which implements the [Listenable] interface and notifies its listeners on
  ///    [TextEditingValue] changes.
  /// {@endtemplate}
  final List<TextInputFormatter>? inputFormatters;

  /// {@template forui.text_field.enabled}
  /// If false the text field is "disabled": it ignores taps. Defaults to true.
  /// {@endtemplate}
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

  /// {@template forui.text_field.selectAllOnFocus}
  /// Whether this field should select all text when gaining focus.
  ///
  /// When false, focusing this text field will leave its existing text selection unchanged.
  ///
  /// Defaults to true on web and desktop platforms, and false on mobile platforms.
  /// {@endtemplate}
  final bool? selectAllOnFocus;

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
  /// It is recommended to style the prefix icon using [FTextFieldStyle.iconStyle].
  ///
  /// See [InputDecoration.prefixIcon] for more information.
  /// {@endtemplate}
  final FFieldIconBuilder<FTextFieldStyle>? prefixBuilder;

  /// {@template forui.text_field.suffixBuilder}
  /// The suffix's builder.
  ///
  /// It is recommended to style the suffix icon using [FTextFieldStyle.iconStyle].
  ///
  /// See [InputDecoration.suffixIcon] for more information.
  /// {@endtemplate}
  final FFieldIconBuilder<FTextFieldStyle>? suffixBuilder;

  /// {@template forui.text_field.clearable}
  /// A predicate that returns true if a clear icon should be shown at the end when the text field is not empty.
  ///
  /// It is never shown when the text field is disabled.
  ///
  /// Defaults to always returning false.
  /// {@endtemplate}
  final bool Function(TextEditingValue) clearable;

  /// {@template forui.text_field.clearIconBuilder}
  /// The builder used to build the clear icon when [clearable] returns true.
  /// {@endtemplate}
  final FFieldClearIconBuilder clearIconBuilder;

  /// Creates a [FTextField].
  const FTextField({
    this.control = const .managed(),
    this.style,
    this.builder = Input.defaultBuilder,
    this.label,
    this.hint,
    this.description,
    this.error,
    this.magnifierConfiguration,
    this.groupId = EditableText,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = .none,
    this.textAlign = .start,
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
    this.maxLines = 1,
    this.expands = false,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onTap,
    this.onTapOutside,
    this.onTapAlwaysCalled = false,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractiveSelection = true,
    this.selectAllOnFocus,
    this.selectionControls,
    this.dragStartBehavior = .start,
    this.mouseCursor,
    this.counterBuilder,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder = Input.defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.prefixBuilder,
    this.suffixBuilder,
    this.clearable = Input.defaultClearable,
    this.clearIconBuilder = Input.defaultClearIconBuilder,
    super.key,
  });

  /// Creates a [FTextField] configured for emails.
  const FTextField.email({
    this.control = const .managed(),
    this.style,
    this.builder = Input.defaultBuilder,
    this.label = const LocalizedText.email(),
    this.hint,
    this.description,
    this.error,
    this.magnifierConfiguration,
    this.groupId = EditableText,
    this.focusNode,
    this.keyboardType = .emailAddress,
    this.textInputAction = .next,
    this.textCapitalization = .none,
    this.textAlign = .start,
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
    this.onTap,
    this.onTapOutside,
    this.onTapAlwaysCalled = false,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractiveSelection = true,
    this.selectAllOnFocus,
    this.selectionControls,
    this.dragStartBehavior = .start,
    this.mouseCursor,
    this.counterBuilder,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints = const [AutofillHints.email],
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder = Input.defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.prefixBuilder,
    this.suffixBuilder,
    this.clearable = Input.defaultClearable,
    this.clearIconBuilder = Input.defaultClearIconBuilder,
    super.key,
  });

  /// Creates a [FTextField] configured for multiline inputs.
  ///
  /// The text field's height can be configured by adjusting [minLines]. By default, the text field will expand every
  /// time a new line is added. To limit the maximum height of the text field and make it scrollable, consider setting
  /// [maxLines].
  const FTextField.multiline({
    this.control = const .managed(),
    this.style,
    this.builder = Input.defaultBuilder,
    this.label,
    this.hint,
    this.description,
    this.error,
    this.magnifierConfiguration,
    this.groupId = EditableText,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = .sentences,
    this.textAlign = .start,
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
    this.onTap,
    this.onTapOutside,
    this.onTapAlwaysCalled = false,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractiveSelection = true,
    this.selectAllOnFocus,
    this.selectionControls,
    this.dragStartBehavior = .start,
    this.mouseCursor,
    this.counterBuilder,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder = Input.defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.prefixBuilder,
    this.suffixBuilder,
    this.clearable = Input.defaultClearable,
    this.clearIconBuilder = Input.defaultClearIconBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) => TextFieldControl(
    control: control,
    builder: (context, controller, _) => Input(
      controller: controller,
      style: style,
      builder: builder,
      label: label,
      hint: hint,
      description: description,
      error: error,
      magnifierConfiguration: magnifierConfiguration,
      groupId: groupId,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      autofocus: autofocus,
      statesController: statesController,
      obscuringCharacter: obscuringCharacter,
      obscureText: obscureText,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions,
      minLines: minLines,
      maxLines: maxLines,
      expands: expands,
      readOnly: readOnly,
      showCursor: showCursor,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      onTap: onTap,
      onTapOutside: onTapOutside,
      onTapAlwaysCalled: onTapAlwaysCalled,
      onEditingComplete: onEditingComplete,
      onSubmit: onSubmit,
      onAppPrivateCommand: onAppPrivateCommand,
      inputFormatters: inputFormatters,
      enabled: enabled,
      ignorePointers: ignorePointers,
      enableInteractiveSelection: enableInteractiveSelection,
      selectAllOnFocus: selectAllOnFocus,
      selectionControls: selectionControls,
      dragStartBehavior: dragStartBehavior,
      mouseCursor: mouseCursor,
      counterBuilder: counterBuilder,
      scrollPhysics: scrollPhysics,
      scrollController: scrollController,
      autofillHints: autofillHints,
      restorationId: restorationId,
      stylusHandwritingEnabled: stylusHandwritingEnabled,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      contentInsertionConfiguration: contentInsertionConfiguration,
      contextMenuBuilder: contextMenuBuilder,
      canRequestFocus: canRequestFocus,
      undoController: undoController,
      spellCheckConfiguration: spellCheckConfiguration,
      prefixBuilder: prefixBuilder,
      suffixBuilder: suffixBuilder,
      clearable: clearable,
      clearIconBuilder: clearIconBuilder,
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty('magnifierConfiguration', magnifierConfiguration))
      ..add(DiagnosticsProperty('groupId', groupId))
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
      ..add(ObjectFlagProperty.has('onTap', onTap))
      ..add(ObjectFlagProperty.has('onTapOutside', onTapOutside))
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
      ..add(FlagProperty('selectAllOnFocus', value: selectAllOnFocus, ifTrue: 'selectAllOnFocus'))
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
      ..add(ObjectFlagProperty.has('clearIconBuilder', clearIconBuilder));
  }
}

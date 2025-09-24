import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/autocomplete/autocomplete_content.dart';
import 'package:forui/src/widgets/autocomplete/autocomplete_controller.dart';
import 'package:forui/src/widgets/autocomplete/skip_delegate_traversal_policy.dart';

part 'autocomplete.design.dart';

/// A builder for [FAutocomplete]'s results.
typedef FAutoCompleteContentBuilder =
    List<FAutocompleteItemMixin> Function(BuildContext context, String query, Iterable<String> values);

/// An autocomplete provides a list of suggestions based on the user's input and shows typeahead text for the first match.
///
/// It is a [FormField] and therefore can be used in a [Form] widget.
///
/// ## Note
/// The autocomplete does not support using arrow keys to navigate the suggestions on web.
///
/// See:
/// * https://forui.dev/docs/form/autocomplete for working examples.
/// * [FAutocompleteController] for customizing the behavior of an autocomplete.
/// * [FAutocompleteStyle] for customizing the appearance of an autocomplete.
class FAutocomplete extends StatefulWidget with FFormFieldProperties<String> {
  /// The default loading builder that shows a spinner when an asynchronous search is pending.
  static Widget defaultContentLoadingBuilder(BuildContext _, FAutocompleteContentStyle style) => Padding(
    padding: const EdgeInsets.all(13),
    child: FCircularProgress(style: style.progressStyle),
  );

  /// The default empty builder that shows a localized message when there are no results.
  static Widget defaultContentEmptyBuilder(BuildContext context, FAutocompleteContentStyle style) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: Text(localizations.autocompleteNoResults, style: style.emptyTextStyle),
    );
  }

  static bool _clearable(TextEditingValue _) => false;

  static Widget _builder(BuildContext _, FAutocompleteStyle _, Set<WidgetState> _, Widget? child) => child!;

  /// The controller.
  final FAutocompleteController? controller;

  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create autocomplete
  /// ```
  final FAutocompleteStyle Function(FAutocompleteStyle style)? style;

  /// {@macro forui.text_field.label}
  @override
  final Widget? label;

  /// {@macro forui.text_field.hint}
  final String? hint;

  /// {@macro forui.text_field.description}
  @override
  final Widget? description;

  /// {@macro forui.text_field.magnifier_configuration}
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// {@macro forui.text_field_groupId}
  final Object groupId;

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

  /// {@macro forui.text_field.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.text_field.statesController}
  final WidgetStatesController? statesController;

  /// {@macro forui.text_field.obscuringCharacter}
  final String obscuringCharacter;

  /// {@macro forui.text_field.obscureText}
  final bool obscureText;

  /// {@macro forui.text_field.autocorrect}
  final bool autocorrect;

  /// {@macro forui.text_field.smartDashesType}
  final SmartDashesType? smartDashesType;

  /// {@macro forui.text_field.smartQuotesType}
  final SmartQuotesType? smartQuotesType;

  /// {@macro forui.text_field.enableSuggestions}
  final bool enableSuggestions;

  /// {@macro forui.text_field.minLines}
  final int? minLines;

  /// {@macro forui.text_field.maxLines}
  final int? maxLines;

  /// {@macro forui.text_field.expands}
  final bool expands;

  /// {@macro forui.text_field.readOnly}
  final bool readOnly;

  /// {@macro forui.text_field.showCursor}
  final bool? showCursor;

  /// {@macro forui.text_field.maxLength}
  final int? maxLength;

  /// {@macro forui.text_field.maxLengthEnforcement}
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// {@macro forui.text_field.onChange}
  final ValueChanged<String>? onChange;

  /// {@macro forui.text_field.onTap}
  final bool onTapAlwaysCalled;

  /// {@macro forui.text_field.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro forui.text_field.onSubmit}
  final ValueChanged<String>? onSubmit;

  /// {@macro forui.text_field.onAppPrivateCommand}
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// {@macro forui.text_field.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// {@macro forui.text_field.enabled}
  @override
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

  /// {@macro forui.text_field.counterBuilder}
  final FTextFieldCounterBuilder? counterBuilder;

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

  /// {@macro forui.text_field.canRequestFocus}
  final bool canRequestFocus;

  /// {@macro forui.text_field.undoController}
  final UndoHistoryController? undoController;

  /// {@macro forui.text_field.spellCheckConfiguration}
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// {@macro forui.text_field.prefixBuilder}
  final FFieldIconBuilder<FAutocompleteStyle>? prefixBuilder;

  /// {@macro forui.text_field.suffixBuilder}
  final FFieldIconBuilder<FAutocompleteStyle>? suffixBuilder;

  /// {@macro forui.text_field.clearable}
  final bool Function(TextEditingValue value) clearable;

  @override
  final FormFieldSetter<String>? onSaved;

  @override
  final VoidCallback? onReset;

  @override
  final FormFieldValidator<String>? validator;

  /// {@macro forui.text_field.initialValue}
  final String? initialText;

  @override
  final AutovalidateMode autovalidateMode;

  @override
  final String? forceErrorText;

  @override
  final Widget Function(BuildContext context, String message) errorBuilder;

  /// The alignment point on the popover. Defaults to [AlignmentDirectional.topStart].
  final AlignmentGeometry anchor;

  /// The alignment point on the select's field. Defaults to [AlignmentDirectional.bottomStart].
  final AlignmentGeometry fieldAnchor;

  /// The constraints to apply to the popover. Defaults to `const FAutoWidthPortalConstraints(maxHeight: 300)`.
  final FPortalConstraints popoverConstraints;

  /// {@macro forui.widgets.FPopover.spacing}
  final FPortalSpacing spacing;

  /// {@macro forui.widgets.FPopover.shift}
  final Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift;

  /// {@macro forui.widgets.FPopover.offset}
  final Offset offset;

  /// {@macro forui.widgets.FPopover.hideRegion}
  final FPopoverHideRegion hideRegion;

  /// {@macro forui.widgets.FPopover.onTapHide}
  final VoidCallback? onTapHide;

  /// True if the select should be automatically hidden after an item is selected. Defaults to false.
  final bool autoHide;

  /// The builder used to decorate the autocomplete. It should always use the given child.
  ///
  /// Defaults to returning the given child.
  final FFieldBuilder<FAutocompleteStyle> builder;

  /// Whether the autocomplete should complete the text when a completion is available and the user presses right arrow.
  /// Defaults to false.
  final bool rightArrowToComplete;

  /// A callback that produces a list of items based on the query either synchronously or asynchronously.
  final FutureOr<Iterable<String>> Function(String text) filter;

  /// The builder that is called when the select is empty. Defaults to [defaultContentEmptyBuilder].
  final Widget Function(BuildContext context, FAutocompleteContentStyle style) contentEmptyBuilder;

  /// The content's scroll controller.
  final ScrollController? contentScrollController;

  /// The content's scroll physics. Defaults to [ClampingScrollPhysics].
  final ScrollPhysics contentPhysics;

  /// The divider used to separate the content items. Defaults to [FItemDivider.none].
  final FItemDivider contentDivider;

  /// A callback builds the list of items based on search results returned by [filter].
  final FAutoCompleteContentBuilder contentBuilder;

  /// A callback that is used to show a loading indicator while the results is processed.
  final Widget Function(BuildContext context, FAutocompleteContentStyle style) contentLoadingBuilder;

  /// A callback that is used to show an error message when [filter] is asynchronous and fails.
  final Widget Function(BuildContext context, Object? error, StackTrace stackTrace)? contentErrorBuilder;

  /// Creates a [FAutocomplete] from the given [items].
  ///
  /// For more control over the appearance of items, use [FAutocomplete.builder].
  FAutocomplete({
    required List<String> items,
    FAutocompleteStyle Function(FAutocompleteStyle style)? style,
    Widget? label,
    String? hint,
    Widget? description,
    TextMagnifierConfiguration? magnifierConfiguration,
    Object groupId = EditableText,
    FAutocompleteController? controller,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    VoidCallback? onTapHide,
    bool autofocus = false,
    WidgetStatesController? statesController,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    int? minLines,
    int? maxLines = 1,
    bool expands = false,
    bool readOnly = false,
    bool? showCursor,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    ValueChanged<String>? onChange,
    bool onTapAlwaysCalled = false,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmit,
    AppPrivateCommandCallback? onAppPrivateCommand,
    List<TextInputFormatter>? inputFormatters,
    bool enabled = true,
    bool? ignorePointers,
    bool enableInteractiveSelection = true,
    TextSelectionControls? selectionControls,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    MouseCursor? mouseCursor,
    FTextFieldCounterBuilder? counterBuilder,
    ScrollPhysics? scrollPhysics,
    ScrollController? scrollController,
    Iterable<String>? autofillHints,
    String? restorationId,
    bool stylusHandwritingEnabled = true,
    bool enableIMEPersonalizedLearning = true,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    EditableTextContextMenuBuilder? contextMenuBuilder,
    bool canRequestFocus = true,
    UndoHistoryController? undoController,
    SpellCheckConfiguration? spellCheckConfiguration,
    FFieldIconBuilder<FAutocompleteStyle>? prefixBuilder,
    FFieldIconBuilder<FAutocompleteStyle>? suffixBuilder,
    bool Function(TextEditingValue value) clearable = _clearable,
    FormFieldSetter<String>? onSaved,
    VoidCallback? onReset,
    FormFieldValidator<String>? validator,
    String? initialText,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    String? forceErrorText,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    AlignmentGeometry anchor = AlignmentDirectional.topStart,
    AlignmentGeometry fieldAnchor = AlignmentDirectional.bottomStart,
    FPortalConstraints popoverConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    FPortalSpacing spacing = const FPortalSpacing(4),
    Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift = FPortalShift.flip,
    Offset offset = Offset.zero,
    FPopoverHideRegion hideRegion = FPopoverHideRegion.excludeChild,
    bool autoHide = true,
    FFieldBuilder<FAutocompleteStyle> builder = _builder,
    bool rightArrowToComplete = false,
    FutureOr<Iterable<String>> Function(String query)? filter,
    FAutoCompleteContentBuilder? contentBuilder,
    ScrollController? contentScrollController,
    ScrollPhysics contentPhysics = const ClampingScrollPhysics(),
    FItemDivider contentDivider = FItemDivider.none,
    Widget Function(BuildContext context, FAutocompleteContentStyle style) contentEmptyBuilder =
        defaultContentEmptyBuilder,
    Widget Function(BuildContext context, FAutocompleteContentStyle style) contentLoadingBuilder =
        defaultContentLoadingBuilder,
    Widget Function(BuildContext context, Object? error, StackTrace stackTrace)? contentErrorBuilder,
    Key? key,
  }) : this.builder(
         filter: filter ?? (query) => items.where((item) => item.toLowerCase().startsWith(query.toLowerCase())),
         contentBuilder:
             contentBuilder ??
             (context, query, values) => [for (final value in values) FAutocompleteItem(value: value)],
         style: style,
         label: label,
         hint: hint,
         description: description,
         magnifierConfiguration: magnifierConfiguration,
         groupId: groupId,
         controller: controller,
         focusNode: focusNode,
         keyboardType: keyboardType,
         textInputAction: textInputAction,
         textCapitalization: textCapitalization,
         textAlign: textAlign,
         textAlignVertical: textAlignVertical,
         textDirection: textDirection,
         onTapHide: onTapHide,
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
         onChange: onChange,
         onTapAlwaysCalled: onTapAlwaysCalled,
         onEditingComplete: onEditingComplete,
         onSubmit: onSubmit,
         onAppPrivateCommand: onAppPrivateCommand,
         inputFormatters: inputFormatters,
         enabled: enabled,
         ignorePointers: ignorePointers,
         enableInteractiveSelection: enableInteractiveSelection,
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
         onSaved: onSaved,
         onReset: onReset,
         validator: validator,
         initialText: initialText,
         autovalidateMode: autovalidateMode,
         forceErrorText: forceErrorText,
         errorBuilder: errorBuilder,
         anchor: anchor,
         fieldAnchor: fieldAnchor,
         popoverConstraints: popoverConstraints,
         spacing: spacing,
         shift: shift,
         offset: offset,
         hideRegion: hideRegion,
         autoHide: autoHide,
         builder: builder,
         rightArrowToComplete: rightArrowToComplete,
         contentScrollController: contentScrollController,
         contentPhysics: contentPhysics,
         contentDivider: contentDivider,
         contentEmptyBuilder: contentEmptyBuilder,
         contentLoadingBuilder: contentLoadingBuilder,
         contentErrorBuilder: contentErrorBuilder,
         key: key,
       );

  /// Creates a [FAutocomplete] that uses the given [filter] to determine the results and the [contentBuilder] to build
  /// the content.
  const FAutocomplete.builder({
    required this.filter,
    required this.contentBuilder,
    this.style,
    this.label,
    this.hint,
    this.description,
    this.magnifierConfiguration,
    this.groupId = EditableText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.onTapHide,
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
    this.onChange,
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
    this.contextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.prefixBuilder,
    this.suffixBuilder,
    this.clearable = _clearable,
    this.onSaved,
    this.onReset,
    this.validator,
    this.initialText,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.forceErrorText,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.anchor = AlignmentDirectional.topStart,
    this.fieldAnchor = AlignmentDirectional.bottomStart,
    this.popoverConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    this.spacing = const FPortalSpacing(4),
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    this.hideRegion = FPopoverHideRegion.excludeChild,
    this.autoHide = true,
    this.builder = _builder,
    this.rightArrowToComplete = false,
    this.contentScrollController,
    this.contentPhysics = const ClampingScrollPhysics(),
    this.contentDivider = FItemDivider.none,
    this.contentEmptyBuilder = defaultContentEmptyBuilder,
    this.contentLoadingBuilder = defaultContentLoadingBuilder,
    this.contentErrorBuilder,
    super.key,
  }) : assert(
         controller == null || initialText == null,
         'Cannot provide both a controller and initialText. To fix, set the initial text directly in the controller.',
       );

  @override
  State<FAutocomplete> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty('magnifierConfiguration', magnifierConfiguration))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(DiagnosticsProperty('keyboardType', keyboardType))
      ..add(EnumProperty('textInputAction', textInputAction))
      ..add(EnumProperty('textCapitalization', textCapitalization))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(DiagnosticsProperty('statesController', statesController))
      ..add(StringProperty('obscuringCharacter', obscuringCharacter))
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
      ..add(ObjectFlagProperty.has('counterBuilder', counterBuilder))
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
      ..add(ObjectFlagProperty.has('onReset', onReset))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(StringProperty('initialText', initialText))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(DiagnosticsProperty('anchor', anchor))
      ..add(DiagnosticsProperty('fieldAnchor', fieldAnchor))
      ..add(DiagnosticsProperty('popoverConstraints', popoverConstraints))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(EnumProperty('hideRegion', hideRegion))
      ..add(ObjectFlagProperty.has('onTapHide', onTapHide))
      ..add(FlagProperty('autoHide', value: autoHide, ifTrue: 'autoHide'))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(FlagProperty('rightArrowToComplete', value: rightArrowToComplete, ifTrue: 'rightArrowToComplete'))
      ..add(ObjectFlagProperty.has('filter', filter))
      ..add(ObjectFlagProperty.has('contentEmptyBuilder', contentEmptyBuilder))
      ..add(DiagnosticsProperty('contentScrollController', contentScrollController))
      ..add(DiagnosticsProperty('contentPhysics', contentPhysics))
      ..add(EnumProperty('contentDivider', contentDivider))
      ..add(ObjectFlagProperty.has('contentBuilder', contentBuilder))
      ..add(ObjectFlagProperty.has('contentLoadingBuilder', contentLoadingBuilder))
      ..add(ObjectFlagProperty.has('contentErrorBuilder', contentErrorBuilder));
  }
}

class _State extends State<FAutocomplete> with SingleTickerProviderStateMixin {
  late FAutocompleteController _controller;
  late FutureOr<Iterable<String>> _data;
  late FocusNode _fieldFocus;
  late FocusScopeNode _popoverFocus;
  bool _tapFocus = false;
  String? _previous;

  /// The original text used to restore the textfield when navigating but not selecting any completion using a keyboard.
  String? _restore;

  @override
  void initState() {
    super.initState();
    _fieldFocus = widget.focusNode ?? FocusNode(debugLabel: 'FAutocomplete field');
    _fieldFocus.addListener(_focus);
    _controller = widget.controller ?? FAutocompleteController(vsync: this, text: widget.initialText);
    _controller
      ..addListener(_update)
      ..loadSuggestions(_data = widget.filter(_controller.text));
    _popoverFocus = FocusScopeNode(debugLabel: 'FAutocomplete popover');
  }

  @override
  void didUpdateWidget(covariant FAutocomplete old) {
    super.didUpdateWidget(old);
    // DO NOT REORDER
    if (widget.focusNode != old.focusNode) {
      if (old.focusNode == null) {
        _fieldFocus.dispose();
      }
      _fieldFocus = widget.focusNode ?? FocusNode(debugLabel: 'FAutocomplete field');
    }

    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      } else {
        _controller.removeListener(_update);
      }

      _controller = widget.controller ?? FAutocompleteController(vsync: this, text: widget.initialText);
      _controller
        ..addListener(_update)
        ..loadSuggestions(widget.filter(_controller.text));
    }
  }

  void _update() {
    if (_previous == _controller.text) {
      return;
    }

    if (_fieldFocus.hasFocus && !_controller.popover.status.isForwardOrCompleted) {
      _controller.popover.show();
    }

    setState(() {
      _previous = _controller.text;
      _controller.loadSuggestions(_data = widget.filter(_controller.text));
    });
  }

  void _focus() {
    // Check if the field gained focus because of the user tapping/tabbing into the autocomplete while completions are
    // hidden.
    if (_fieldFocus.hasFocus && _restore == null) {
      if (!_tapFocus) {
        _controller.selection = TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      }
      _tapFocus = false;
      _controller.popover.show();
      // Hide the popover when the textfield loses focus and there are no completions to prevent focus from being trapped
      // in the empty popover.
    } else if (!_fieldFocus.hasFocus && _popoverFocus.descendants.isEmpty) {
      _controller.popover.hide();
    }

    _restore = null;
  }

  @override
  void dispose() {
    _popoverFocus.dispose();

    if (widget.focusNode == null) {
      _fieldFocus.dispose();
    }

    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_update);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.autocompleteStyle) ?? context.theme.autocompleteStyle;
    // On desktop, the textfield selects the entire text when focused (except when tapped). However, refocusing on the
    // textfield after keyboard navigation of completions should NOT select the entire text.
    //
    // To work around this, we disable the default behavior by setting selectAllOnFocus to false and manage the focus
    // behavior ourselves.
    //
    // Focus gained by taps are tracked using this Listener. We cannot use FTextField's onTap method since it is called
    // AFTER its focus change callback. Subsequently the entire text is selected in the focus change callback only if
    // it is not caused by a tap.
    return Listener(
      onPointerDown: (_) {
        if (!_fieldFocus.hasFocus) {
          _tapFocus = true;
        }
      },
      child: FTextFormField(
        style: style.fieldStyle,
        label: widget.label,
        hint: widget.hint,
        description: widget.description,
        magnifierConfiguration: widget.magnifierConfiguration,
        groupId: widget.groupId,
        controller: _controller,
        focusNode: _fieldFocus,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textDirection: widget.textDirection,
        autofocus: widget.autofocus,
        statesController: widget.statesController,
        obscuringCharacter: widget.obscuringCharacter,
        obscureText: widget.obscureText,
        autocorrect: widget.autocorrect,
        smartDashesType: widget.smartDashesType,
        smartQuotesType: widget.smartQuotesType,
        enableSuggestions: widget.enableSuggestions,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        expands: widget.expands,
        readOnly: widget.readOnly,
        showCursor: widget.showCursor,
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        onChange: widget.onChange,
        onTap: _controller.popover.show,
        onTapAlwaysCalled: true,
        onEditingComplete: widget.onEditingComplete,
        onSubmit: widget.onSubmit,
        onAppPrivateCommand: widget.onAppPrivateCommand,
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
        ignorePointers: widget.ignorePointers,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        selectAllOnFocus: false,
        selectionControls: widget.selectionControls,
        dragStartBehavior: widget.dragStartBehavior,
        mouseCursor: widget.mouseCursor,
        counterBuilder: widget.counterBuilder,
        scrollPhysics: widget.scrollPhysics,
        scrollController: widget.scrollController,
        autofillHints: widget.autofillHints,
        restorationId: widget.restorationId,
        stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
        contentInsertionConfiguration: widget.contentInsertionConfiguration,
        contextMenuBuilder: widget.contextMenuBuilder,
        canRequestFocus: widget.canRequestFocus,
        undoController: widget.undoController,
        spellCheckConfiguration: widget.spellCheckConfiguration,
        prefixBuilder: widget.prefixBuilder == null
            ? null
            : (context, _, states) => widget.prefixBuilder!(context, style, states),
        suffixBuilder: widget.suffixBuilder == null
            ? null
            : (context, _, states) => widget.suffixBuilder!(context, style, states),
        clearable: widget.clearable,
        onSaved: widget.onSaved,
        onReset: widget.onReset,
        validator: widget.validator,
        initialText: widget.initialText,
        autovalidateMode: widget.autovalidateMode,
        forceErrorText: widget.forceErrorText,
        errorBuilder: widget.errorBuilder,
        builder: (context, _, states, field) => FocusTraversalGroup(
          policy: SkipDelegateTraversalPolicy(FocusTraversalGroup.maybeOf(context) ?? ReadingOrderTraversalPolicy()),
          child: FPopover(
            controller: _controller.popover,
            style: style.popoverStyle,
            constraints: widget.popoverConstraints,
            popoverAnchor: widget.anchor,
            childAnchor: widget.fieldAnchor,
            spacing: widget.spacing,
            shift: widget.shift,
            offset: widget.offset,
            hideRegion: widget.hideRegion,
            onTapHide: () {
              if (_restore case final restore?) {
                _previous = restore;
                _controller.text = restore;
              }
              widget.onTapHide?.call();
            },
            focusNode: _popoverFocus,
            popoverBuilder: (_, popoverController) => TextFieldTapRegion(
              child: InheritedAutocompleteController(
                popover: popoverController,
                onPress: (value) {
                  if (widget.autoHide) {
                    _controller.popover.hide();
                  }
                  _previous = value;
                  _controller.text = value;
                },
                onFocus: (value) {
                  _restore ??= _controller.text;
                  _previous = value;
                  _controller.text = value;
                },
                child: Content(
                  controller: _controller,
                  style: style.contentStyle,
                  enabled: widget.enabled,
                  scrollController: widget.contentScrollController,
                  physics: widget.contentPhysics,
                  divider: widget.contentDivider,
                  data: _data,
                  loadingBuilder: widget.contentLoadingBuilder,
                  builder: widget.contentBuilder,
                  emptyBuilder: widget.contentEmptyBuilder,
                  errorBuilder: widget.contentErrorBuilder,
                ),
              ),
            ),
            child: InheritedAutocompleteStyle(
              style: style,
              states: states,
              child: CallbackShortcuts(
                bindings: {
                  const SingleActivator(LogicalKeyboardKey.escape): _controller.popover.hide,
                  const SingleActivator(LogicalKeyboardKey.arrowDown): () =>
                      _popoverFocus.descendants.firstOrNull?.requestFocus(),
                  if (_controller.current case (:final replacement, completion: final _))
                    const SingleActivator(LogicalKeyboardKey.tab): () => _complete(replacement),
                  if (_controller.current case (
                    :final replacement,
                    completion: final _,
                  ) when widget.rightArrowToComplete)
                    const SingleActivator(LogicalKeyboardKey.arrowRight): () => _complete(replacement),
                },
                child: widget.builder(context, style, states, field),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _complete(String replacement) {
    if (widget.autoHide) {
      _controller.popover.hide();
    }
    _previous = replacement;
    _controller.complete();
  }
}

/// An [FAutocomplete]'s style.
class FAutocompleteStyle with Diagnosticable, _$FAutocompleteStyleFunctions {
  /// The select field's style.
  @override
  final FTextFieldStyle fieldStyle;

  /// The composing text's [TextStyle].
  ///
  /// {@template forui.text_field.composingTextStyle}
  /// It is strongly recommended that FTextFieldStyle.contentTextStyle], [composingTextStyle] and [typeaheadTextStyle]
  /// are the same size to prevent visual discrepancies between the actual and typeahead text.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  /// {@endtemplate}
  @override
  final FWidgetStateMap<TextStyle> composingTextStyle;

  /// The typeahead's [TextStyle].
  ///
  /// {@macro forui.text_field.composingTextStyle}
  @override
  final FWidgetStateMap<TextStyle> typeaheadTextStyle;

  /// The popover's style.
  @override
  final FPopoverStyle popoverStyle;

  /// The content's style.
  @override
  final FAutocompleteContentStyle contentStyle;

  /// Creates a [FAutocompleteStyle].
  FAutocompleteStyle({
    required this.fieldStyle,
    required this.composingTextStyle,
    required this.typeaheadTextStyle,
    required this.popoverStyle,
    required this.contentStyle,
  });

  /// Creates a [FAutocompleteStyle] that inherits its properties.
  factory FAutocompleteStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) {
    final field = FTextFieldStyle.inherit(colors: colors, typography: typography, style: style);

    return FAutocompleteStyle(
      fieldStyle: field,
      composingTextStyle: field.contentTextStyle.map((s) => s.copyWith(decoration: TextDecoration.underline)),
      typeaheadTextStyle: field.contentTextStyle.map((s) => s.copyWith(color: colors.mutedForeground)),
      popoverStyle: FPopoverStyle.inherit(colors: colors, style: style),
      contentStyle: FAutocompleteContentStyle.inherit(colors: colors, typography: typography, style: style),
    );
  }
}

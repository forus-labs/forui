part of 'text_field.dart';

class _State extends State<FTextField> {

  late final WidgetStatesController controller;

  @override
  void initState() {
    super.initState();
    controller = WidgetStatesController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = widget.style ?? theme.textFieldStyle;

    return MergeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                widget.label!,
                style: style.label,
              ),
            ),
          Theme(
            // The selection colors are defined in a Theme instead of TextField since TextField does not expose parameters
            // for overriding selectionHandleColor.
            data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: style.cursor,
                selectionColor: style.cursor.withOpacity(0.4),
                selectionHandleColor: style.cursor,
              ),
              cupertinoOverrideTheme: CupertinoThemeData(
                primaryColor: style.cursor,
              ),
            ),
            // This is done because InputDecoration.errorBorder and InputDecoration.focusedErrorBorder aren't shown unless an
            // additional error help text is supplied. That error help text has few configuration options.
            child: ValueListenableBuilder(
              valueListenable: widget.statesController ?? controller,
              builder: (context, states, _) {
                final (enabled, focus) = states.contains(WidgetState.error) ? (style.error, style.focusedError) : (style.enabled, style.focused);
                final current = states.contains(WidgetState.focused) ? focus : enabled;
                return _build(context, style, current, enabled, focus);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _build(
    BuildContext context,
    FTextFieldStyle style,
    FTextFieldStateStyle current,
    FTextFieldStateStyle enabled,
    FTextFieldStateStyle focused,
  ) => TextField(
    controller: widget.controller,
    focusNode: widget.focusNode,
    undoController: widget.undoController,
    decoration: InputDecoration(
      suffixIcon: widget.suffixIcon,
      contentPadding: style.contentPadding,
      hintText: widget.hint,
      hintStyle: current.hint,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: enabled.borderColor,
          width: enabled.borderWidth,
        ),
        borderRadius: enabled.borderRadius,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: style.disabled.borderColor,
          width: style.disabled.borderWidth,
        ),
        borderRadius: style.disabled.borderRadius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: focused.borderColor,
          width: focused.borderWidth,
        ),
        borderRadius: enabled.borderRadius,
      ),
    ),
    keyboardType: widget.keyboardType,
    textInputAction: widget.textInputAction,
    textCapitalization: widget.textCapitalization,
    style: current.content,
    textAlign: widget.textAlign,
    textAlignVertical: widget.textAlignVertical,
    textDirection: widget.textDirection,
    readOnly: widget.readOnly,
    showCursor: widget.showCursor,
    autofocus: widget.autofocus,
    statesController: widget.statesController ?? controller,
    obscureText: widget.obscureText,
    autocorrect: widget.autocorrect,
    smartDashesType: widget.smartDashesType,
    smartQuotesType: widget.smartQuotesType,
    enableSuggestions: widget.enableSuggestions,
    maxLines: widget.maxLines,
    minLines: widget.minLines,
    expands: widget.expands,
    maxLength: widget.maxLength,
    maxLengthEnforcement: widget.maxLengthEnforcement,
    onChanged: widget.onChange,
    onEditingComplete: widget.onEditingComplete,
    onSubmitted: widget.onSubmit,
    onAppPrivateCommand: widget.onAppPrivateCommand,
    inputFormatters: widget.inputFormatters,
    enabled: widget.enabled,
    ignorePointers: widget.ignorePointers,
    keyboardAppearance: style.keyboardAppearance,
    scrollPadding: style.scrollPadding,
    dragStartBehavior: widget.dragStartBehavior,
    selectionControls: widget.selectionControls,
    scrollController: widget.scrollController,
    scrollPhysics: widget.scrollPhysics,
    autofillHints: widget.autofillHints,
    restorationId: widget.restorationId,
    scribbleEnabled: widget.scribbleEnabled,
    enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
    contextMenuBuilder: widget.contextMenuBuilder,
    canRequestFocus: widget.canRequestFocus,
    spellCheckConfiguration: widget.spellCheckConfiguration,
    magnifierConfiguration: widget.magnifierConfiguration,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<WidgetStatesController>('controller', controller));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

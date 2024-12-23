import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/date_picker/field/date_field_controller.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:meta/meta.dart';

/// The locales not supported in a date field. It is mostly composed of locales that use non-western digits.
const unsupportedLocales = ['ar', 'bn', 'fa', 'my', 'ne', 'ps'];

@internal
class DateField extends StatefulWidget {
  static Widget _errorBuilder(BuildContext context, String text) => Text(text);

  final FTextFieldStyle? style;
  final Widget? label;
  final Widget? description;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool expands;
  final bool readOnly;
  final bool autofocus;
  final ValueChanged<String>? onChange;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmit;
  final MouseCursor? mouseCursor;
  final bool canRequestFocus;
  final Widget? suffix;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final String? forceErrorText;
  final Widget Function(BuildContext, String) errorBuilder;
  final FLocalizations _localizations;
  final DateTime? _initial;

  const DateField({
    required this.style,
    required FLocalizations localizations,
    required DateTime? initialValue,
    this.label,
    this.description,
    this.focusNode,
    this.textInputAction,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.autofocus = false,
    this.expands = false,
    this.readOnly = false,
    this.onChange,
    this.onEditingComplete,
    this.onSubmit,
    this.mouseCursor,
    this.canRequestFocus = true,
    this.suffix,
    this.onSaved,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.forceErrorText,
    this.errorBuilder = _errorBuilder,
    super.key,
  })  : _localizations = localizations,
        _initial = initialValue;

  @override
  State<DateField> createState() => _DateFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(EnumProperty('textInputAction', textInputAction))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(FlagProperty('readOnly', value: readOnly, ifTrue: 'readOnly'))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(ObjectFlagProperty.has('onEditingComplete', onEditingComplete))
      ..add(ObjectFlagProperty.has('onSubmit', onSubmit))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(DiagnosticsProperty('suffixIcon', suffix))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder));
  }
}

class _DateFieldState extends State<DateField> {
  late FLocalizations _localizations;
  late DateFieldController _controller;

  @override
  void initState() {
    super.initState();
    _localizations =
        unsupportedLocales.contains(widget._localizations.localeName) ? FDefaultLocalizations() : widget._localizations;
    _controller = DateFieldController(_localizations, widget._initial);
  }

  @override
  void didUpdateWidget(covariant DateField old) {
    super.didUpdateWidget(old);
    if (widget._localizations != old._localizations) {
      _localizations = unsupportedLocales.contains(widget._localizations.localeName)
          ? FDefaultLocalizations()
          : widget._localizations;
    }

    if (widget._initial != old._initial) {
      _controller.dispose();
      _controller = DateFieldController(_localizations, widget._initial);
    }
  }

  @override
  Widget build(BuildContext context) => Shortcuts(
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.arrowUp): AdjustIntent(1),
          SingleActivator(LogicalKeyboardKey.arrowDown): AdjustIntent(-1),
        },
        child: Actions(
          actions: {
            AdjustIntent: CallbackAction<AdjustIntent>(onInvoke: (intent) => _controller.adjust(intent.amount)),
            ExtendSelectionByCharacterIntent: CallbackAction<ExtendSelectionByCharacterIntent>(
              onInvoke: (intent) => _controller.traverse(forward: intent.forward),
            ),
          },
          child: FTextField(
            controller: _controller,
            statesController: _controller.states,
            autocorrect: false,
            keyboardType: TextInputType.number,
            minLines: 1,
            maxLines: 1,
            style: widget.style,
            label: widget.label,
            description: widget.description,
            focusNode: widget.focusNode,
            textInputAction: widget.textInputAction,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            textDirection: widget.textDirection,
            expands: widget.expands,
            readOnly: widget.readOnly,
            autofocus: widget.autofocus,
            onChange: widget.onChange,
            onEditingComplete: widget.onEditingComplete,
            onSubmit: widget.onSubmit,
            mouseCursor: widget.mouseCursor,
            canRequestFocus: widget.canRequestFocus,
            suffix: widget.suffix,
            onSaved: widget.onSaved,
            validator: widget.validator ??
                (value) {
                  if (value == _controller.placeholder) {
                    return null;
                  }

                  final date = DateFormat.yMd(_localizations.localeName).tryParseStrict(value ?? '');
                  return date == null ? _localizations.invalidDateFormatLabel : null;
                },
            autovalidateMode: widget.autovalidateMode,
            forceErrorText: widget.forceErrorText,
            errorBuilder: widget.errorBuilder,
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@internal
class AdjustIntent extends Intent {
  final int amount;

  const AdjustIntent(this.amount);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('amount', amount));
  }
}

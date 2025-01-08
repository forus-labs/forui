import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/inherited_data.dart';
import 'package:forui/src/widgets/slider/inherited_state.dart';
import 'package:forui/src/widgets/slider/slider_render_object.dart';
import 'package:forui/src/widgets/slider/track.dart';
import 'package:meta/meta.dart';

@internal
class SliderFormField extends FormField<FSliderSelection> with FFormFieldProperties<FSliderSelection> {
  final FSliderController controller;
  final BoxConstraints constraints;
  @override
  final Widget? label;
  @override
  final Widget? description;
  @override
  final Widget Function(BuildContext, String) errorBuilder;

  SliderFormField({
    required this.controller,
    required this.constraints,
    required this.label,
    required this.description,
    required this.errorBuilder,
    super.onSaved,
    super.validator,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  }) : super(
          builder: (field) {
            final state = field as _State;
            final InheritedData(:layout, :marks, :trackMainAxisExtent) = InheritedData.of(state.context);
            final style = InheritedData.of(state.context).style;
            final (labelState, stateStyle) = switch ((state.hasError, enabled)) {
              (false, true) => (FLabelState.enabled, style.enabledStyle),
              (false, false) => (FLabelState.disabled, style.disabledStyle),
              (true, _) => (FLabelState.error, style.errorStyle),
            };

            // DO NOT REORDER THE CHILDREN - _RenderSlider assumes this order.
            final children = [
              Padding(
                padding: style.labelLayoutStyle.childPadding,
                child: const Track(),
              ),
              if (label != null)
                DefaultTextStyle(
                  style: stateStyle.labelTextStyle,
                  child: Padding(
                    padding: style.labelLayoutStyle.labelPadding,
                    child: label,
                  ),
                )
              else
                const SizedBox(),
              if (description != null)
                DefaultTextStyle.merge(
                  style: stateStyle.descriptionTextStyle,
                  child: Padding(
                    padding: style.labelLayoutStyle.descriptionPadding,
                    child: description,
                  ),
                )
              else
                const SizedBox(),
              if (state.errorText != null)
                DefaultTextStyle.merge(
                  style: (stateStyle as FSliderErrorStyle).errorTextStyle,
                  child: Padding(
                    padding: style.labelLayoutStyle.errorPadding,
                    child: errorBuilder(state.context, state.errorText!),
                  ),
                )
              else
                const SizedBox(),
              for (final mark in marks.where((mark) => mark.label != null).toList())
                if (mark case FSliderMark(:final style, :final label?))
                  DefaultTextStyle(
                    style: (style ?? stateStyle.markStyle).labelTextStyle,
                    child: label,
                  ),
            ];

            return InheritedState(
              style: stateStyle,
              state: labelState,
              child: layout.vertical
                  ? VerticalSliderRenderObject(children: children)
                  : HorizontalSliderRenderObject(children: children),
            );
          },
        );

  @override
  FormFieldState<FSliderSelection> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder));
  }
}

class _State extends FormFieldState<FSliderSelection> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(covariant SliderFormField old) {
    super.didUpdateWidget(old);
    if (widget.controller == old.controller) {
      return;
    }

    widget.controller.addListener(_handleControllerChanged);
    old.controller.removeListener(_handleControllerChanged);
  }

  @override
  void didChange(FSliderSelection? value) {
    // This is not 100% accurate since a controller's selection can never be null. However, users will have to go out
    // of their way to obtain a FormFieldState<FSliderSelection> via a GlobalKey AND call didChange(null).
    assert(value != null, "A slider's selection cannot be null.");
    super.didChange(value);
    if (widget.controller.selection != value) {
      widget.controller.selection = value;
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    widget.controller.reset();
    super.reset();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we register this change listener. In these
    // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
    // reset() method. In such cases, the FormField value will already have been set.
    if (widget.controller.selection != value) {
      didChange(widget.controller.selection);
    }
  }

  @override
  SliderFormField get widget => super.widget as SliderFormField;
}

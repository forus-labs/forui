import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/inherited_data.dart';
import 'package:forui/src/widgets/slider/inherited_state.dart';
import 'package:forui/src/widgets/slider/slider_render_object.dart';
import 'package:forui/src/widgets/slider/track.dart';

@internal
class SliderFormField extends FormField<FSliderSelection> with FFormFieldProperties<FSliderSelection> {
  final FSliderController controller;
  final BoxConstraints constraints;
  @override
  final Widget? label;
  @override
  final Widget? description;

  SliderFormField({
    required this.controller,
    required this.constraints,
    required this.label,
    required this.description,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    super.onSaved,
    super.onReset,
    super.validator,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  }) : super(
         initialValue: controller.selection,
         errorBuilder: errorBuilder,
         builder: (field) {
           final state = field as _State;
           final InheritedData(:layout, :marks, :trackMainAxisExtent) = InheritedData.of(state.context);
           final style = InheritedData.of(state.context).style;
           final states = {if (!enabled) WidgetState.disabled, if (state.hasError) WidgetState.error};

           // DO NOT REORDER THE CHILDREN - _RenderSlider assumes this order.
           final children = [
             Padding(padding: style.childPadding, child: const Track()),
             if (label != null)
               DefaultTextStyle(
                 style: style.labelTextStyle.resolve(states),
                 child: Padding(padding: style.labelPadding, child: label),
               )
             else
               const SizedBox(),
             if (description != null)
               DefaultTextStyle.merge(
                 style: style.descriptionTextStyle.resolve(states),
                 child: Padding(padding: style.descriptionPadding, child: description),
               )
             else
               const SizedBox(),
             if (state.errorText != null)
               DefaultTextStyle.merge(
                 style: style.errorTextStyle,
                 child: Padding(padding: style.errorPadding, child: errorBuilder(state.context, state.errorText!)),
               )
             else
               const SizedBox(),
             for (final mark in marks.where((mark) => mark.label != null).toList())
               if (mark case FSliderMark(style: final markStyle, :final label?))
                 DefaultTextStyle(style: (markStyle ?? style.markStyle).labelTextStyle.resolve(states), child: label),
           ];

           return InheritedStates(
             states: states,
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
    if (widget.controller != old.controller) {
      widget.controller.addListener(_handleControllerChanged);
      old.controller.removeListener(_handleControllerChanged);
    }
  }

  @override
  void didChange(FSliderSelection? value) {
    // This is not 100% accurate since a controller's selection can never be null. However, users will have to go out
    // of their way to obtain a FormFieldState<FSliderSelection> via a GlobalKey AND call didChange(null).
    assert(value != null, "slider's selection cannot be null");
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

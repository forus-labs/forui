import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:forui/forui.dart';

/// Debug widget that prints constraints during layout
class ConstraintsPrinter extends SingleChildRenderObjectWidget {
  const ConstraintsPrinter({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) => RenderConstraintsPrinter();
}

class RenderConstraintsPrinter extends RenderProxyBox {
  @override
  void performLayout() {
    print('ConstraintsPrinter: $constraints');
    print('  - parent: $parent');
    print('  - parentData: $parentData');
    super.performLayout();
  }
}

/// Auto-expands when inside a Flex parent, otherwise does nothing. Uses ParentDataWidget but gracefully handles
/// non-Flex parents.
class AutoExpanded extends ParentDataWidget<ParentData> {
  final int flex;
  final FlexFit fit;

  const AutoExpanded({required super.child, super.key, this.flex = 1, this.fit = FlexFit.tight});

  // We use ParentData instead of FlexParentData to allow this widget to work with any parent, not just Flex. The
  // default implementation asserts T != ParentData to catch accidental misuse, but we're intentionally using the base
  // type to enable graceful degradation when not inside a Flex.
  @override
  bool debugIsValidRenderObject(RenderObject renderObject) => true;

  @override
  void applyParentData(RenderObject renderObject) {
    // Only apply if parent set up FlexParentData (i.e., parent is RenderFlex)
    if (renderObject.parentData case final FlexParentData parentData) {
      var needsLayout = false;

      if (parentData.flex != flex) {
        parentData.flex = flex;
        needsLayout = true;
      }
      if (parentData.fit != fit) {
        parentData.fit = fit;
        needsLayout = true;
      }

      if (needsLayout) {
        renderObject.parent?.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => Flex;
}

const features = ['Keyboard navigation', 'Typeahead suggestions', 'Tab to complete'];

const fruits = ['Apple', 'Banana', 'Orange', 'Grape', 'Strawberry', 'Pineapple'];

const letters = {
  'A': 'A',
  'B': 'B',
  'C': 'C',
  'D': 'D',
  'E': 'E',
  'F': 'F',
  'G': 'G',
  'H': 'H',
  'I': 'I',
  'J': 'J',
  'K': 'K',
  'L': 'L',
  'M': 'M',
  'N': 'N',
  'O': 'O',
};

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

enum Notification { all, direct, nothing, limitedTime, timeSensitive, selectedApps }

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: .min,
      children: [
        FTimeField(),
        FDateField(
          style: (style) => style.copyWith(
            fieldStyle: (fieldStyle) => fieldStyle.copyWith(
              contentTextStyle: fieldStyle.contentTextStyle
                  .replaceFirstWhere(
                    {WidgetState.focused},
                    (style) => style.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                  )
                  .replaceLastWhere({}, (style) => style.copyWith(color: Colors.blue)),
              // Modify the border based on widget state
              border: FWidgetStateMap({
                WidgetState.focused: fieldStyle.border.resolve({WidgetState.focused}).copyWith(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                WidgetState.any: fieldStyle.border.resolve({}),
              }),
            ),
          ),
        ),
        FAutocomplete(items: fruits),
        FSelect<String>(items: {for (final fruit in fruits) fruit: fruit}),
        FMultiSelect<String>(items: {for (final fruit in fruits) fruit: fruit}),
        FTextField.password(),
        FTextField(
          suffixBuilder: (_, style, states) => IconTheme(
            data: style.clearButtonStyle.iconContentStyle.iconStyle.resolve(states),
            child: Icon(Icons.search),
          ),
        ),
      ],
    ),
  );
}

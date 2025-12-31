import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forui/forui.dart';

const _overflows = {'Allow': FPortalOverflow.allow, 'Flip': FPortalOverflow.flip, 'Slide': FPortalOverflow.slide};

const _alignments = {
  'Top left': Alignment.topLeft,
  'Top center': Alignment.topCenter,
  'Top right': Alignment.topRight,
  'Center left': Alignment.centerLeft,
  'Center': Alignment.center,
  'Center right': Alignment.centerRight,
  'Bottom left': Alignment.bottomLeft,
  'Bottom center': Alignment.bottomCenter,
  'Bottom right': Alignment.bottomRight,
};

final _offsetFormatter = TextInputFormatter.withFunction((oldValue, newValue) {
  final text = newValue.text;
  if (text.isEmpty) {
    return newValue;
  }
  final value = int.tryParse(text);
  if (value == null || value < 0 || 300 <= value) {
    return oldValue;
  }

  return newValue;
});

final _dimensionFormatter = TextInputFormatter.withFunction((oldValue, newValue) {
  final text = newValue.text;
  if (text.isEmpty) {
    return newValue;
  }
  final value = int.tryParse(text);
  if (value == null || value <= 0 || 300 < value) {
    return oldValue;
  }

  return newValue;
});

final _spacingFormatter = TextInputFormatter.withFunction((oldValue, newValue) {
  final text = newValue.text;
  if (text.isEmpty) {
    return newValue;
  }
  final value = int.tryParse(text);
  if (value == null || value < 0 || 100 < value) {
    return oldValue;
  }

  return newValue;
});

class Value extends FChangeNotifier {
  Alignment _childAnchor;
  Size _childSize;
  Offset _childOffset;
  Alignment _portalAnchor;
  Size _portalSize;
  double _spacing;
  bool _diagonal;
  FPortalOverflow _overflow;

  Value({
    Alignment childAnchor = .bottomLeft,
    Size childSize = const Size(150, 150),
    Offset childOffset = const Offset(20, 30),
    Alignment portalAnchor = .topRight,
    Size portalSize = const Size(90, 90),
    double spacing = 4,
    bool diagonal = true,
    FPortalOverflow overflow = .flip,
  }) : _childAnchor = childAnchor,
       _childSize = childSize,
       _childOffset = childOffset,
       _portalAnchor = portalAnchor,
       _portalSize = portalSize,
       _spacing = spacing,
       _diagonal = diagonal,
       _overflow = overflow;

  Alignment get childAnchor => _childAnchor;

  set childAnchor(Alignment value) {
    _childAnchor = value;
    notifyListeners();
  }

  Size get childSize => _childSize;

  set childSize(Size value) {
    _childSize = value;
    notifyListeners();
  }

  Offset get childOffset => _childOffset;

  set childOffset(Offset value) {
    _childOffset = value;
    notifyListeners();
  }

  Alignment get portalAnchor => _portalAnchor;

  set portalAnchor(Alignment value) {
    _portalAnchor = value;
    notifyListeners();
  }

  Size get portalSize => _portalSize;

  set portalSize(Size value) {
    _portalSize = value;
    notifyListeners();
  }

  double get spacing => _spacing;

  set spacing(double value) {
    _spacing = value;
    notifyListeners();
  }

  bool get diagonal => _diagonal;

  set diagonal(bool value) {
    _diagonal = value;
    notifyListeners();
  }

  FPortalOverflow get overflow => _overflow;

  set overflow(FPortalOverflow value) {
    _overflow = value;
    notifyListeners();
  }
}

class Settings extends StatelessWidget {
  final Value value;

  const Settings({required this.value, super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const .all(8),
    child: Column(
      mainAxisSize: .min,
      children: [
        Expanded(
          child: FTabs(
            children: [
              FTabEntry(
                label: const Text('Child'),
                child: _ChildSettings(value: value),
              ),
              FTabEntry(
                label: const Text('Portal'),
                child: _PortalSettings(value: value),
              ),
            ],
          ),
        ),
        const FDivider(),
        FSelect<FPortalOverflow>(
          control: .managed(initial: value.overflow, onChange: (v) => value.overflow = v!),
          label: const Text('Overflow'),
          items: _overflows,
        ),
        const SizedBox(height: 10),
        FLabel(
          label: const Text('Spacing'),
          axis: .vertical,
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: FTextField(
                  control: .managed(
                    onChange: (v) => value.spacing = double.tryParse(v.text) ?? value.spacing,
                    initial: TextEditingValue(text: value.spacing.toStringAsFixed(0)),
                  ),
                  hint: 'Distance',
                  keyboardType: .number,
                  inputFormatters: [_spacingFormatter],
                ),
              ),
              Expanded(
                child: Row(
                  spacing: 4,
                  children: [
                    Text('Diagonal', style: context.theme.labelStyles.verticalStyle.labelTextStyle.resolve({})),
                    ListenableBuilder(
                      listenable: value,
                      builder: (context, _) => FSwitch(value: value.diagonal, onChange: (v) => value.diagonal = v),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _ChildSettings extends StatelessWidget {
  final Value value;

  const _ChildSettings({required this.value});

  @override
  Widget build(BuildContext context) => ListView(
    padding: .zero,
    shrinkWrap: true,
    children: [
      FSelect<Alignment>(
        control: .managed(initial: value.childAnchor, onChange: (v) => value.childAnchor = v!),
        label: const Text('Anchor'),
        contentConstraints: const FAutoWidthPortalConstraints(maxHeight: 350),
        items: _alignments,
      ),
      const SizedBox(height: 12),
      FLabel(
        label: const Text('Size'),
        axis: .vertical,
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: FTextField(
                control: .managed(
                  onChange: (v) =>
                      value.childSize = Size(double.tryParse(v.text) ?? value.childSize.width, value.childSize.height),
                  initial: TextEditingValue(text: value.childSize.width.toStringAsFixed(0)),
                ),
                hint: 'W',
                keyboardType: .number,
                inputFormatters: [_dimensionFormatter],
              ),
            ),
            Expanded(
              child: FTextField(
                control: .managed(
                  onChange: (v) =>
                      value.childSize = Size(value.childSize.width, double.tryParse(v.text) ?? value.childSize.height),
                  initial: TextEditingValue(text: value.childSize.height.toStringAsFixed(0)),
                ),
                hint: 'H',
                keyboardType: .number,
                inputFormatters: [_dimensionFormatter],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      FLabel(
        label: const Text('Position'),
        axis: .vertical,
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: FTextField(
                control: .managed(
                  onChange: (v) =>
                      value.childOffset = Offset(double.tryParse(v.text) ?? value.childOffset.dx, value.childOffset.dy),
                  initial: TextEditingValue(text: value.childOffset.dx.toStringAsFixed(0)),
                ),
                hint: 'X',
                keyboardType: .number,
                inputFormatters: [_offsetFormatter],
              ),
            ),
            Expanded(
              child: FTextField(
                control: .managed(
                  onChange: (v) =>
                      value.childOffset = Offset(value.childOffset.dx, double.tryParse(v.text) ?? value.childOffset.dy),
                  initial: TextEditingValue(text: value.childOffset.dy.toStringAsFixed(0)),
                ),
                hint: 'Y',
                keyboardType: .number,
                inputFormatters: [_offsetFormatter],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _PortalSettings extends StatelessWidget {
  final Value value;

  const _PortalSettings({required this.value});

  @override
  Widget build(BuildContext context) => ListView(
    padding: .zero,
    shrinkWrap: true,
    children: [
      FSelect<Alignment>(
        control: .managed(initial: value.portalAnchor, onChange: (v) => value.portalAnchor = v!),
        label: const Text('Anchor'),
        contentConstraints: const FAutoWidthPortalConstraints(maxHeight: 350),
        items: _alignments,
      ),
      const SizedBox(height: 12),
      FLabel(
        label: const Text('Size'),
        axis: .vertical,
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: FTextField(
                control: .managed(
                  onChange: (v) => value.portalSize = Size(
                    double.tryParse(v.text) ?? value.portalSize.width,
                    value.portalSize.height,
                  ),
                  initial: TextEditingValue(text: value.portalSize.width.toStringAsFixed(0)),
                ),
                hint: 'W',
                keyboardType: .number,
                inputFormatters: [_dimensionFormatter],
              ),
            ),
            Expanded(
              child: FTextField(
                control: .managed(
                  onChange: (v) => value.portalSize = Size(
                    value.portalSize.width,
                    double.tryParse(v.text) ?? value.portalSize.height,
                  ),
                  initial: TextEditingValue(text: value.portalSize.height.toStringAsFixed(0)),
                ),
                hint: 'H',
                keyboardType: .number,
                inputFormatters: [_dimensionFormatter],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

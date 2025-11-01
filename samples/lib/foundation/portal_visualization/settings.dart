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
  Offset Function(Size, FPortalChildRect, FPortalRect) _overflow;

  Value({
    Alignment childAnchor = Alignment.bottomLeft,
    Size childSize = const Size(150, 150),
    Offset childOffset = const Offset(20, 30),
    Alignment portalAnchor = Alignment.topRight,
    Size portalSize = const Size(90, 90),
    double spacing = 4,
    bool diagonal = true,
    Offset Function(Size, FPortalChildRect, FPortalRect) overflow = FPortalOverflow.flip,
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

  Offset Function(Size, FPortalChildRect, FPortalRect) get overflow => _overflow;

  set overflow(Offset Function(Size, FPortalChildRect, FPortalRect) value) {
    _overflow = value;
    notifyListeners();
  }
}

class Settings extends StatelessWidget {
  final Value value;

  const Settings({required this.value, super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
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
        FSelect<Offset Function(Size, FPortalChildRect, FPortalRect)>(
          label: const Text('Overflow'),
          items: _overflows,
          initialValue: value.overflow,
          onChange: (v) => value.overflow = v!,
        ),
        const SizedBox(height: 10),
        FLabel(
          label: const Text('Spacing'),
          axis: Axis.vertical,
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: FTextField(
                  hint: 'Distance',
                  keyboardType: TextInputType.number,
                  inputFormatters: [_spacingFormatter],
                  initialText: value.spacing.toStringAsFixed(0),
                  onChange: (v) => value.spacing = double.tryParse(v) ?? value.spacing,
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
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    children: [
      FSelect<Alignment>(
        label: const Text('Anchor'),
        popoverConstraints: const FAutoWidthPortalConstraints(maxHeight: 350),
        items: _alignments,
        initialValue: value.childAnchor,
        onChange: (v) => value.childAnchor = v!,
      ),
      const SizedBox(height: 12),
      FLabel(
        label: const Text('Size'),
        axis: Axis.vertical,
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: FTextField(
                hint: 'W',
                keyboardType: TextInputType.number,
                inputFormatters: [_dimensionFormatter],
                initialText: value.childSize.width.toStringAsFixed(0),
                onChange: (v) =>
                    value.childSize = Size(double.tryParse(v) ?? value.childSize.width, value.childSize.height),
              ),
            ),
            Expanded(
              child: FTextField(
                hint: 'H',
                keyboardType: TextInputType.number,
                inputFormatters: [_dimensionFormatter],
                initialText: value.childSize.height.toStringAsFixed(0),
                onChange: (v) =>
                    value.childSize = Size(value.childSize.width, double.tryParse(v) ?? value.childSize.height),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      FLabel(
        label: const Text('Position'),
        axis: Axis.vertical,
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: FTextField(
                hint: 'X',
                keyboardType: TextInputType.number,
                inputFormatters: [_offsetFormatter],
                initialText: value.childOffset.dx.toStringAsFixed(0),
                onChange: (v) =>
                    value.childOffset = Offset(double.tryParse(v) ?? value.childOffset.dx, value.childOffset.dy),
              ),
            ),
            Expanded(
              child: FTextField(
                hint: 'Y',
                keyboardType: TextInputType.number,
                inputFormatters: [_offsetFormatter],
                initialText: value.childOffset.dy.toStringAsFixed(0),
                onChange: (v) =>
                    value.childOffset = Offset(value.childOffset.dx, double.tryParse(v) ?? value.childOffset.dy),
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
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    children: [
      FSelect<Alignment>(
        label: const Text('Anchor'),
        popoverConstraints: const FAutoWidthPortalConstraints(maxHeight: 350),
        items: _alignments,
        initialValue: value.portalAnchor,
        onChange: (v) => value.portalAnchor = v!,
      ),
      const SizedBox(height: 12),
      FLabel(
        label: const Text('Size'),
        axis: Axis.vertical,
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: FTextField(
                hint: 'W',
                keyboardType: TextInputType.number,
                inputFormatters: [_dimensionFormatter],
                initialText: value.portalSize.width.toStringAsFixed(0),
                onChange: (v) =>
                    value.portalSize = Size(double.tryParse(v) ?? value.portalSize.width, value.portalSize.height),
              ),
            ),
            Expanded(
              child: FTextField(
                hint: 'H',
                keyboardType: TextInputType.number,
                inputFormatters: [_dimensionFormatter],
                initialText: value.portalSize.height.toStringAsFixed(0),
                onChange: (v) =>
                    value.portalSize = Size(value.portalSize.width, double.tryParse(v) ?? value.portalSize.height),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

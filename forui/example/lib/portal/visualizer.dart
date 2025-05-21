import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

const _size = Size(100, 100);
const _shifts = {FPortalShift.flip: 'flip', FPortalShift.along: 'along', FPortalShift.none: 'none'};

/// Visualizer for port shifting strategies
class Visualizer extends StatefulWidget {
  const Visualizer({super.key});

  @override
  State<Visualizer> createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {
  Offset Function(Size, FPortalChildBox, FPortalBox) _shift = FPortalShift.flip;
  Offset _childOffset = const Offset(20, 30);
  Offset _portalOffset = Offset.zero;
  Size _childSize = const Size(50, 50);
  Size _portalSize = const Size(30, 30);
  Alignment _childAnchor = Alignment.bottomLeft;
  Alignment _portalAnchor = Alignment.topRight;

  @override
  Widget build(BuildContext context) {
    final child = (offset: _childOffset, size: _childSize, anchor: _childAnchor);
    final portal = (offset: _portalOffset, size: _portalSize, anchor: _portalAnchor);
    final offset = _shift(_size, child, portal);

    return ListView(
      children: [
        Text("Shifted offset (relative to child's TL corner): $offset"),
        const SizedBox(height: 16),
        _Visualizer(
          childOffset: _childOffset,
          portalOffset: offset,
          childSize: _childSize,
          portalSize: _portalSize,
          childAnchor: _childAnchor,
          portalAnchor: _portalAnchor,
        ),
        const SizedBox(height: 16),
        FSelect<Offset Function(Size, FPortalChildBox, FPortalBox)>(
          label: const Text('Shift'),
          onChange: (closure) => setState(() => _shift = closure ?? _shift),
          format: (closure) => _shifts[closure]!,
          children: [for (final MapEntry(:key, :value) in _shifts.entries) FSelectItem(value: key, child: Text(value))],
        ),
        const SizedBox(height: 16),
        _Settings(
          header: 'Child',
          onOffsetXChange: (value) => setState(() => _childOffset = Offset(value, _childOffset.dy)),
          onOffsetYChange: (value) => setState(() => _childOffset = Offset(_childOffset.dx, value)),
          onSizeWChange: (value) => setState(() => _childSize = Size(value, _childSize.height)),
          onSizeHChange: (value) => setState(() => _childSize = Size(_childSize.width, value)),
          onAnchorChange: (alignment) => setState(() => _childAnchor = alignment ?? _childAnchor),
        ),
        const SizedBox(height: 16),
        _Settings(
          header: 'Portal',
          onOffsetXChange: (value) => setState(() => _portalOffset = Offset(value, _portalOffset.dy)),
          onOffsetYChange: (value) => setState(() => _portalOffset = Offset(_portalOffset.dx, value)),
          onSizeWChange: (value) => setState(() => _portalSize = Size(value, _portalSize.height)),
          onSizeHChange: (value) => setState(() => _portalSize = Size(_portalSize.width, value)),
          onAnchorChange: (alignment) => setState(() => _portalAnchor = alignment ?? _portalAnchor),
        ),
      ],
    );
  }
}

class _Visualizer extends StatelessWidget {
  final Offset childOffset;
  final Offset portalOffset;
  final Size childSize;
  final Size portalSize;
  final Alignment childAnchor;
  final Alignment portalAnchor;

  const _Visualizer({
    required this.childOffset,
    required this.portalOffset,
    required this.childSize,
    required this.portalSize,
    required this.childAnchor,
    required this.portalAnchor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: _size.width * 3,
        height: _size.height * 3,
        decoration: BoxDecoration(border: Border.all(), color: Colors.grey.shade200),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Child box
            Positioned(
              left: childOffset.dx * 3,
              top: childOffset.dy * 3,
              child: Container(
                width: childSize.width * 3,
                height: childSize.height * 3,
                decoration: BoxDecoration(color: Colors.yellow, border: Border.all()),
                child: Center(child: Text('Child\n${childAnchor.toString().replaceAll('Alignment.', '')}')),
              ),
            ),

            Positioned(
              left: (childOffset.dx + childAnchor.x * childSize.width / 2 + childSize.width / 2) * 3 - 5,
              top: (childOffset.dy + childAnchor.y * childSize.height / 2 + childSize.height / 2) * 3 - 5,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              ),
            ),

            // Portal box
            Positioned(
              left: (portalOffset.dx + childOffset.dx) * 3,
              top: (portalOffset.dy + childOffset.dy) * 3,
              child: Container(
                width: portalSize.width * 3,
                height: portalSize.height * 3,
                decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.7), border: Border.all()),
                child: Center(child: Text('Portal\n${portalAnchor.toString().replaceAll('Alignment.', '')}')),
              ),
            ),

            // Portal anchor point
            Positioned(
              left:
                  (portalOffset.dx + childOffset.dx + portalAnchor.x * portalSize.width / 2 + portalSize.width / 2) *
                      3 -
                  5,
              top:
                  (portalOffset.dy + childOffset.dy + portalAnchor.y * portalSize.height / 2 + portalSize.height / 2) *
                      3 -
                  5,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Settings extends StatelessWidget {
  final String header;
  final ValueChanged<double> onOffsetXChange;
  final ValueChanged<double> onOffsetYChange;
  final ValueChanged<double> onSizeWChange;
  final ValueChanged<double> onSizeHChange;
  final ValueChanged<Alignment?> onAnchorChange;

  const _Settings({
    required this.header,
    required this.onOffsetXChange,
    required this.onOffsetYChange,
    required this.onSizeWChange,
    required this.onSizeHChange,
    required this.onAnchorChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text('$header:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Expanded(
              child: FTextField(
                label: const Text('Offset X: '),
                keyboardType: TextInputType.number,
                onChange: (value) => onOffsetXChange(double.tryParse(value) ?? 0),
              ),
            ),
            Expanded(
              child: FTextField(
                label: const Text('Offset Y: '),
                keyboardType: TextInputType.number,
                onChange: (value) => onOffsetYChange(double.tryParse(value) ?? 0),
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Expanded(
              child: FTextField(
                label: const Text('Size W: '),
                keyboardType: TextInputType.number,
                onChange: (value) => onSizeWChange(double.tryParse(value) ?? 0),
              ),
            ),
            Expanded(
              child: FTextField(
                label: const Text('Size H: '),
                keyboardType: TextInputType.number,
                onChange: (value) => onSizeHChange(double.tryParse(value) ?? 0),
              ),
            ),
          ],
        ),
        FSelect<Alignment>(
          onChange: onAnchorChange,
          label: const Text('Anchor:'),
          children: [
            for (final anchor in [
              Alignment.topLeft,
              Alignment.topCenter,
              Alignment.topRight,
              Alignment.centerLeft,
              Alignment.center,
              Alignment.centerRight,
              Alignment.bottomLeft,
              Alignment.bottomCenter,
              Alignment.bottomRight,
            ])
              FSelectItem(value: anchor, child: Text(anchor.toString().replaceAll('Alignment.', ''))),
          ],
        ),
      ],
    );
  }
}

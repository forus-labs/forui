import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';
import 'package:docs_snippets/portal_visualization/settings.dart';

@RoutePage()
class PortalVisualizationPage extends StatefulExample {
  PortalVisualizationPage({@queryParam super.theme, super.maxWidth = 800});

  @override
  State<PortalVisualizationPage> createState() => _VisualizerState();
}

class _VisualizerState extends StatefulExampleState<PortalVisualizationPage> {
  final Value value = Value();

  @override
  Widget example(BuildContext context) => Padding(
    padding: const .all(8.0),
    child: Row(
      spacing: 4,
      children: [
        ListenableBuilder(
          listenable: value,
          builder: (context, _) {
            final child = (offset: value.childOffset, size: value.childSize, anchor: value.childAnchor);
            final spacingOffset = FPortalSpacing(
              value.spacing,
              diagonal: value.diagonal,
            ).call(value.childAnchor, value.portalAnchor);
            final portal = (offset: spacingOffset, size: value.portalSize, anchor: value.portalAnchor);
            final offset = value.overflow(Visualization.viewport, child, portal);

            return Visualization(
              childOffset: value.childOffset,
              portalOffset: value.childOffset + offset,
              childSize: value.childSize,
              portalSize: value.portalSize,
              childAnchor: value.childAnchor,
              portalAnchor: value.portalAnchor,
            );
          },
        ),
        Expanded(child: Settings(value: value)),
      ],
    ),
  );
}

class Visualization extends StatelessWidget {
  static const viewport = Size(300, 300);

  final Offset childOffset;
  final Offset portalOffset;
  final Size childSize;
  final Size portalSize;
  final Alignment childAnchor;
  final Alignment portalAnchor;

  const Visualization({
    required this.childOffset,
    required this.portalOffset,
    required this.childSize,
    required this.portalSize,
    required this.childAnchor,
    required this.portalAnchor,
  });

  @override
  Widget build(BuildContext context) => Container(
    clipBehavior: .hardEdge,
    decoration: BoxDecoration(
      border: .all(color: context.theme.colors.border),
      borderRadius: context.theme.style.borderRadius,
    ),
    padding: const .symmetric(horizontal: 75, vertical: 30),
    child: Center(
      child: Container(
        width: viewport.width,
        height: viewport.height,
        decoration: BoxDecoration(
          border: .all(color: context.theme.colors.border),
          color: context.theme.colors.muted,
        ),
        child: Stack(
          clipBehavior: .none,
          children: [
            Positioned(
              top: 8,
              left: 8,
              child: Text(
                'Viewport',
                style: context.theme.typography.xs.copyWith(
                  color: context.theme.colors.primary,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            _Rect(
              label: 'Child',
              offset: childOffset,
              size: childSize,
              anchor: childAnchor,
              background: context.theme.colors.background,
              foreground: context.theme.colors.foreground,
            ),
            _Rect(
              label: 'Portal',
              offset: portalOffset,
              size: portalSize,
              anchor: portalAnchor,
              background: context.theme.colors.primary,
              foreground: context.theme.colors.primaryForeground,
            ),
          ],
        ),
      ),
    ),
  );
}

class _Rect extends StatelessWidget {
  final String label;
  final Offset offset;
  final Size size;
  final Alignment anchor;
  final Color background;
  final Color foreground;

  const _Rect({
    required this.label,
    required this.offset,
    required this.size,
    required this.anchor,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) => Positioned(
    left: offset.dx,
    top: offset.dy,
    child: Stack(
      clipBehavior: .none,
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(color: background),
          child: Center(
            child: Padding(
              padding: const .all(8.0),
              child: Text(
                label,
                style: context.theme.typography.xs.copyWith(color: foreground, overflow: .ellipsis),
              ),
            ),
          ),
        ),
        Positioned(
          left: (size.width / 2) + (size.width / 2 * anchor.x) - 5,
          top: (size.height / 2) + (size.height / 2 * anchor.y) - 5,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              border: .all(color: background),
              color: foreground,
              shape: .circle,
            ),
          ),
        ),
      ],
    ),
  );
}

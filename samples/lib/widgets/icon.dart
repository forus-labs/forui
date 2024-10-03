import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

String path(String str) => kIsWeb ? 'assets/$str' : str;

@RoutePage()
class IconPage extends SampleScaffold {
  final String variant;

  IconPage({
    @queryParam super.theme,
    @queryParam this.variant = 'svg',
  });

  @override
  Widget child(BuildContext context) => IntrinsicWidth(
        child: FButton.icon(
          style: FButtonStyle.secondary,
          child: switch (variant) {
            'data' => const FIcon.data(Icons.wifi),
            _ => FIcon(FAssets.icons.wifi),
          },
          onPress: () {},
        ),
      );
}

@RoutePage()
class ComparisonIconPage extends SampleScaffold {
  ComparisonIconPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FButton.icon(
            style: FButtonStyle.primary,
            child: FIcon(FAssets.icons.bird),
            onPress: () {},
          ),
          const SizedBox(width: 10),
          FButton.icon(
            style: FButtonStyle.secondary,
            child: FIcon(FAssets.icons.bird),
            onPress: () {},
          ),
        ],
      );
}

@RoutePage()
class ImageIconPage extends SampleScaffold {
  ImageIconPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FButton.icon(
            style: FButtonStyle.primary,
            child: FIcon.image(AssetImage(path('forus-labs.png')), color: Colors.transparent),
            onPress: () {},
          ),
          const SizedBox(width: 10),
          FButton.icon(
            style: FButtonStyle.primary,
            child: FIcon.image(AssetImage(path('forus-labs.png'))),
            onPress: () {},
          ),
        ],
      );
}

@RoutePage()
class CustomIconPage extends SampleScaffold {
  CustomIconPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => IntrinsicWidth(
        child: FButton.icon(
          child: FIcon.raw(
            builder: (context, style, child) {
              final FButtonData(:enabled) = FButtonData.of(context);
              return enabled ? _Icon(style: style) : const FIcon.data(Icons.menu);
            },
          ),
          onPress: () {},
        ),
      );
}

class _Icon extends StatefulWidget {
  final FIconStyle style;

  const _Icon({required this.style});

  @override
  State<_Icon> createState() => _IconState();
}

class _IconState extends State<_Icon> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..forward()
      ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) => AnimatedIcon(
        icon: AnimatedIcons.home_menu,
        progress: animation,
        color: widget.style.color,
        size: widget.style.size,
        semanticLabel: 'Home menu',
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

String path(String str) => kIsWeb ? 'assets/$str' : str;

@RoutePage()
class IconPage extends Sample {
  final String variant;

  IconPage({@queryParam super.theme, @queryParam this.variant = 'svg'});

  @override
  Widget sample(BuildContext context) => IntrinsicWidth(
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
class ComparisonIconPage extends Sample {
  ComparisonIconPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FButton.icon(style: FButtonStyle.primary, child: FIcon(FAssets.icons.bird), onPress: () {}),
      const SizedBox(width: 10),
      FButton.icon(style: FButtonStyle.secondary, child: FIcon(FAssets.icons.bird), onPress: () {}),
    ],
  );
}

@RoutePage()
class ImageIconPage extends Sample {
  ImageIconPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FButton.icon(
        style: FButtonStyle.primary,
        child: FIcon.image(AssetImage(path('forus-labs.png')), color: Colors.transparent),
        onPress: () {},
      ),
      const SizedBox(width: 10),
      FButton.icon(style: FButtonStyle.primary, child: FIcon.image(AssetImage(path('forus-labs.png'))), onPress: () {}),
    ],
  );
}

@RoutePage()
class CustomIconPage extends StatefulSample {
  CustomIconPage({@queryParam super.theme});

  @override
  State<CustomIconPage> createState() => _CustomIconState();
}

class _CustomIconState extends StatefulSampleState<CustomIconPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward()
          ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget sample(BuildContext context) => IntrinsicWidth(
    child: FButton.icon(
      child: FIcon.raw(
        builder: (context, style, child) {
          final FButtonData(:states) = FButtonData.of(context);
          return states.contains(WidgetState.disabled)
              ? const FIcon.data(Icons.menu)
              : AnimatedIcon(
                icon: AnimatedIcons.home_menu,
                progress: animation,
                color: style.color,
                size: style.size,
                semanticLabel: 'Home menu',
              );
        },
      ),
      onPress: () {},
    ),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

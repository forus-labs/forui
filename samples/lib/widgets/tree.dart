import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TreePage extends Sample {
  final bool rtl;

  TreePage({@queryParam super.theme, @queryParam this.rtl = false});

  @override
  Widget sample(BuildContext context) {
    final tree = FTree(
      children: [
        FTreeItem(
          icon: const Icon(FIcons.folder),
          label: const Text('Level 1'),
          initiallyExpanded: true,
          children: [
            FTreeItem(
              icon: const Icon(FIcons.folder),
              label: const Text('Level 2'),
              initiallyExpanded: true,
              children: [
                FTreeItem(
                  icon: const Icon(FIcons.folder),
                  label: const Text('Level 3'),
                  initiallyExpanded: true,
                  children: [FTreeItem(icon: const Icon(FIcons.file), label: const Text('Deep File'), onPress: () {})],
                ),
              ],
            ),
          ],
        ),
      ],
    );

    return rtl ? Directionality(textDirection: TextDirection.rtl, child: tree) : tree;
  }
}

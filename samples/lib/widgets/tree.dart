import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TreePage extends Sample {
  TreePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FTree(
        children: [
          FTreeItem(
            icon: const Icon(FIcons.folder),
            label: const Text('Apple'),
            initiallyExpanded: true,
            children: [
              FTreeItem(
                icon: const Icon(FIcons.folder),
                label: const Text('Red Apple'),
                onPress: () {},
              ),
              FTreeItem(
                icon: const Icon(FIcons.folder),
                label: const Text('Green Apple'),
                onPress: () {},
              ),
            ],
          ),
          FTreeItem(
            icon: const Icon(FIcons.folder),
            label: const Text('Banana'),
            onPress: () {},
          ),
          FTreeItem(
            icon: const Icon(FIcons.folder),
            label: const Text('Cherry'),
            onPress: () {},
          ),
          FTreeItem(
            icon: const Icon(FIcons.file),
            label: const Text('Date'),
            selected: true,
            onPress: () {},
          ),
          FTreeItem(
            icon: const Icon(FIcons.folder),
            label: const Text('Elderberry'),
            onPress: () {},
          ),
          FTreeItem(
            icon: const Icon(FIcons.folder),
            label: const Text('Fig'),
            onPress: () {},
          ),
        ],
      );
}

import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class ItemGroupPage extends Sample {
  final FItemDivider divider;

  ItemGroupPage({@queryParam super.theme, @queryParam String divider = 'none'})
    : divider = switch (divider) {
        'indented' => .indented,
        'none' => .none,
        _ => .full,
      };

  @override
  Widget sample(BuildContext _) => FItemGroup(
    divider: divider,
    children: [
      FItem(
        prefix: const Icon(FIcons.user),
        title: const Text('Personalization'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      FItem(
        prefix: const Icon(FIcons.wifi),
        title: const Text('WiFi'),
        details: const Text('Forus Labs (5G)'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
    ],
  );
}

@RoutePage()
class ScrollableItemGroupPage extends Sample {
  ScrollableItemGroupPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FItemGroup(
    maxHeight: 150,
    children: [
      .item(
        prefix: const Icon(FIcons.user),
        title: const Text('Personalization'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      .item(
        prefix: const Icon(FIcons.mail),
        title: const Text('Mail'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      .item(
        prefix: const Icon(FIcons.wifi),
        title: const Text('WiFi'),
        details: const Text('Forus Labs (5G)'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      .item(
        prefix: const Icon(FIcons.alarmClock),
        title: const Text('Alarm Clock'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      .item(
        prefix: const Icon(FIcons.qrCode),
        title: const Text('QR code'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
    ],
  );
}

@RoutePage()
class LazyItemGroupPage extends Sample {
  LazyItemGroupPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FItemGroup.builder(
    maxHeight: 200,
    count: 200,
    itemBuilder: (context, index) =>
        FItem(title: Text('Item $index'), suffix: const Icon(FIcons.chevronRight), onPress: () {}),
  );
}

@RoutePage()
class MergeItemGroupPage extends Sample {
  MergeItemGroupPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FItemGroup.merge(
    children: [
      .group(
        children: [
          .item(
            prefix: const Icon(FIcons.user),
            title: const Text('Personalization'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
          .item(
            prefix: const Icon(FIcons.wifi),
            title: const Text('WiFi'),
            details: const Text('Forus Labs (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ],
      ),
      .group(
        children: [
          .item(
            prefix: const Icon(FIcons.list),
            title: const Text('List View'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
          .item(
            prefix: const Icon(FIcons.grid2x2),
            title: const Text('Grid View'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ],
      ),
    ],
  );
}

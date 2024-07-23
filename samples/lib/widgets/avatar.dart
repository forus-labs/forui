import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class AvatarPage extends SampleScaffold {
  AvatarPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FAvatar(
            size: 70,
            image: const AssetImage('avatar.png'),
            placeholderBuilder: (_) => const Text('MN'),
          ),
        ],
      );
}

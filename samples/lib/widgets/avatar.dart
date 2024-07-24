import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

final images = {
  'default': const NetworkImage('https://raw.githubusercontent.com/forus-labs/forui/main/samples/assets/avatar.png'),
  'error': const NetworkImage(''),
};

final placeholders = {'text': const Text('MN')};

@RoutePage()
class AvatarPage extends SampleScaffold {
  final ImageProvider image;
  final Widget? placeholder;

  AvatarPage({
    @queryParam super.theme,
    @queryParam String image = 'default',
    @queryParam String child = 'text',
  })  : image = images[image] ?? const NetworkImage(''),
        placeholder = placeholders[child];

  @override
  Widget child(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FAvatar(
            size: 70,
            image: image,
            placeholderBuilder: placeholder != null ? (_) => placeholder! : null,
          ),
        ],
      );
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

String path(String str) => kIsWeb ? 'assets/$str' : str;

@RoutePage()
class AvatarPage extends Sample {
  AvatarPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => Row(
    mainAxisAlignment: .center,
    spacing: 10,
    children: [
      FAvatar(image: AssetImage(path('avatar.png')), fallback: const Text('MN')),
      FAvatar(image: const AssetImage(''), fallback: const Text('MN')),
      FAvatar(image: const AssetImage('')),
    ],
  );
}

@RoutePage()
class AvatarRawPage extends Sample {
  AvatarRawPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Row(
    mainAxisAlignment: .center,
    spacing: 10,
    children: [
      FAvatar.raw(),
      FAvatar.raw(child: Icon(FIcons.baby, color: context.theme.colors.mutedForeground)),
      FAvatar.raw(child: const Text('MN')),
    ],
  );
}

@RoutePage()
class AvatarInvalidPage extends Sample {
  AvatarInvalidPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => Row(
    mainAxisAlignment: .center,
    spacing: 10,
    children: [
      FAvatar(image: const AssetImage(''), fallback: const Text('MN')),
      FAvatar(image: const AssetImage('')),
    ],
  );
}

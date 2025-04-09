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
  Widget sample(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FAvatar(image: AssetImage(path('avatar.png')), fallback: const Text('MN')),
      const SizedBox(width: 10),
      FAvatar(image: const AssetImage(''), fallback: const Text('MN')),
      const SizedBox(width: 10),
      FAvatar(image: const AssetImage('')),
    ],
  );
}

@RoutePage()
class AvatarRawPage extends Sample {
  AvatarRawPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FAvatar.raw(),
      const SizedBox(width: 10),
      FAvatar.raw(child: Icon(FIcons.baby, color: theme.colors.mutedForeground)),
      const SizedBox(width: 10),
      FAvatar.raw(child: const Text('MN')),
    ],
  );
}

@RoutePage()
class AvatarInvalidPage extends Sample {
  AvatarInvalidPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FAvatar(image: const AssetImage(''), fallback: const Text('MN')),
      const SizedBox(width: 10),
      FAvatar(image: const AssetImage('')),
    ],
  );
}

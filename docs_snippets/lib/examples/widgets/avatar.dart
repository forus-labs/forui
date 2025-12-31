import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

String path(String str) => kIsWeb ? 'assets/$str' : str;

@RoutePage()
class AvatarPage extends Example {
  AvatarPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => Row(
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
class AvatarRawPage extends Example {
  AvatarRawPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => Row(
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
class AvatarInvalidPage extends Example {
  AvatarInvalidPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => Row(
    mainAxisAlignment: .center,
    spacing: 10,
    children: [
      FAvatar(image: const AssetImage(''), fallback: const Text('MN')),
      FAvatar(image: const AssetImage('')),
    ],
  );
}

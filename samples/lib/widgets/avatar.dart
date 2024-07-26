import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

String path(String str) => kIsWeb ? 'assets/$str' : str;

@RoutePage()
class AvatarPage extends SampleScaffold {
  AvatarPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FAvatar(
            image: AssetImage(path('avatar.png')),
            fallback: const Text('MN'),
          ),
          const SizedBox(width: 10),
          FAvatar(
            image: const AssetImage(''),
            fallback: const Text('MN'),
          ),
          const SizedBox(width: 10),
          FAvatar(
            image: const AssetImage(''),
          ),
        ],
      );
}

@RoutePage()
class AvatarRawPage extends SampleScaffold {
  AvatarRawPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FAvatar.raw(),
          const SizedBox(width: 10),
          FAvatar.raw(
            child: FAssets.icons.baby(
              colorFilter: ColorFilter.mode(theme.colorScheme.mutedForeground, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 10),
          FAvatar.raw(child: const Text('MN')),
        ],
      );
}

@RoutePage()
class AvatarInvalidPage extends SampleScaffold {
  AvatarInvalidPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FAvatar(
            image: const AssetImage(''),
            fallback: const Text('MN'),
          ),
          const SizedBox(width: 10),
          FAvatar(
            image: const AssetImage(''),
          ),
        ],
      );
}

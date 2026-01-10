// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final avatar = FAvatar(
  // {@category "Core"}
  style: (style) => style,
  size: 40.0,
  image: const NetworkImage('https://example.com/avatar.png'),
  // {@endcategory}
  // {@category "Others"}
  fallback: const Text('AB'),
  semanticsLabel: 'User avatar',
  // {@endcategory}
);

final raw = FAvatar.raw(
  // {@category "Core"}
  style: (style) => style,
  size: 40.0,
  child: const Text('AB'),
  // {@endcategory}
);

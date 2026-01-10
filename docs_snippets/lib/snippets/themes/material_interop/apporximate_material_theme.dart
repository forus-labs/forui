import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

@override
Widget build(BuildContext context) => MaterialApp(
  // {@highlight}
  theme: FThemes.zinc.light.toApproximateMaterialTheme(),
  // {@endhighlight}
  home: Scaffold(
    body: Center(
      child: FCard(
        title: const Text('Mixed Widgets'),
        subtitle: const Text('Using both Forui and Material widgets together'),
        child: ElevatedButton(onPressed: () {}, child: const Text('Material Button')),
      ),
    ),
  ),
);

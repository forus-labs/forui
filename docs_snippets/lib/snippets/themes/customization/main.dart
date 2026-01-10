// ignore_for_file: always_use_package_imports, unused_import
// {@snippet}

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'theme/theme.dart';

// {@highlight}
// {@endhighlight}

// {@endsnippet}

final zincLight = FThemes.zinc.light;

// {@snippet}
void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    // Assign the generated theme to `theme`.
    // {@highlight}
    final theme = zincLight;
    // {@endhighlight}

    return MaterialApp(
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      // {@highlight}
      builder: (_, child) => FTheme(data: theme, child: child!),
      theme: theme.toApproximateMaterialTheme(),
      // {@endhighlight}
      home: const FScaffold(
        // TODO: replace with your widget.
        child: Placeholder(),
      ),
    );
  }
}

// {@endsnippet}

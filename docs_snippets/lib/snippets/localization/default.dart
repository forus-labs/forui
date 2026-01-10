import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

final app =
    // {@snippet constructor}
    MaterialApp(
      localizationsDelegates: const [
        // {@highlight}
        FLocalizations.delegate, // Add this line
        // {@endhighlight}
      ],
      supportedLocales: const [
        // {@highlight}
        // Add locales supported by your application here.
        // {@endhighlight}
      ],
      builder: (context, child) => FTheme(data: FThemes.zinc.light, child: child!),
      home: const FScaffold(child: Placeholder()),
    );
// {@endsnippet}

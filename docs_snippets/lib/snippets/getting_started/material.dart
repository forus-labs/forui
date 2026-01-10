import 'package:flutter/cupertino.dart';

import 'package:forui/forui.dart';

// {@highlight}
// {@endhighlight}

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  // {@highlight}
  Widget build(BuildContext context) => CupertinoApp(
    // {@endhighlight}
    builder: (context, child) => FTheme(data: FThemes.zinc.light, child: child!),
    home: const FScaffold(child: Placeholder()),
  );
}

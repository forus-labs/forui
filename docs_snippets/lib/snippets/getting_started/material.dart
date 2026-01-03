import 'package:flutter/cupertino.dart';

// {@highlight}
import 'package:forui/forui.dart';
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
    builder: (context, child) => FAnimatedTheme(data: FThemes.zinc.light, child: child!),
    home: const FScaffold(child: Placeholder()),
  );
}

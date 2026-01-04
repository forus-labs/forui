import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) => FAnimatedTheme(
  // {@highlight}
  data: FThemes.zinc.light, // or FThemes.zinc.dark
  // {@endhighlight}
  child: const FScaffold(child: Placeholder()),
);
// {@endsnippet}

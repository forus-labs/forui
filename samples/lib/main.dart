import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

void main() {
  runApp(const Application());
}

/// The application widget.
class Application extends StatelessWidget {
  /// Creates an application widget.
  const Application({super.key});
  
  @override
  Widget build(BuildContext context) => FTheme(
      data: FZincStyle.light,
      child: Container(),
    );
}

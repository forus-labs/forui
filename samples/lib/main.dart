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
  Widget build(BuildContext context) => MaterialApp(
        home: FTheme(
          data: FThemes.light,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  FCard(
                    title: 'Notification',
                    subtitle: 'You have 3 unread messages.',
                    child: const SizedBox(
                      width: double.infinity,
                      child: FBox(
                        text: 'BODY',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

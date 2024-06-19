import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class CardPage extends SampleScaffold {
  CardPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FCard(
        title: 'Notifications',
        subtitle: 'You have 3 unread messages.',
      ),
    ],
  );
}

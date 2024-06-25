import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class ScaffoldPage extends SampleScaffold {
  ScaffoldPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FScaffold(
        header: FHeader(
          title: 'Settings',
          actions: [
            FHeaderAction(
              icon: FAssets.icons.ellipsis,
              onPress: () {},
            ),
          ],
        ),
        content: ListView(
          children: [
            FCard(
              title: 'Account',
              subtitle: 'Make changes to your account here. Click save when you are done.',
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const FTextField(
                      label: 'Name',
                      hint: 'John Renalo',
                    ),
                    const SizedBox(height: 10),
                    const FTextField(
                      label: 'Email',
                      hint: 'john@doe.com',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 16),
                      child: FButton(
                        label: 'Save',
                        onPress: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

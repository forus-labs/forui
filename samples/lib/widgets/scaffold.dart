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
  Widget child(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          SizedBox(
            height: 420,
            child: FScaffold(
              header: FHeader(
                title: const Text('Settings'),
                actions: [
                  FHeaderAction(
                    icon: FAssets.icons.ellipsis,
                    onPress: () {},
                  ),
                ],
              ),
              content: Column(
                children: [
                  const SizedBox(height: 5),
                  FCard(
                    title: const Text('Account'),
                    subtitle: const Text('Make changes to your account here. Click save when you are done.'),
                    child: Column(
                      children: [
                        const FTextField(
                          label: Text('Name'),
                          hint: 'John Renalo',
                        ),
                        const SizedBox(height: 10),
                        const FTextField(
                          label: Text('Email'),
                          hint: 'john@doe.com',
                        ),
                        const SizedBox(height: 16),
                        FButton(
                          label: const Text('Save'),
                          onPress: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}

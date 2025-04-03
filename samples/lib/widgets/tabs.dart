import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TabsPage extends Sample {
  TabsPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(16),
        child: FTabs(
          children: [
            FTabEntry(
              label: const Text('Account'),
              child: FCard(
                title: const Text('Account'),
                subtitle: const Text('Make changes to your account here. Click save when you are done.'),
                child: Column(
                  children: [
                    const FTextField(label: Text('Name'), hint: 'John Renalo'),
                    const SizedBox(height: 10),
                    const FTextField(label: Text('Email'), hint: 'john@doe.com'),
                    const SizedBox(height: 16),
                    FButton(child: const Text('Save'), onPress: () {}),
                  ],
                ),
              ),
            ),
            FTabEntry(
              label: const Text('Password'),
              child: FCard(
                title: const Text('Password'),
                subtitle: const Text('Change your password here. After saving, you will be logged out.'),
                child: Column(
                  children: [
                    const FTextField(label: Text('Current password')),
                    const SizedBox(height: 10),
                    const FTextField(label: Text('New password')),
                    const SizedBox(height: 16),
                    FButton(child: const Text('Save'), onPress: () {}),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

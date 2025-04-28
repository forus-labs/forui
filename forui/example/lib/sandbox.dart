import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: FTabs(
            onChange: print,
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
              FTabEntry(
                label: const Text('Password 2'),
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
}

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

enum Notification { all, direct, nothing }

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FCalendarController<DateTime?> calendarController = FCalendarController.date();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const FTextField(
              label: Text('Username'),
              hint: 'JaneDoe',
              description: Text('Please enter your username.'),
              maxLines: 1,
            ),
            const SizedBox(height: 20),
            FBreadcrumb(
              children: [
                FBreadcrumbItem(onPress: () {}, child: const Text('Home')),
                FBreadcrumbItem.collapsed(
                  menu: [
                    FTileGroup(children: [
                      FTile(
                        title: const Text('Documentation'),
                        onPress: () {},
                      ),
                      FTile(
                        title: const Text('Themes'),
                        onPress: () {},
                      ),
                    ]),
                  ],
                ),
                FBreadcrumbItem(onPress: () {}, child: const Text('Categories')),
                FBreadcrumbItem(onPress: () {}, child: const Text('Search')),
                FBreadcrumbItem(onPress: () {}, current: true, child: const Text('Results')),
              ],
            ),
            const SizedBox(height: 20),
            const FLabel(
              axis: Axis.horizontal,
              label: Text('Label'),
              description: Text('Description'),
              error: Text('Error'),
              state: FLabelState.error,
              child: SizedBox(
                width: 200,
                height: 20,
                child: Placeholder(),
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    calendarController.dispose();
    super.dispose();
  }
}

class AForm extends StatelessWidget {
  final FLayout side;

  const AForm({required this.side, super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.background,
          border: side.vertical
              ? Border.symmetric(horizontal: BorderSide(color: context.theme.colorScheme.border))
              : Border.symmetric(vertical: BorderSide(color: context.theme.colorScheme.border)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account',
                  style: context.theme.typography.xl2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.theme.colorScheme.foreground,
                    height: 1.5,
                  ),
                ),
                Text(
                  'Make changes to your account here. Click save when you are done.',
                  style: context.theme.typography.sm.copyWith(
                    color: context.theme.colorScheme.mutedForeground,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 450,
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
                        onPress: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class SwitchPage extends SampleScaffold {
  final bool enabled;

  SwitchPage({
    @queryParam super.theme,
    @queryParam this.enabled = true,
  });

  @override
  Widget child(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 170),
            child: _Switch(
              initialValue: false,
              enabled: enabled,
            ),
          ),
        ],
      );
}

class _Switch extends StatefulWidget {
  final bool initialValue;
  final bool enabled;

  const _Switch({
    required this.initialValue,
    required this.enabled,
  });

  @override
  State<_Switch> createState() => _SwitchState();
}

class _SwitchState extends State<_Switch> {
  bool state = false;

  @override
  void initState() {
    super.initState();
    state = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) => FSwitch(
        label: const Text('Airplane Mode'),
        semanticLabel: 'Airplane Mode',
        value: state,
        onChange: (value) => setState(() => state = value),
        enabled: widget.enabled,
      );
}

class Page extends StatefulWidget {
  const Page();

  @override
  State<Page> createState() => PageState();
}

class PageState extends State<Page> {
  bool state = false;

  @override
  Widget build(BuildContext context) => FSwitch(
        label: const Text('Airplane Mode'),
        semanticLabel: 'Airplane Mode',
        value: state,
        onChange: (value) => setState(() => state = value),
      );
}

@RoutePage()
class FormSwitchPage extends SampleScaffold {
  FormSwitchPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const Padding(
        padding: EdgeInsets.all(15.0),
        child: NotificationForm(),
      );
}

class NotificationForm extends StatefulWidget {
  const NotificationForm({super.key});

  @override
  State<NotificationForm> createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email Notifications',
            style: theme.typography.xl2.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.foreground,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          FCard.raw(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Marketing Emails',
                          style: theme.typography.base.copyWith(
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.foreground,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          'Receive emails about new products, features, and more.',
                          style: theme.typography.sm.copyWith(color: theme.colorScheme.mutedForeground),
                        ),
                      ],
                    ),
                  ),
                  FormField(
                    initialValue: false,
                    onSaved: (value) {
                      // Save values somewhere.
                    },
                    validator: (value) => null, // No validation required.
                    builder: (state) => FSwitch(
                      value: state.value ?? false,
                      onChange: (value) => state.didChange(value),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          FCard.raw(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Security emails',
                          style: theme.typography.base.copyWith(
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.foreground,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          'Receive emails about your account security.',
                          style: theme.typography.sm.copyWith(color: theme.colorScheme.mutedForeground),
                        ),
                      ],
                    ),
                  ),
                  FormField(
                    initialValue: true,
                    onSaved: (value) {
                      // Save values somewhere.
                    },
                    validator: (value) => null, // No validation required.
                    builder: (state) => FSwitch(
                      value: state.value ?? false,
                      onChange: (value) => state.didChange(value),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          FButton(
            label: const Text('Submit'),
            onPress: () {
              if (!_formKey.currentState!.validate()) {
                // Handle errors here.
                return;
              }

              _formKey.currentState!.save();
              // Do something.
            },
          ),
        ],
      ),
    );
  }
}

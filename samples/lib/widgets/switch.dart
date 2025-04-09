import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class SwitchPage extends StatefulSample {
  final bool enabled;

  SwitchPage({@queryParam super.theme, @queryParam this.enabled = true, @queryParam super.maxWidth = 200});

  @override
  State<SwitchPage> createState() => _SwitchState();
}

class _SwitchState extends StatefulSampleState<SwitchPage> {
  bool state = false;

  @override
  Widget sample(BuildContext context) => FSwitch(
    label: const Text('Airplane Mode'),
    semanticsLabel: 'Airplane Mode',
    value: state,
    onChange: (value) => setState(() => state = value),
    enabled: widget.enabled,
  );
}

@RoutePage()
class FormSwitchPage extends StatefulSample {
  FormSwitchPage({@queryParam super.theme});

  @override
  State<FormSwitchPage> createState() => _FormSwitchState();
}

class _FormSwitchState extends StatefulSampleState<FormSwitchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget sample(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Notifications',
              style: theme.typography.xl2.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.foreground,
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
                              color: theme.colors.foreground,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            'Receive emails about new products, features, and more.',
                            style: theme.typography.sm.copyWith(color: theme.colors.mutedForeground),
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
                      builder:
                          (state) => FSwitch(value: state.value ?? false, onChange: (value) => state.didChange(value)),
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
                              color: theme.colors.foreground,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            'Receive emails about your account security.',
                            style: theme.typography.sm.copyWith(color: theme.colors.mutedForeground),
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
                      builder:
                          (state) => FSwitch(value: state.value ?? false, onChange: (value) => state.didChange(value)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            FButton(
              child: const Text('Submit'),
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
      ),
    );
  }
}

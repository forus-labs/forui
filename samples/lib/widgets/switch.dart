import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class SwitchPage extends StatefulSample {
  SwitchPage({@queryParam super.theme}) : super(maxWidth: 200);

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends StatefulSampleState<SwitchPage> {
  bool _state = false;

  @override
  Widget sample(BuildContext _) => FSwitch(
    label: const Text('Airplane Mode'),
    semanticsLabel: 'Airplane Mode',
    value: _state,
    onChange: (value) => setState(() => _state = value),
  );
}

@RoutePage()
class DisabledSwitchPage extends StatefulSample {
  DisabledSwitchPage({@queryParam super.theme}) : super(maxWidth: 200);

  @override
  State<DisabledSwitchPage> createState() => _DisabledSwitchPageState();
}

class _DisabledSwitchPageState extends StatefulSampleState<DisabledSwitchPage> {
  bool _state = false;

  @override
  Widget sample(BuildContext _) => FSwitch(
    label: const Text('Airplane Mode'),
    semanticsLabel: 'Airplane Mode',
    value: _state,
    onChange: (value) => setState(() => _state = value),
    // {@highlight}
    enabled: false,
    // {@endhighlight}
  );
}

@RoutePage()
class FormSwitchPage extends StatefulSample {
  FormSwitchPage({@queryParam super.theme}): super(top: 20);

  @override
  State<FormSwitchPage> createState() => _FormSwitchPageState();
}

class _FormSwitchPageState extends StatefulSampleState<FormSwitchPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget sample(BuildContext context) {
    final theme = context.theme;
    return Form(
      key: _key,
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .start,
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
              padding: const .fromLTRB(16, 12, 16, 16),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          'Marketing Emails',
                          style: theme.typography.base.copyWith(
                            fontWeight: .w500,
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
                    builder: (state) =>
                        FSwitch(value: state.value ?? false, onChange: (value) => state.didChange(value)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          FCard.raw(
            child: Padding(
              padding: const .fromLTRB(16, 12, 16, 16),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          'Security emails',
                          style: theme.typography.base.copyWith(
                            fontWeight: .w500,
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
                    builder: (state) =>
                        FSwitch(value: state.value ?? false, onChange: (value) => state.didChange(value)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          FButton(
            child: const Text('Submit'),
            onPress: () {
              if (!_key.currentState!.validate()) {
                // Handle errors here.
                return;
              }

              _key.currentState!.save();
              // Do something.
            },
          ),
        ],
      ),
    );
  }
}

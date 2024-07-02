import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class CheckboxPage extends SampleScaffold {
  final bool enabled;

  CheckboxPage({
    @queryParam super.theme,
    @queryParam this.enabled = false,
  });

  @override
  Widget child(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: FCheckbox(
          enabled: enabled,
        ),
      ),
    ],
  );
}

@RoutePage()
class FormCheckboxPage extends SampleScaffold {

  FormCheckboxPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const Padding(
    padding: EdgeInsets.all(15.0),
    child: LoginForm(),
  );

}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FTextField.email(
          hint: 'janedoe@foruslabs.com',
          help: const Text(''),
          validator: (value) => (value?.contains('@') ?? false) ? null : 'Please enter a valid email.',
        ),
        const SizedBox(height: 4),
        FTextField.password(
          hint: '',
          help: const Text(''),
          validator: (value) => 8 <= (value?.length ?? 0) ? null : 'Password must be at least 8 characters long.',
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const FCheckbox(),
            const SizedBox(width: 7),
            Text('Remember password?', style: context.theme.typography.sm),
          ],
        ),
        const SizedBox(height: 30),
        FButton(
          label: const Text('Login'),
          onPress: () => _formKey.currentState!.validate(),
        ),
      ],
    ),
  );
}

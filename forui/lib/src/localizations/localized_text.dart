import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

@internal
class LocalizedText extends StatelessWidget {
  static String _email(FLocalizations localizations) => localizations.textFieldEmailLabel;

  static String _password(FLocalizations localizations) => localizations.passwordFieldLabel;

  final String Function(FLocalizations) text;

  const LocalizedText._(this.text);

  const LocalizedText.email() : this._(_email);

  const LocalizedText.password() : this._(_password);

  @override
  Widget build(BuildContext context) => Text(text(FLocalizations.of(context) ?? FDefaultLocalizations()));

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('text', text));
  }
}

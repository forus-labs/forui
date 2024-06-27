
import 'package:flutter/material.dart';

class FTextFormField extends FormField<String> {

  FTextFormField({
    super.autovalidateMode,
  }): super(
    builder: (state)
  );

  @override
  FormFieldState<String> createState() => _State();

}

class _State extends FormFieldState<String> {

}

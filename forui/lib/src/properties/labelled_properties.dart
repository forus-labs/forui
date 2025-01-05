import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Properties for a labelled widget.
class FLabelledProperties with Diagnosticable {
  /// The default error builder.
  static Widget defaultErrorBuilder(BuildContext context, String error) => Text(error);

  /// The label.
  final Widget? label;

  /// The description.
  final Widget? description;

  /// The builder for errors displayed below the [description]. Defaults to displaying the error message.
  final Widget Function(BuildContext, String) errorBuilder;

  /// Creates a [FLabelledProperties].
  const FLabelledProperties({this.label, this.description, this.errorBuilder = defaultErrorBuilder});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('errorBuilder', errorBuilder));
  }
}

import 'package:flutter/foundation.dart';

final goodBoth = FlagProperty('good', value: true, ifTrue: 'good', ifFalse: 'bad');

final goodTrue = FlagProperty('good', value: true, ifTrue: 'good');

final goodFalse = FlagProperty('good', value: false, ifFalse: 'bad');

// expect_lint: always_provide_flag_property_parameter
final bad = FlagProperty('bad', value: false);



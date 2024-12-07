// ignore_for_file: unused_element

import 'package:meta/meta.dart';

typedef _Good = String;

@internal
typedef GoodSingle = String;

@internal
@visibleForTesting
typedef GoodMultiple = String;

typedef FGood = String;

// expect_lint: prefix_public_types
typedef Bad = String;

// expect_lint: prefix_public_types
typedef Fbad = String;


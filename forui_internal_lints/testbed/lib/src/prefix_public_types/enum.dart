// ignore_for_file: unused_element, unused_field

import 'package:meta/meta.dart';

enum _Good { foo }

@internal
enum GoodSingle { foo }

@internal
@visibleForTesting
enum GoodMultiple { foo }

enum FGood { foo }

// expect_lint: prefix_public_types
enum Bad { foo }

// expect_lint: prefix_public_types
enum Fbad { foo }

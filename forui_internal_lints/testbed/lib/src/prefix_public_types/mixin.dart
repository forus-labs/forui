// ignore_for_file: unused_element

import 'package:meta/meta.dart';

mixin _Good {}

@internal
mixin GoodSingle {}

@internal
@visibleForTesting
mixin GoodMultiple {}

mixin FGood {}

// expect_lint: prefix_public_types
mixin Bad {}

// expect_lint: prefix_public_types
mixin Fbad {}


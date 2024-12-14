// ignore_for_file: unused_element

import 'package:meta/meta.dart';

class _Good {}

@internal
class GoodSingle {}

@internal
@visibleForTesting
class GoodMultiple {}

class FGood {}

// expect_lint: prefix_public_types
class Bad {}

// expect_lint: prefix_public_types
class Fbad {}


// ignore_for_file: unused_element

import 'package:meta/meta.dart';

extension type _Good(int i) {}

@internal
extension type GoodSingle(int i) {}

@internal
@visibleForTesting
extension type GoodMultiple(int i) {}

extension type FGood(int i) {}

// expect_lint: prefix_public_types
extension type Bad(int i) {}

// expect_lint: prefix_public_types
extension type Fbad(int i) {}


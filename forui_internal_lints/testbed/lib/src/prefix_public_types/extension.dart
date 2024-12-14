// ignore_for_file: unused_element

import 'package:meta/meta.dart';

extension _Good on Never {}

@internal
extension GoodSingle on Never {}

@internal
@visibleForTesting
extension GoodMultiple on Never {}

extension FGood on Never {}

// expect_lint: prefix_public_types
extension Bad on Never {}

// expect_lint: prefix_public_types
extension Fbad on Never {}


import 'package:flutter/foundation.dart';

class FGood {
}

class FGoodStyle with Diagnosticable {
  FGoodStyle copyWith({required bool flag}) => this;

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => 0;
}

class FGoodStyles with Diagnosticable {
  FGoodStyles copyWith({required bool flag}) => this;

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => 0;
}

// expect_lint: style_api
class FBadStyle {
  FBadStyle copyWith({required bool flag}) => this;

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => 0;
}

// expect_lint: style_api
class FBadStyles {
  FBadStyles copyWith({required bool flag}) => this;

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => 0;
}

// expect_lint: style_api
class FBadCopyWithStyle with Diagnosticable {
  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => 0;
}

// expect_lint: style_api
class FBadCopyWithStyles with Diagnosticable {
  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => 0;
}

// expect_lint: style_api
class FBadEqualityStyle with Diagnosticable {
  FBadEqualityStyle copyWith({required bool flag}) => this;

  @override
  int get hashCode => 0;
}

// expect_lint: style_api
class FBadEqualityStyles with Diagnosticable {
  FBadEqualityStyles copyWith({required bool flag}) => this;

  @override
  int get hashCode => 0;
}

// expect_lint: style_api
class FBadHashCodeStyle with Diagnosticable {
  FBadHashCodeStyle copyWith({required bool flag}) => this;

  @override
  bool operator ==(Object other) => false;
}

// expect_lint: style_api
class FBadHashCodeStyles with Diagnosticable {
  FBadHashCodeStyles copyWith({required bool flag}) => this;

  @override
  bool operator ==(Object other) => false;
}
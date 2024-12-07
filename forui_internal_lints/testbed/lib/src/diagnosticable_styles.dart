import 'package:flutter/foundation.dart';

class FGood {}

class FGoodStyle with Diagnosticable {}

class FGoodStyles with Diagnosticable {}

// expect_lint: diagnosticable_styles
class FBadStyle {}

// expect_lint: diagnosticable_styles
class FBadStyles {}
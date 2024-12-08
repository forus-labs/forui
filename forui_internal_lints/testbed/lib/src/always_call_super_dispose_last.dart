import 'package:meta/meta.dart';

mixin _A {
  @mustCallSuper
  void dispose() {}
}

class _B with _A {
  @override
  void dispose() {
    super.dispose();
  }
}

class _Good extends _B {
  @override
  void dispose() {
    DateTime.now();
    super.dispose();
  }
}

class _Bad extends _B {
  @override
  void dispose() {
    // expect_lint: always_call_super_dispose_last
    super.dispose();
    DateTime.now();
  }
}
class _BadMultiple extends _B {
  @override
  void dispose() {
    // expect_lint: always_call_super_dispose_last
    super.dispose();
    DateTime.now();
    super.dispose();
  }
}

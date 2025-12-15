part of 'tabs.dart';

/// A controller that controls selection in a [FTabs].
final class FTabController extends FChangeNotifier {
  TabController _controller;
  FTabMotion _motion;

  /// Creates a [FTabController].
  FTabController({
    required int length,
    required TickerProvider vsync,
    int initial = 0,
    FTabMotion motion = const .new(),
  }) : this._(
         TabController(initialIndex: initial, length: length, animationDuration: motion.duration, vsync: vsync),
         motion,
       );

  FTabController._(this._controller, this._motion);

  void _update(int index, TickerProvider vsync, int length, FTabMotion motion, ValueChanged<int> onChange) {
    if (_motion != motion) {
      _controller.dispose();
      _controller = _ProxyController(
        initialIndex: index,
        length: length,
        animationDuration: motion.duration,
        vsync: vsync,
        onChange: onChange,
      );
      _motion = motion;
    } else {
      (_controller as _ProxyController)._update(index, onChange);
    }
  }

  /// Animates to the given [index].
  ///
  /// [curve] defaults to the [FTabMotion.curve] if not provided.
  void animateTo(int index, {Duration? duration, Curve? curve}) =>
      _controller.animateTo(index, duration: duration, curve: curve ?? _motion.curve);

  @override
  void addListener(VoidCallback listener) => _controller.addListener(listener);

  @override
  void notifyListeners() => _controller.notifyListeners();

  @override
  void removeListener(VoidCallback listener) => _controller.removeListener(listener);

  /// The index of the selected tab.
  int get index => _controller.index;

  set index(int value) => _controller.index = value;

  /// The number of tabs.
  int get length => _controller.length;

  @override
  bool get hasListeners => _controller.hasListeners;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ProxyController extends TabController {
  int _unsynced;
  ValueChanged<int> _onChange;

  _ProxyController({
    required super.length,
    required super.vsync,
    required ValueChanged<int> onChange,
    super.initialIndex,
    super.animationDuration,
  }) : _unsynced = initialIndex,
       _onChange = onChange;

  void _update(int index, ValueChanged<int> onChange) {
    _onChange = onChange;
    if (super.index != index) {
      _unsynced = index;
      super.animateTo(index);
    } else if (_unsynced != index) {
      _unsynced = index;
    }
  }

  @override
  void animateTo(int value, {Duration? duration, Curve curve = Curves.ease}) {
    _unsynced = value;
    _onChange(value);
  }

  @override
  set index(int value) {
    _unsynced = value;
    _onChange(value);
  }
}

/// Motion-related properties for [FTabs].
class FTabMotion with Diagnosticable, _$FTabMotionFunctions {
  /// The duration of the tab change animation. Defaults to 300 ms.
  @override
  final Duration duration;

  /// The curve of the tab change animation. Defaults to [Curves.easeOutCubic].
  @override
  final Curve curve;

  /// Creates a [FTabMotion].
  const FTabMotion({this.duration = const Duration(milliseconds: 300), this.curve = Curves.easeOutCubic});
}

/// A [FTabControl] defines how a [FTabs] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FTabControl with Diagnosticable, _$FTabControlMixin {
  /// Creates lifted state control.
  ///
  /// Tab index is controlled by the parent widget.
  ///
  /// The [index] parameter contains the current selected tab index.
  /// The [onChange] callback is invoked when the user selects a tab.
  const factory FTabControl.lifted({required int index, required ValueChanged<int> onChange, FTabMotion motion}) =
      _Lifted;

  /// Creates a [FTabControl].
  const factory FTabControl.managed({
    FTabController? controller,
    int? initial,
    FTabMotion? motion,
    ValueChanged<int>? onChange,
  }) = FTabManagedControl;

  const FTabControl._();

  (FTabController, bool) _update(
    FTabControl old,
    FTabController controller,
    VoidCallback callback,
    TickerProvider vsync,
    int length,
  );
}

/// A [FTabManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FTabManagedControl extends FTabControl with _$FTabManagedControlMixin {
  /// The controller.
  @override
  final FTabController? controller;

  /// The initial tab index. Defaults to 0.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final int? initial;

  /// The tab motion. Defaults to [FTabMotion].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [motion] and [controller] are both provided.
  @override
  final FTabMotion? motion;

  /// Called when the tab index changes.
  @override
  final ValueChanged<int>? onChange;

  /// Creates a [FTabControl].
  const FTabManagedControl({this.controller, this.initial, this.motion, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both controller and initial.'),
      assert(controller == null || motion == null, 'Cannot provide both controller and motion.'),
      super._();

  @override
  FTabController createController(TickerProvider vsync, int length) =>
      controller ?? .new(length: length, vsync: vsync, initial: initial ?? 0, motion: motion ?? const .new());
}

class _Lifted extends FTabControl with _$_LiftedMixin {
  @override
  final int index;
  @override
  final ValueChanged<int> onChange;
  @override
  final FTabMotion motion;

  const _Lifted({required this.index, required this.onChange, this.motion = const .new()}) : super._();

  @override
  FTabController createController(TickerProvider vsync, int length) => FTabController._(
    _ProxyController(
      length: length,
      vsync: vsync,
      initialIndex: index,
      onChange: onChange,
      animationDuration: motion.duration,
    ),
    motion,
  );

  @override
  void _updateController(FTabController controller, TickerProvider vsync, int length) =>
      controller._update(index, vsync, length, motion, onChange);
}

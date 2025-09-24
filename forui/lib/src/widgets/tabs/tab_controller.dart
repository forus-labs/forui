part of 'tabs.dart';

/// A controller that controls selection in a [FTabs].
final class FTabController extends FChangeNotifier {
  final TabController _controller;
  final Curve _curve;

  /// Creates a [FTabController].
  FTabController({
    required int length,
    required TickerProvider vsync,
    int initialIndex = 0,
    FTabMotion motion = const FTabMotion(),
  }) : _controller = TabController(
         initialIndex: initialIndex,
         length: length,
         animationDuration: motion.duration,
         vsync: vsync,
       ),
       _curve = motion.curve;

  /// Animates to the given [index].
  ///
  /// [curve] defaults to the [FTabMotion.curve] if not provided.
  void animateTo(int index, {Duration? duration, Curve? curve}) =>
      _controller.animateTo(index, duration: duration, curve: curve ?? _curve);

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

part of 'tabs.dart';

/// A controller that controls selection in a [FTabs].
final class FTabController extends FChangeNotifier {
  final TabController _controller;

  /// Creates a [FTabController].
  FTabController({
    required int length,
    required TickerProvider vsync,
    int initialIndex = 0,
    Duration? animationDuration,
  }) : _controller = TabController(
          initialIndex: initialIndex,
          length: length,
          animationDuration: animationDuration,
          vsync: vsync,
        );

  /// Animates to the given [index].
  void animateTo(
    int index, {
    Duration? duration,
    Curve curve = Curves.ease,
  }) {
    debugAssertNotDisposed();
    _controller.animateTo(index, duration: duration, curve: curve);
  }

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

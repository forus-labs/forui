part of 'tabs.dart';

/// An object that manages the state required by [TabBar] and its views.
class FTabController implements Listenable {
  final TabController _controller;

  /// Creates a [FTabs].
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

  @override
  void addListener(VoidCallback listener) {
    _controller.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _controller.removeListener(listener);
  }

  /// Discards any resources used by the object. After this is called, the
  /// object is not in a usable state and should be discarded (calls to
  /// [addListener] will throw after the object is disposed).
  ///
  /// This method should only be called by the object's owner.
  ///
  /// This method does not notify listeners, and clears the listener list once
  /// it is called. Consumers of this class must decide on whether to notify
  /// listeners or not immediately before disposal.
  void dispose() {
    _controller.dispose();
  }
}

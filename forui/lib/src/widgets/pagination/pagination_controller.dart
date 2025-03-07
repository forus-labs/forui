import 'dart:math';

import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A controller that controls which page is selected.
class FPaginationController extends FChangeNotifier {
  /// The number of sibling pages displayed beside the current page number. Defaults to 1.
  ///
  /// This value determines how many pages are shown on either side of the
  /// currently selected page in the pagination.
  ///
  /// For example, if `siblings` is 2 and the current page is 5,
  /// the displayed pages would be 3, 4, 5, 6, and 7.
  ///
  /// # Contract:
  /// * Throws [AssertionError] if [siblings] < 0.
  final int siblings;

  /// Whether to show the first and last pages in the pagination. Defaults to `true`.
  ///
  /// If `true`, the pagination will always display the first and last page, regardless of the current page.
  /// This can be useful for allowing users to quickly navigate to the beginning or end of the paginated content.
  final bool showEdges;

  late final PageController _controller;
  final int _pages;
  int _page;

  /// Creates a [FPaginationController].
  ///
  /// # Contract:
  /// * Throws [AssertionError] if 1 <= [initialPage] and [initialPage] <= length.
  FPaginationController({
    int pages = 0,
    int initialPage = 0,
    this.showEdges = true,
    this.siblings = 1,
    ScrollControllerCallback? onAttach,
    ScrollControllerCallback? onDetach,
    bool keepPage = true,
    double viewportFraction = 1.0,
  }) : assert(0 < pages, 'The total length of pages should be more than 0, but is $pages.'),
       assert(0 <= siblings, 'The siblingLength should be non-negative, but is $siblings'),
       assert(
         0 <= initialPage && initialPage < pages,
         'The initial page must be greater than or equal to 0 and less than or equal to length.',
       ),
       _page = initialPage,
       _pages = pages {
    _controller = PageController(
      initialPage: initialPage,
      keepPage: keepPage,
      viewportFraction: viewportFraction,
      onAttach: onAttach,
      onDetach: onDetach,
    )..addListener(_handleScrollChanges);
  }

  void _handleScrollChanges() {
    if (hasClients) {
      if (_controller.page case final page when page!.round() != _page) {
        _page = page.round();

        notifyListeners();
      }
    }
  }

  /// Returns whether the controller has clients (i.e., it is attached to a [PageView]),
  bool get hasClients => _controller.hasClients;

  /// Returns the [PageController] instance.
  PageController get controller => _controller;

  /// Returns the total number of pages in the pagination.
  ///
  /// If the controller has clients (i.e., it is attached to a [PageView]),
  /// the length is dynamically computed using the scroll extents and viewport dimensions.
  ///
  /// If not attached to any clients, it returns the predefined `_length`, which defaults to 0.
  num get pages {
    if (hasClients && _controller.position.hasContentDimensions) {
      final position = _controller.position;
      final len =
          max(0, position.maxScrollExtent - position.minScrollExtent) /
          max(1.0, position.viewportDimension * _controller.viewportFraction);
      if (len.isFinite) {
        return len.ceil() + 1;
      } else {
        return len;
      }
    } else {
      return _pages;
    }
  }

  /// Moves to the previous page if the current page is greater than 1.
  void previous() {
    final value = hasClients && _controller.page != null ? _controller.page!.round() : _page;
    if (0 < value) {
      if (hasClients) {
        _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
      } else {
        _page = value - 1;
        notifyListeners();
      }
    }
  }

  /// Moves to the next page if the current page is less than the total number of pages.
  void next() {
    final value = hasClients && _controller.page != null ? _controller.page!.round() : _page;
    if (value < pages - 1) {
      if (hasClients) {
        _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
      } else {
        _page = value + 1;
        notifyListeners();
      }
    }
  }

  /// Returns the current page index.
  int get page => _page;

  /// Sets the current page index.
  set page(int index) {
    if (0 <= index && index <= pages) {
      if (hasClients) {
        _controller.jumpToPage(index);
      } else {
        _page = index;
        notifyListeners();
      }
    } else {
      throw StateError('The index must be within the allowed range.');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Calculates the range of page numbers to display around the current page.
  ///
  /// Returns a tuple of the start and end page numbers by centering the range around the current page,
  /// ensuring a balanced display of sibling pages on either side while considering pagination constraints.
  (int, int) calculateSiblingRange() {
    final int rangeStart;
    final int rangeEnd;
    if (pages.isFinite) {
      final last = pages.toInt() - 1;
      if (pages <= minPagesDisplayedAtEdges) {
        return (0, last);
      }
      rangeStart = switch (_page) {
        _ when _page - siblings < 0 => 0,
        _ when _page > (last - minPagesDisplayedAtEdges) => (last - minPagesDisplayedAtEdges) - siblings,
        _ when _page <= minPagesDisplayedAtEdges => 0,
        _ => _page - siblings,
      };

      rangeEnd = switch (_page) {
        _ when _page + siblings > last => last,
        _ when _page < minPagesDisplayedAtEdges + 1 => minPagesDisplayedAtEdges + siblings,
        _ when _page >= (last - minPagesDisplayedAtEdges) => last,
        _ => _page + siblings,
      };
    } else {
      rangeStart = switch (_page) {
        _ when _page - siblings < 0 => 0,
        _ when _page <= minPagesDisplayedAtEdges => 0,
        _ => _page - siblings,
      };

      rangeEnd = switch (_page) {
        _ when _page < minPagesDisplayedAtEdges + 1 => minPagesDisplayedAtEdges,
        _ => _page + siblings,
      };
    }
    return (rangeStart, rangeEnd);
  }
}

@internal
extension MinPagesDisplayedAtEdges on FPaginationController {
  /// Returns the minimum number of pages to display at both the start and end of the pagination.
  ///
  /// If the total number of pages is too small to accommodate both the edge pages
  /// and the full set of sibling pages around the current page, all pages are displayed instead.
  int get minPagesDisplayedAtEdges {
    if (pages.isFinite) {
      final len = pages.toInt();
      final minDisplayedAtEnds = siblings + 1 + (showEdges ? 1 : 0);
      return len <= (minDisplayedAtEnds + (siblings * 2 + 2)) ? len : minDisplayedAtEnds;
    }
    return siblings + 1 + (showEdges ? 1 : 0);
  }
}

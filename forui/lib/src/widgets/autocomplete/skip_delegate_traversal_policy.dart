import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A [FocusTraversalPolicy] that delegates to another policy but skips [FocusScopeNode] descendants that have no
/// traversal descendants themselves.
@internal
class SkipDelegateTraversalPolicy with Diagnosticable implements FocusTraversalPolicy {
  final FocusTraversalPolicy _delegate;

  SkipDelegateTraversalPolicy(this._delegate);

  @override
  TraversalRequestFocusCallback get requestFocusCallback => _delegate.requestFocusCallback;

  @override
  FocusNode? findFirstFocus(FocusNode currentNode, {bool ignoreCurrentFocus = false}) =>
      _delegate.findFirstFocus(currentNode, ignoreCurrentFocus: ignoreCurrentFocus);

  @override
  FocusNode findLastFocus(FocusNode currentNode, {bool ignoreCurrentFocus = false}) =>
      _delegate.findLastFocus(currentNode, ignoreCurrentFocus: ignoreCurrentFocus);

  @override
  FocusNode? findFirstFocusInDirection(FocusNode currentNode, TraversalDirection direction) =>
      _delegate.findFirstFocusInDirection(currentNode, direction);

  @override
  void invalidateScopeData(FocusScopeNode node) => _delegate.invalidateScopeData(node);

  @override
  void changedScope({FocusNode? node, FocusScopeNode? oldScope}) =>
      _delegate.changedScope(node: node, oldScope: oldScope);

  @override
  bool next(FocusNode currentNode) => _delegate.next(currentNode);

  @override
  bool previous(FocusNode currentNode) => _delegate.previous(currentNode);

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) =>
      _delegate.inDirection(currentNode, direction);

  @override
  Iterable<FocusNode> sortDescendants(Iterable<FocusNode> descendants, FocusNode currentNode) =>
      _delegate.sortDescendants(
        descendants.where((descendant) => descendant is! FocusScopeNode || descendant.traversalDescendants.isNotEmpty),
        currentNode,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    return _delegate.debugFillProperties(properties);
  }
}

// ignore_for_file: prefer_asserts_with_message, diagnostic_describe_all_properties

import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart' hide Matrix4;
import 'package:flutter/scheduler.dart';

import 'package:meta/meta.dart';
import 'package:vector_math/vector_math_64.dart';

import 'package:forui/src/foundation/portal/composited_child.dart';

/// An object that a [ChildLayer] can register with. It links a [ChildLayer] to one or more [PortalLayer]s.
///
/// ## Implementation details:
/// This class is a copy of [LayerLink] with the only differences being:
/// * Contains a [ChildLayer] instead of [LeaderLayer].
@internal
class ChildLayerLink {
  /// Stores the previous leaders that were replaced by the current [_childLayer] in the current frame.
  ///
  /// These leaders need to give up their leaderships of this link by the end of the current frame.
  Set<ChildLayer>? _debugPreviousLeaders;
  bool _debugLeaderCheckScheduled = false;
  ChildLayer? _childLayer;

  void _registerLeader(ChildLayer childLayer) {
    assert(_childLayer != childLayer);
    assert(() {
      if (_childLayer != null) {
        _debugPreviousLeaders ??= {};
        _debugScheduleLeadersCleanUpCheck();
        return _debugPreviousLeaders!.add(_childLayer!);
      }
      return true;
    }());
    _childLayer = childLayer;
  }

  void _unregisterLeader(ChildLayer childLayer) {
    if (_childLayer == childLayer) {
      _childLayer = null;
    } else {
      assert(_debugPreviousLeaders!.remove(childLayer));
    }
  }

  /// Schedules the check as post frame callback to make sure the [_debugPreviousLeaders] is empty.
  void _debugScheduleLeadersCleanUpCheck() {
    assert(_debugPreviousLeaders != null);
    assert(() {
      if (_debugLeaderCheckScheduled) {
        return true;
      }
      _debugLeaderCheckScheduled = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _debugLeaderCheckScheduled = false;
        assert(_debugPreviousLeaders!.isEmpty);
      }, debugLabel: 'LayerLink.leadersCleanUpCheck');
      return true;
    }());
  }

  /// The total size of the content of the connected [ChildLayer].
  ///
  /// Generally this should be set by the [RenderObject] that paints on the registered [ChildLayer] (for instance a
  /// [RenderChildLayer] that shares this link with its followers). This size may be outdated before and during layout.
  Size? childSize;

  ChildLayer? get childLayer => _childLayer;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) =>
      '${describeIdentity(this)}(${_childLayer != null ? "<linked>" : "<dangling>"})';
}

/// A composited layer that can be followed by a [PortalLayer].
///
/// ## Implementation details:
/// This class is a copy of [LeaderLayer] with the following enhancements:
/// * Contains both local & global offsets.
@internal
class ChildLayer extends ContainerLayer {
  ChildLayerLink _link;
  Offset _globalOffset;
  Offset _localOffset;

  ChildLayer({required ChildLayerLink link, required Offset globalOffset, required Offset localOffset})
    : _link = link,
      _globalOffset = globalOffset,
      _localOffset = localOffset;

  @override
  void attach(Object owner) {
    super.attach(owner);
    _link._registerLeader(this);
  }

  @override
  void detach() {
    _link._unregisterLeader(this);
    super.detach();
  }

  @override
  bool findAnnotations<S extends Object>(AnnotationResult<S> result, Offset localPosition, {required bool onlyFirst}) =>
      super.findAnnotations<S>(result, localPosition - localOffset, onlyFirst: onlyFirst);

  @override
  void addToScene(ui.SceneBuilder builder) {
    if (localOffset != Offset.zero) {
      engineLayer = builder.pushTransform(
        Matrix4.translationValues(localOffset.dx, localOffset.dy, 0.0).storage,
        oldLayer: engineLayer as ui.TransformEngineLayer?,
      );
    } else {
      engineLayer = null;
    }
    addChildrenToScene(builder);
    if (localOffset != Offset.zero) {
      builder.pop();
    }
  }

  /// Applies the transform that would be applied when compositing the given
  /// child to the given matrix.
  ///
  /// See [ContainerLayer.applyTransform] for details.
  ///
  /// The `child` argument may be null, as the same transform is applied to all
  /// children.
  @override
  void applyTransform(Layer? child, Matrix4 transform) {
    if (localOffset != Offset.zero) {
      transform.translate(localOffset.dx, localOffset.dy);
    }
  }

  /// The link which connects this [ChildLayer] to one or more [PortalLayer]s.
  ChildLayerLink get link => _link;

  set link(ChildLayerLink value) {
    if (_link == value) {
      return;
    }

    if (attached) {
      _link._unregisterLeader(this);
      value._registerLeader(this);
    }

    _link = value;
  }

  Offset get globalOffset => _globalOffset;

  set globalOffset(Offset value) {
    if (_globalOffset == value) {
      return;
    }

    _globalOffset = value;
    if (!alwaysNeedsAddToScene) {
      markNeedsAddToScene();
    }
  }

  Offset get localOffset => _localOffset;

  set localOffset(Offset value) {
    if (_localOffset == value) {
      return;
    }

    _localOffset = value;
    if (!alwaysNeedsAddToScene) {
      markNeedsAddToScene();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('link', link))
      ..add(DiagnosticsProperty('globalOffset', globalOffset))
      ..add(DiagnosticsProperty('localOffset', localOffset));
  }
}

/// A composited layer that applies a transformation matrix to its children such that they are positioned to follow a
/// [ChildLayer].
///
/// ## Implementation details:
/// This class is a copy of [LayerLink] with the only differences being:
/// * Contains a [ChildLayerLink] instead of [LayerLink]
@internal
class PortalLayer extends ContainerLayer {
  /// Creates a follower layer.
  ///
  /// The [unlinkedOffset], [linkedOffset], and [showWhenUnlinked] properties
  /// must be non-null before the compositing phase of the pipeline.
  PortalLayer({
    required this.link,
    this.showWhenUnlinked = true,
    this.unlinkedOffset = Offset.zero,
    this.linkedOffset = Offset.zero,
  });

  /// The link to the [ChildLayer].
  ///
  /// The same object should be provided to a [ChildLayer] that is earlier in
  /// the layer tree. When this layer is composited, it will apply a transform
  /// that moves its children to match the position of the [ChildLayer].
  ChildLayerLink link;

  /// Whether to show the layer's contents when the [link] does not point to a
  /// [ChildLayer].
  ///
  /// When the layer is linked, children layers are positioned such that they
  /// have the same global position as the linked [ChildLayer].
  ///
  /// When the layer is not linked, then: if [showWhenUnlinked] is true,
  /// children are positioned as if the [FollowerLayer] was a [ContainerLayer];
  /// if it is false, then children are hidden.
  ///
  /// The [showWhenUnlinked] property must be non-null before the compositing
  /// phase of the pipeline.
  bool? showWhenUnlinked;

  /// Offset from parent in the parent's coordinate system, used when the layer
  /// is not linked to a [ChildLayer].
  ///
  /// The scene must be explicitly recomposited after this property is changed
  /// (as described at [Layer]).
  ///
  /// The [unlinkedOffset] property must be non-null before the compositing
  /// phase of the pipeline.
  ///
  /// See also:
  ///
  ///  * [linkedOffset], for when the layers are linked.
  Offset? unlinkedOffset;

  /// Offset from the origin of the leader layer to the origin of the child
  /// layers, used when the layer is linked to a [ChildLayer].
  ///
  /// The scene must be explicitly recomposited after this property is changed
  /// (as described at [Layer]).
  ///
  /// The [linkedOffset] property must be non-null before the compositing phase
  /// of the pipeline.
  ///
  /// See also:
  ///
  ///  * [unlinkedOffset], for when the layer is not linked.
  Offset? linkedOffset;

  Offset? _lastOffset;
  Matrix4? _lastTransform;
  Matrix4? _invertedTransform;
  bool _inverseDirty = true;

  Offset? _transformOffset(Offset localPosition) {
    if (_inverseDirty) {
      _invertedTransform = Matrix4.tryInvert(getLastTransform()!);
      _inverseDirty = false;
    }
    if (_invertedTransform == null) {
      return null;
    }
    final vector = Vector4(localPosition.dx, localPosition.dy, 0.0, 1.0);
    final result = _invertedTransform!.transform(vector);
    return Offset(result[0] - linkedOffset!.dx, result[1] - linkedOffset!.dy);
  }

  @override
  bool findAnnotations<S extends Object>(AnnotationResult<S> result, Offset localPosition, {required bool onlyFirst}) {
    if (link.childLayer == null) {
      if (showWhenUnlinked!) {
        return super.findAnnotations(result, localPosition - unlinkedOffset!, onlyFirst: onlyFirst);
      }
      return false;
    }
    final Offset? transformedOffset = _transformOffset(localPosition);
    if (transformedOffset == null) {
      return false;
    }
    return super.findAnnotations<S>(result, transformedOffset, onlyFirst: onlyFirst);
  }

  /// The transform that was used during the last composition phase.
  ///
  /// If the [link] was not linked to a [ChildLayer], or if this layer has
  /// a degenerate matrix applied, then this will be null.
  ///
  /// This method returns a new [Matrix4] instance each time it is invoked.
  Matrix4? getLastTransform() {
    if (_lastTransform == null) {
      return null;
    }
    final Matrix4 result = Matrix4.translationValues(-_lastOffset!.dx, -_lastOffset!.dy, 0.0)
      ..multiply(_lastTransform!);
    return result;
  }

  /// Call [applyTransform] for each layer in the provided list.
  ///
  /// The list is in reverse order (deepest first). The first layer will be
  /// treated as the child of the second, and so forth. The first layer in the
  /// list won't have [applyTransform] called on it. The first layer may be
  /// null.
  static Matrix4 _collectTransformForLayerChain(List<ContainerLayer?> layers) {
    // Initialize our result matrix.
    final Matrix4 result = Matrix4.identity();
    // Apply each layer to the matrix in turn, starting from the last layer,
    // and providing the previous layer as the child.
    for (int index = layers.length - 1; index > 0; index -= 1) {
      layers[index]?.applyTransform(layers[index - 1], result);
    }
    return result;
  }

  /// Find the common ancestor of two layers [a] and [b] by searching towards
  /// the root of the tree, and append each ancestor of [a] or [b] visited along
  /// the path to [ancestorsA] and [ancestorsB] respectively.
  ///
  /// Returns null if [a] [b] do not share a common ancestor, in which case the
  /// results in [ancestorsA] and [ancestorsB] are undefined.
  static Layer? _pathsToCommonAncestor(
    Layer? a,
    Layer? b,
    List<ContainerLayer?> ancestorsA,
    List<ContainerLayer?> ancestorsB,
  ) {
    // No common ancestor found.
    if (a == null || b == null) {
      return null;
    }

    if (identical(a, b)) {
      return a;
    }

    if (a.depth < b.depth) {
      ancestorsB.add(b.parent);
      return _pathsToCommonAncestor(a, b.parent, ancestorsA, ancestorsB);
    } else if (a.depth > b.depth) {
      ancestorsA.add(a.parent);
      return _pathsToCommonAncestor(a.parent, b, ancestorsA, ancestorsB);
    }

    ancestorsA.add(a.parent);
    ancestorsB.add(b.parent);
    return _pathsToCommonAncestor(a.parent, b.parent, ancestorsA, ancestorsB);
  }

  bool _debugCheckLeaderBeforeFollower(
    List<ContainerLayer> leaderToCommonAncestor,
    List<ContainerLayer> followerToCommonAncestor,
  ) {
    if (followerToCommonAncestor.length <= 1) {
      // Follower is the common ancestor, ergo the leader must come AFTER the follower.
      return false;
    }
    if (leaderToCommonAncestor.length <= 1) {
      // Leader is the common ancestor, ergo the leader must come BEFORE the follower.
      return true;
    }

    // Common ancestor is neither the leader nor the follower.
    final ContainerLayer leaderSubtreeBelowAncestor = leaderToCommonAncestor[leaderToCommonAncestor.length - 2];
    final ContainerLayer followerSubtreeBelowAncestor = followerToCommonAncestor[followerToCommonAncestor.length - 2];

    Layer? sibling = leaderSubtreeBelowAncestor;
    while (sibling != null) {
      if (sibling == followerSubtreeBelowAncestor) {
        return true;
      }
      sibling = sibling.nextSibling;
    }
    // The follower subtree didn't come after the leader subtree.
    return false;
  }

  /// Populate [_lastTransform] given the current state of the tree.
  void _establishTransform() {
    _lastTransform = null;
    final leader = link.childLayer;
    // Check to see if we are linked.
    if (leader == null) {
      return;
    }
    // If we're linked, check the link is valid.
    assert(leader.owner == owner, 'Linked ChildLayer anchor is not in the same layer tree as the FollowerLayer.');

    // Stores [leader, ..., commonAncestor] after calling _pathsToCommonAncestor.
    final List<ContainerLayer> forwardLayers = <ContainerLayer>[leader];
    // Stores [this (follower), ..., commonAncestor] after calling
    // _pathsToCommonAncestor.
    final List<ContainerLayer> inverseLayers = <ContainerLayer>[this];

    final Layer? ancestor = _pathsToCommonAncestor(leader, this, forwardLayers, inverseLayers);
    assert(ancestor != null, 'ChildLayer and FollowerLayer do not have a common ancestor.');
    assert(
      _debugCheckLeaderBeforeFollower(forwardLayers, inverseLayers),
      'ChildLayer anchor must come before FollowerLayer in paint order, but the reverse was true.',
    );

    final Matrix4 forwardTransform = _collectTransformForLayerChain(forwardLayers);
    // Further transforms the coordinate system to a hypothetical child (null)
    // of the leader layer, to account for the leader's additional paint offset
    // and layer offset (ChildLayer.offset).
    leader.applyTransform(null, forwardTransform);
    forwardTransform.translate(linkedOffset!.dx, linkedOffset!.dy);

    final Matrix4 inverseTransform = _collectTransformForLayerChain(inverseLayers);

    if (inverseTransform.invert() == 0.0) {
      // We are in a degenerate transform, so there's not much we can do.
      return;
    }
    // Combine the matrices and store the result.
    inverseTransform.multiply(forwardTransform);
    _lastTransform = inverseTransform;
    _inverseDirty = true;
  }

  /// {@template flutter.rendering.FollowerLayer.alwaysNeedsAddToScene}
  /// This disables retained rendering.
  ///
  /// A [FollowerLayer] copies changes from a [ChildLayer] that could be anywhere
  /// in the Layer tree, and that leader layer could change without notifying the
  /// follower layer. Therefore we have to always call a follower layer's
  /// [addToScene]. In order to call follower layer's [addToScene], leader layer's
  /// [addToScene] must be called first so leader layer must also be considered
  /// as [alwaysNeedsAddToScene].
  /// {@endtemplate}
  @override
  bool get alwaysNeedsAddToScene => true;

  @override
  void addToScene(ui.SceneBuilder builder) {
    assert(showWhenUnlinked != null);
    if (link.childLayer == null && !showWhenUnlinked!) {
      _lastTransform = null;
      _lastOffset = null;
      _inverseDirty = true;
      engineLayer = null;
      return;
    }
    _establishTransform();
    if (_lastTransform != null) {
      _lastOffset = unlinkedOffset;
      engineLayer = builder.pushTransform(_lastTransform!.storage, oldLayer: engineLayer as ui.TransformEngineLayer?);
      addChildrenToScene(builder);
      builder.pop();
    } else {
      _lastOffset = null;
      final Matrix4 matrix = Matrix4.translationValues(unlinkedOffset!.dx, unlinkedOffset!.dy, .0);
      engineLayer = builder.pushTransform(matrix.storage, oldLayer: engineLayer as ui.TransformEngineLayer?);
      addChildrenToScene(builder);
      builder.pop();
    }
    _inverseDirty = true;
  }

  @override
  void applyTransform(Layer? child, Matrix4 transform) {
    assert(child != null);
    if (_lastTransform != null) {
      transform.multiply(_lastTransform!);
    } else {
      transform.multiply(Matrix4.translationValues(unlinkedOffset!.dx, unlinkedOffset!.dy, 0));
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('link', link))
      ..add(TransformProperty('transform', getLastTransform(), defaultValue: null));
  }
}

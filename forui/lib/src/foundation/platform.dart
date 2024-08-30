import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

@internal
/// The platforms that are primarily touch enabled. It isn't 100% accurate but it is a good approximation.
const touchPlatforms = { TargetPlatform.android, TargetPlatform.iOS, TargetPlatform.fuchsia };

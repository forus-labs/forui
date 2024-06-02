/// A Flutter package for building beautiful user interfaces.
library forui;

// Theme
export 'src/theme/color_scheme.dart';
export 'src/theme/style.dart';
export 'src/theme/theme.dart';
export 'src/theme/theme_data.dart';

export 'src/theme/font.dart';

// Themes
export 'src/theme/themes.dart';

// Widgets
export 'src/widgets/box.dart';
export 'src/widgets/badge/badge.dart' hide FBadgeContent;
export 'src/widgets/button/tappable.dart' hide FTappable;
export 'src/widgets/button/button.dart' hide FButtonContent;
export 'src/widgets/card/card.dart' hide FCardContent;
export 'src/widgets/separator.dart';

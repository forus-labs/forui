import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class ButtonPrimaryPage extends Sample {
  ButtonPrimaryPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FButton(
    // {@highlight}
    style: FButtonStyle.primary(),
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonSecondaryPage extends Sample {
  ButtonSecondaryPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FButton(
    // {@highlight}
    style: FButtonStyle.secondary(),
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonDestructivePage extends Sample {
  ButtonDestructivePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FButton(
    // {@highlight}
    style: FButtonStyle.destructive(),
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonGhostPage extends Sample {
  ButtonGhostPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FButton(
    // {@highlight}
    style: FButtonStyle.ghost(),
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonOutlinePage extends Sample {
  ButtonOutlinePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FButton(
    // {@highlight}
    style: FButtonStyle.outline(),
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonIconPage extends Sample {
  ButtonIconPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FButton(
    mainAxisSize: .min,
    // {@highlight}
    prefix: const Icon(FIcons.mail),
    // {@endhighlight}
    onPress: () {},
    child: const Text('Login with Email'),
  );
}

@RoutePage()
class ButtonOnlyIconPage extends Sample {
  ButtonOnlyIconPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FButton.icon(child: const Icon(FIcons.chevronRight), onPress: () {});
}

@RoutePage()
class ButtonCircularProgressPage extends Sample {
  ButtonCircularProgressPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FButton(
    mainAxisSize: .min,
    // {@highlight}
    prefix: const FCircularProgress(),
    // {@endhighlight}
    onPress: null,
    child: const Text('Please wait'),
  );
}

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class ButtonPrimaryPage extends Example {
  ButtonPrimaryPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(
    // {@highlight}
    style: FButtonStyle.primary(),
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonSecondaryPage extends Example {
  ButtonSecondaryPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(
    // {@highlight}
    style: FButtonStyle.secondary(),
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonDestructivePage extends Example {
  ButtonDestructivePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(
    // {@highlight}
    style: FButtonStyle.destructive(),
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonGhostPage extends Example {
  ButtonGhostPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(
    // {@highlight}
    style: FButtonStyle.ghost(),
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonOutlinePage extends Example {
  ButtonOutlinePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(
    // {@highlight}
    style: FButtonStyle.outline(),
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonIconPage extends Example {
  ButtonIconPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(
    mainAxisSize: .min,
    // {@highlight}
    prefix: const Icon(FIcons.mail),
    // {@endhighlight}
    onPress: () {},
    child: const Text('Login with Email'),
  );
}

@RoutePage()
class ButtonOnlyIconPage extends Example {
  ButtonOnlyIconPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton.icon(child: const Icon(FIcons.chevronRight), onPress: () {});
}

@RoutePage()
class ButtonCircularProgressPage extends Example {
  ButtonCircularProgressPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(
    mainAxisSize: .min,
    // {@highlight}
    prefix: const FCircularProgress(),
    // {@endhighlight}
    onPress: null,
    child: const Text('Please wait'),
  );
}

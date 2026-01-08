<a href="https://forui.dev">
  <h1 align="center">
    <picture>
      <source width="400" media="(prefers-color-scheme: dark)" srcset="docs/public/logos/dark_logo.png">
      <img width="400" alt="Forui" src="docs/public/logos/light_logo.png">
    </picture>
  </h1>
</a>

<p align="center">
  <a href="https://github.com/duobaseio/forui/actions/workflows/forui_build.yaml"><img alt="GitHub Actions Workflow Status" src="https://img.shields.io/github/actions/workflow/status/duobaseio/forui/forui_build.yaml?branch=main&style=flat&logo=github&label=main"></a>
  <a href="https://codecov.io/gh/duobaseio/forui" ><img src="https://codecov.io/gh/duobaseio/forui/branch/main/graph/badge.svg?token=YxGxA8Ydmg"/></a>
  <a href="https://pub.dev/packages/forui"><img alt="Pub Version" src="https://img.shields.io/pub/v/forui?style=flat&logo=dart&label=pub.dev&color=00589B"></a>
  <a href="https://github.com/duobaseio/forui"><img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/duobaseio/forui?style=flat&logo=github&color=8957e5&link=https%3A%2F%2Fgithub.com%2Fduobaseio%2Fforui"></a>
  <a href="https://discord.gg/jrw3qHksjE"><img alt="Discord" src="https://img.shields.io/discord/1268920771062009886?logo=discord&logoColor=fff&label=discord&color=%237289da"></a>
</p>

<p align="center">
  <a href="https://forui.dev/docs">📚 Documentation</a> •
  <a href="https://forui.dev/docs/layout/divider">🖼️ Widgets</a> •
  <a href="https://pub.dev/documentation/forui">🤓 API Reference</a> •
  <a href="https://github.com/orgs/duobaseio/projects/4">🗺️ Road Map</a>
</p>

<p align="center">
  Forui is a Flutter UI library that provides a set of beautifully designed, minimalistic widgets.
</p>

<br />
<div align="center">
 <img width="800" alt="Forui" src="docs/public/banners/banner-160724.png">
</div>

> [!IMPORTANT]
> Forui 0.15.0+ requires Flutter **3.35.0+**. Run `flutter --version` to check your Flutter version.

## Why Choose Forui?

* 🎨 Over 40+ beautifully crafted widgets.
* ⚡ Bundled [CLI](https://forui.dev/docs/themes#customize-themes) to generate themes & styling boilerplate.
* ✅ [Well-tested](https://app.codecov.io/gh/duobaseio/forui).
* 🌍 I10n support.
* 🪝 First-class [Flutter Hooks](https://pub.dev/packages/flutter_hooks) integration via [`forui_hooks`](https://pub.dev/packages/forui_hooks).

## Documentation

Visit [forui.dev/docs](https://forui.dev/docs) to view the documentation.

## Flutter Hooks Integration

<a href="https://github.com/duobaseio/forui/actions/workflows/forui_hooks_build.yaml"><img alt="GitHub Actions Workflow Status" src="https://img.shields.io/github/actions/workflow/status/duobaseio/forui/forui_hooks_build.yaml?branch=main&style=flat&logo=github&label=forui_hooks"></a>
<a href="https://pub.dev/packages/forui_hooks"><img alt="Pub Version" src="https://img.shields.io/pub/v/forui_hooks?style=flat&logo=dart&label=pub.dev: forui_hooks&color=00589B"></a>

Forui provides first class integration with [Flutter Hooks](https://pub.dev/packages/flutter_hooks). All controllers
are exposed as hooks in the companion `forui_hooks` package.

## Contributing

Please read the [contributing guide](/CONTRIBUTING.md).

## Nightly Builds

Nightly builds are available on the `nightly` branch. To use the latest nightly build, add the following to your `pubspec.yaml`:

```yaml
dependencies:
  forui:
    git:
      url: https://github.com/duobaseio/forui.git
      ref: nightly
      path: forui
```

Nightly builds are not guaranteed to be stable. Use at your own risk.


## License

Code is licensed under the [MIT License](LICENSE). Fonts are licensed under [Open Font License](LICENSE). Icons are licensed under [ISC License](https://github.com/duobaseio/forui/blob/main/LICENSE).

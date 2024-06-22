import {DocsThemeConfig, useTheme} from 'nextra-theme-docs'
import {useRouter} from "next/router";
import Logo from "./components/logo";

const config: DocsThemeConfig = {
  logo: <Logo />,
  head: (
      <>
        <link rel="icon" href="/favicon.ico" type="image/x-icon" sizes="any"/>
      </>
  ),
  useNextSeoProps() {
    const {asPath} = useRouter();

    if (asPath == '/') {
      return {
        title: 'Forui - Minimalistic Flutter UI Library',
      };
    }

    return {
      titleTemplate: '%s – Forui'
    };
  },
  project: {
    link: 'https://github.com/forus-labs/forui',
  },
  docsRepositoryBase: 'https://github.com/forus-labs/forui/tree/master/docs',
  navigation: {
    prev: true,
    next: true
  },
  footer: {
    text: 'A Forus Labs initiative.',
  }
}

export default config

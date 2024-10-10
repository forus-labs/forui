import { DocsThemeConfig, useConfig, useTheme } from 'nextra-theme-docs';
import {useRouter} from "next/router";
import Logo from "./components/logo";

const config: DocsThemeConfig = {
  logo: <Logo />,
  head() {
    const { asPath } = useRouter();
    const config = useConfig();

    let title = 'Forui - Minimalistic Flutter UI Library';

    if (asPath != '/') {
      title = `${config.title} – Forui`;
    }

    return (
      <>
        <link rel="icon" href="/favicon.ico" type="image/x-icon" sizes="any"/>
        <title>{title}</title>
      </>
    );
  },
  project: {
    link: 'https://github.com/forus-labs/forui',
  },
  docsRepositoryBase: 'https://github.com/forus-labs/forui/tree/main/docs',
  navigation: {
    prev: true,
    next: true
  },
  footer: {
    content: 'A Forus Labs initiative.',
  }
}

export default config;

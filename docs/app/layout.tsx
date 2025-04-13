import { Footer, Layout, Navbar } from 'nextra-theme-docs';
import { Banner, Head } from 'nextra/components';
import { getPageMap } from 'nextra/page-map';
import Logo from '@/components/ui/logo';

import 'nextra-theme-docs/style.css';
import './globals.css';

export const metadata = {
  title: {
    template: '%s – Forui',
  },
  icons: {
    icon: '/favicon.ico',
  },
};

const banner = <Banner storageKey="some-key">Forui 0.11.0 is released 🎉</Banner>;
const navbar = (
  <Navbar logo={<Logo />} projectLink="https://github.com/forus-labs/forui" chatLink="https://discord.gg/jrw3qHksjE" />
);
const footer = <Footer>A Forus Labs initiative.</Footer>;

export default async function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html
      // Not required, but good for SEO
      lang="en"
      // Required to be set
      dir="ltr"
      // Suggested by `next-themes` package https://github.com/pacocoursey/next-themes#with-app
      suppressHydrationWarning
    >
      <Head
      // ... Your additional head options
      >
        {/* Your additional tags should be passed as `children` of `<Head>` element */}
      </Head>
      <body>
        <Layout
          banner={banner}
          navbar={navbar}
          pageMap={await getPageMap()}
          docsRepositoryBase="https://github.com/forus-labs/forui/tree/main/docs"
          footer={footer}
          // ... Your additional layout options
        >
          {children}
        </Layout>
      </body>
    </html>
  );
}

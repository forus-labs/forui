import type { BaseLayoutProps } from 'fumadocs-ui/layouts/shared';
import { BookIcon } from 'lucide-react';
import { Logo } from '../components/logo';

export function baseOptions(): BaseLayoutProps {
  return {
    nav: {
      title: <Logo />,
    },
    links: [
      {
        text: 'Documentation',
        url: '/docs',
        secondary: false,
      },
      {
        text: 'Enterprise',
        url: '/enterprise',
        secondary: false,
      },
      {
        type: 'icon',
        label: 'Visit Blog', // `aria-label`
        icon: <BookIcon />,
        text: 'Blog',
        url: '/blog',
      },
    ],
  };
}

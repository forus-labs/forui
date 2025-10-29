'use client';

import { useTheme } from 'nextra-theme-docs';
import dynamic from 'next/dynamic';

interface Props {
  name: string;
  variant?: string;
  height?: number;
  query?: Record<string, string>;
}

function Component({ name, variant = 'default', height = 200, query = {} }: Props) {
  const { resolvedTheme } = useTheme();
  query['theme'] = `zinc-${resolvedTheme}`;

  const url = process.env['NEXT_PUBLIC_DEMO_URL'];

  return (
    <iframe
      className="w-full border rounded dark:border-neutral-400/20"
      style={{ height: `${height}px` }}
      src={`${url}/${name}/${variant}?${new URLSearchParams(query).toString()}`}
    />
  );
}

export const Widget = dynamic(() => Promise.resolve(Component), {
  ssr: false
});

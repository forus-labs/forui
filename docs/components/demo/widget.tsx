'use client';

import { useTheme } from 'nextra-theme-docs';
import dynamic from 'next/dynamic';
import { useState, useEffect } from 'react';
import { fetchDemoUrl } from '@/lib/utils';

interface Props {
  name: string;
  variant?: string;
  height?: number;
  query?: Record<string, string>;
}

function Component({ name, variant = 'default', height = 200, query = {} }: Props) {
  const { resolvedTheme } = useTheme();
  const [demoUrl, setDemoUrl] = useState<string | null>(null);

  useEffect(() => {
    fetchDemoUrl().then(setDemoUrl);
  }, []);

  query['theme'] = `zinc-${resolvedTheme}`;

  if (!demoUrl) {
    return null;
  }

  return (
    <iframe
      className="w-full border rounded dark:border-neutral-400/20"
      style={{ height: `${height}px` }}
      src={`${demoUrl}/${name}/${variant}?${new URLSearchParams(query).toString()}`}
    />
  );
}

export const Widget = dynamic(() => Promise.resolve(Component), {
  ssr: false,
});

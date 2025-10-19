'use client';

import { useTheme } from 'nextra-theme-docs';
import Image from 'next/image';
import dynamic from 'next/dynamic';

interface Props {
  className?: string;
}

function Logo({ className = 'w-24 h-auto' }: Props) {
  const { resolvedTheme } = useTheme();

  return (
    <Image
      src={resolvedTheme === 'dark' ? '/dark_logo.svg' : '/light_logo.svg'}
      className={className}
      width={0}
      height={0}
      alt="Forui"
    />
  );
}

export default dynamic(() => Promise.resolve(Logo), {
  ssr: false,
});

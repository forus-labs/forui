'use client';

import Image from 'next/image';
import { useTheme } from 'next-themes';

interface LogoProps {
  className?: string;
}

export function Logo({ className = 'w-24 h-auto' }: LogoProps) {
  const { resolvedTheme } = useTheme();

  return (
    <Image
      src={resolvedTheme === 'dark' ? '/dark_logo.svg' : '/light_logo.svg'}
      className={className}
      width={0}
      height={0}
      alt="Forui Logo"
    />
  );
}

'use client';

import { useEffect, useState } from 'react';
import Image from 'next/image';
import { useTheme } from 'next-themes';

interface LogoProps {
  className?: string;
}

export function Logo({ className = 'w-24 h-auto' }: LogoProps) {
  const { resolvedTheme } = useTheme();
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    const timeout = setTimeout(() => setMounted(true), 0);
    return () => clearTimeout(timeout);
  }, []);

  if (!mounted) {
    return <div className={className} />;
  }

  return (
    <Image
      src={resolvedTheme === 'dark' ? '/logos/dark_logo.svg' : '/logos/light_logo.svg'}
      className={className}
      width={0}
      height={0}
      alt="Forui"
    />
  );
}

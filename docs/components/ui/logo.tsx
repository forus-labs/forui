'use client';

import { useTheme } from 'nextra-theme-docs';
import Image from 'next/image';
import { useState, useEffect } from 'react';

interface Props {
  className?: string;
}

export default function Logo({ className = 'w-24 h-auto' }: Props) {
  const { resolvedTheme } = useTheme();
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) {
    return null;
  }

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

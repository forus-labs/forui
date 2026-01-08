import { ReactNode } from 'react';
import { cn } from '@/lib/utils';

interface Props {
  className?: string;
  children: ReactNode;
}

export default function LinkBadgeGroup(props: Props) {
  return <div className={cn('flex gap-2 py-4', props.className)}>{props.children}</div>;
}

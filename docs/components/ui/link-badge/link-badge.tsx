import { SquareArrowOutUpRight } from 'lucide-react';
import { Button } from '@/components/ui/button';

interface Props {
  label: string;
  href: string;
}

export default function LinkBadge({ label, href }: Props) {
  return (
    <Button variant="secondary" size="sm" className="text-xs" asChild>
      <a href={href} target="_blank" rel="noopener noreferrer">
        {label}
        <SquareArrowOutUpRight className="h-3! w-3!" />
      </a>
    </Button>
  );
}

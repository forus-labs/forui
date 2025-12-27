import { SquareArrowOutUpRight } from 'lucide-react';

interface Props {
  label: string;
  href: string;
}

export default function LinkBadge(props: Props) {
  return (
    <a href={props.href} target="_blank" rel="noopener noreferrer">
      <div className="flex items-center gap-1.5 px-2.5 py-1 rounded bg-zinc-100/80 hover:bg-zinc-100 dark:bg-zinc-800/80 hover:dark:bg-zinc-800 transition-all">
        <div className="text-xs font-bold">{props.label}</div>
        <SquareArrowOutUpRight className="h-2.5 w-2.5" />
      </div>
    </a>
  );
}

import { ReactNode } from 'react';

interface Props {
  children: ReactNode;
}

export default function LinkBadgeGroup(props: Props) {
  return <div className="flex gap-2 py-4">{props.children}</div>;
}

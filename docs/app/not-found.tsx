import Link from 'next/link';
import { FileQuestion } from 'lucide-react';
import { Empty, EmptyMedia, EmptyHeader, EmptyTitle, EmptyDescription } from '@/components/ui/empty';
import { Button } from '@/components/ui/button';

export default function NotFound() {
  return (
    <main className="flex h-dvh items-center justify-center">
      <Empty>
        <EmptyHeader>
          <EmptyMedia variant="icon">
            <FileQuestion />
          </EmptyMedia>
          <EmptyTitle>That&apos;s Embarrassing</EmptyTitle>
          <EmptyDescription>The page you&apos;re looking for doesn&apos;t exist or has been moved.</EmptyDescription>
        </EmptyHeader>
        <Button asChild>
          <Link href="/">Return Home</Link>
        </Button>
      </Empty>
    </main>
  );
}

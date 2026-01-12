import Image from 'next/image';
import Link from 'next/link';

import { Button } from '@/components/ui/button';
import { Footer } from '@/components/footer';
import { ImageZoom } from 'fumadocs-ui/components/image-zoom';

export default function HomePage() {
  return (
    <main className="flex flex-col">
      <section className="flex flex-col items-center px-6 pt-10 sm:pt-20 pb-8 text-center gap-10 sm:gap-16">
        <div className="flex flex-col items-center justify-center max-w-3xl mx-auto">
          <h1 className="text-3xl sm:text-5xl font-bold tracking-tight mb-4">
            Beautifully designed minimalistic Flutter widgets
          </h1>
          <p className="text-base sm:text-lg text-muted-foreground max-w-2xl mb-6">
            A flutter platform-agnostic UI library for developers seeking consistent and elegant UIs across all devices.
            Fully customizable, free, and open source.
          </p>
          <div className="flex gap-4">
            <Button asChild>
              <Link href="/docs">Get Started</Link>
            </Button>
            <Button variant="outline" asChild>
              <a href="https://github.com/duobaseio/forui" target="_blank" rel="noopener noreferrer">
                <Image src="/brands/github.svg" alt="" width={16} height={16} className="dark:invert" />
                GitHub
              </a>
            </Button>
          </div>
        </div>

        <ImageZoom
          src="/banners/banner-311225.png"
          className="w-full border rounded-lg p-4 bg-white max-w-5xl"
          alt="Forui Demo"
          width={2400}
          height={1200}
          priority
        />
      </section>

      <Footer />
    </main>
  );
}

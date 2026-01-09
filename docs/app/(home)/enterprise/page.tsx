import Link from 'next/link';
import { Code2, Compass, ArrowRightLeft, FileSearch, GraduationCap, HeartHandshake } from 'lucide-react';

import { Button } from '@/components/ui/button';
import { Card, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Footer } from '@/components/footer';

const services = [
  {
    icon: Code2,
    title: 'Development',
    description: 'Expert assistance with challenging Flutter project goals.',
  },
  {
    icon: Compass,
    title: 'Technical Guidance',
    description: 'Technology optimization and reliability for your Flutter apps.',
  },
  {
    icon: ArrowRightLeft,
    title: 'Migration Assistance',
    description: 'Comprehensive upgrade support for Forui versions.',
  },
  {
    icon: FileSearch,
    title: 'Code Reviews',
    description: 'In-depth reviews to prevent bugs and enforce best practices.',
  },
  {
    icon: HeartHandshake,
    title: 'Long-Term Support (LTS)',
    description: 'Priority fixes, upgrades, and troubleshooting.',
  },
  {
    icon: GraduationCap,
    title: 'Team Training',
    description: 'Expert-led workshops for skill development.',
  },
];

const contact = 'https://forms.gle/wdxmjUMbYEhoJTsN8';

export default function EnterprisePage() {
  return (
    <main className="flex flex-col">
      {/* Hero Section */}
      <section className="flex flex-col items-center px-6 pt-6 pb-16 text-center">
        <div className="flex flex-col items-center justify-center sm:max-w-3xl mx-auto">
          <video autoPlay loop muted playsInline className="w-full max-w-sm px-10 mb-4 rounded-lg dark:invert">
            {/* codecs=hvc1 is a workaround as only safari appears to support it. Other browsers should fall back to webm. */}
            <source src="/assets/enterprise.mp4" type="video/mp4; codecs=hvc1" />
            <source src="/assets/enterprise.webm" type="video/webm" />
          </video>
          <h1 className="text-3xl sm:text-5xl font-bold tracking-tight mb-4">Enterprise Support</h1>
          <p className="text-base sm:text-lg text-muted-foreground max-w-2xl mb-6">
            Get hands-on support from the team behind Forui. We work alongside you to solve complex challenges and ship
            exceptional Flutter apps faster.
          </p>
          <div className="flex gap-4">
            <Button asChild>
              <a href={contact} target="_blank" rel="noopener noreferrer">
                Get in Touch
              </a>
            </Button>
            <Button variant="outline" asChild>
              <Link href="#services">Learn More</Link>
            </Button>
          </div>
        </div>
      </section>

      {/* Services Grid */}
      <section id="services" className="px-6 py-16 bg-muted/50">
        <div className="max-w-5xl mx-auto">
          <h2 className="text-3xl font-bold tracking-tight text-center mb-10">Accelerate Your Development</h2>
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {services.map((service) => (
              <Card key={service.title} className="text-left">
                <CardHeader>
                  <service.icon className="size-8 mb-2 text-muted-foreground" />
                  <CardTitle>{service.title}</CardTitle>
                  <CardDescription>{service.description}</CardDescription>
                </CardHeader>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="px-6 py-16">
        <div className="max-w-xl mx-auto text-center">
          <h2 className="text-2xl sm:text-3xl font-bold tracking-tight mb-4 ">Ready to Get Started?</h2>
          <p className="text-base sm:text-lg text-muted-foreground mb-6">
            Contact us to learn more about how we can help your team succeed with Flutter and Forui.
          </p>
          <Button size="lg" asChild>
            <a href={contact} target="_blank" rel="noopener noreferrer">
              Contact Us
            </a>
          </Button>
        </div>
      </section>

      <Footer />
    </main>
  );
}

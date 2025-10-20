import { clsx, type ClassValue } from 'clsx';
import { twMerge } from 'tailwind-merge';

let demoUrl: string | null = null;

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

/**
 * Fetches the demo URL from runtime config or falls back to build-time environment variable.
 *
 * In production/preview deployments, the demo URL is injected via /config.json at deploy time.
 * In local development, it falls back to NEXT_PUBLIC_DEMO_URL from .env.development.
 */
export async function fetchDemoUrl(): Promise<string | null> {
  if (demoUrl) {
    return demoUrl;
  }

  // Attempt to fetch runtime config from deployed environment
  const response = await fetch('/config.json');
  // Fallback for local development or if config.json doesn't exist'.
  const fallback = process.env.NEXT_PUBLIC_DEMO_URL || 'http://localhost:3001';

  if (!response.ok) {
    return fallback;
  }

  const config = await response.json();
  return config.demoUrl ? (demoUrl = config.demoUrl) : fallback;
}

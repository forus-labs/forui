import { clsx, type ClassValue } from 'clsx';
import { twMerge } from 'tailwind-merge';

let demoUrl: string | null = null;

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

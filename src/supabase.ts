import { createClient } from '@supabase/supabase-js';

const url = import.meta.env.VITE_SUPABASE_URL as string | undefined;
const anonKey = import.meta.env.VITE_SUPABASE_ANON_KEY as string | undefined;
export const supabaseReady = Boolean(url && anonKey && url.startsWith('https://'));
export const supabase = supabaseReady ? createClient(url!, anonKey!, {
  auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true },
}) : null;

export type Culture = {
  id: string; slug: string; title: string; category: string; category_label: string;
  region: string; subtitle: string; excerpt: string; story: string[]; territorial_note: string;
  visual_motif: string; cover_image_url: string; photo_credit: string; photo_source_url: string;
  sort_order: number; published: boolean;
};
export type Chapter = { id: string; culture_id: string; title: string; intro: string; sort_order: number };
export type Page = { id: string; culture_id: string; chapter_id: string | null; title: string; label: string; content: string; sort_order: number; is_extra: boolean };
export type ImageRecord = { id: string; culture_id: string; page_id: string | null; storage_path: string | null; url: string; alt: string; caption: string; credit: string; source_url: string; sort_order: number };
export type ReferenceRecord = { id: string; culture_id: string; institution: string; title: string; url: string; note: string; sort_order: number };
export type CreditRecord = { id: string; culture_id: string; image_id: string | null; person_or_institution: string; role: string; text: string; source_url: string };

declare global { interface ImportMetaEnv { readonly VITE_SUPABASE_URL?: string; readonly VITE_SUPABASE_ANON_KEY?: string } interface ImportMeta { readonly env: ImportMetaEnv } }

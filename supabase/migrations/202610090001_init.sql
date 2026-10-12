-- Bestiário Cultural · migração inicial
-- Executar no SQL Editor do Supabase. A chave service_role nunca vai ao navegador.
create extension if not exists pgcrypto;

create table if not exists public.cultures (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  title text not null,
  category text not null default 'cultura',
  category_label text not null default 'Manifestação cultural',
  region text not null default '',
  subtitle text not null default '',
  excerpt text not null default '',
  story jsonb not null default '[]'::jsonb,
  territorial_note text not null default '',
  visual_motif text not null default '',
  cover_image_url text not null default '',
  photo_credit text not null default '',
  photo_source_url text not null default '',
  sort_order integer not null default 0,
  published boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create table if not exists public.chapters (
  id uuid primary key default gen_random_uuid(), culture_id uuid not null unique references public.cultures(id) on delete cascade,
  title text not null, intro text not null default '', sort_order integer not null default 0,
  created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table if not exists public.pages (
  id uuid primary key default gen_random_uuid(), culture_id uuid not null references public.cultures(id) on delete cascade,
  chapter_id uuid references public.chapters(id) on delete cascade, title text not null, label text not null default '',
  content text not null default '', sort_order integer not null default 0, is_extra boolean not null default false,
  created_at timestamptz not null default now(), updated_at timestamptz not null default now(),
  unique(culture_id, sort_order)
);
create table if not exists public.images (
  id uuid primary key default gen_random_uuid(), culture_id uuid not null references public.cultures(id) on delete cascade,
  page_id uuid references public.pages(id) on delete cascade, storage_path text, url text not null default '',
  alt text not null default '', caption text not null default '', credit text not null default '', source_url text not null default '',
  sort_order integer not null default 0, created_at timestamptz not null default now(),
  constraint image_location_check check (storage_path is not null or url <> '')
);
create table if not exists public.credits (
  id uuid primary key default gen_random_uuid(), culture_id uuid not null references public.cultures(id) on delete cascade,
  image_id uuid references public.images(id) on delete set null, person_or_institution text not null,
  role text not null default '', text text not null default '', source_url text not null default '', created_at timestamptz not null default now()
);
create table if not exists public.references (
  id uuid primary key default gen_random_uuid(), culture_id uuid not null references public.cultures(id) on delete cascade,
  institution text not null default '', title text not null, url text not null default '', note text not null default '',
  sort_order integer not null default 0, created_at timestamptz not null default now(),
  unique(culture_id, title, url)
);
create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade, created_at timestamptz not null default now()
);

create or replace function public.is_admin() returns boolean language sql stable security definer set search_path = public
as $$ select exists(select 1 from public.admin_users where user_id = auth.uid()) $$;
revoke all on function public.is_admin() from public;
grant execute on function public.is_admin() to anon, authenticated;

-- Limites de conteúdo definidos no painel: 40 páginas extras/cultura e 2 imagens/página.
create or replace function public.enforce_page_limits() returns trigger language plpgsql set search_path = public as $$
begin
  if new.is_extra and (select count(*) from public.pages p where p.culture_id=new.culture_id and p.is_extra and p.id is distinct from new.id) >= 40 then
    raise exception 'Cada cultura pode ter no máximo 40 páginas extras.';
  end if;
  return new;
end $$;
drop trigger if exists pages_limit_trigger on public.pages;
create trigger pages_limit_trigger before insert or update of culture_id,is_extra on public.pages for each row execute function public.enforce_page_limits();
create or replace function public.enforce_image_limit() returns trigger language plpgsql set search_path = public as $$
begin
  if new.page_id is not null and (select count(*) from public.images i where i.page_id=new.page_id and i.id is distinct from new.id) >= 2 then
    raise exception 'Cada página pode conter no máximo duas imagens.';
  end if;
  return new;
end $$;
drop trigger if exists images_limit_trigger on public.images;
create trigger images_limit_trigger before insert or update of page_id on public.images for each row execute function public.enforce_image_limit();

alter table public.cultures enable row level security;
alter table public.chapters enable row level security;
alter table public.pages enable row level security;
alter table public.images enable row level security;
alter table public.credits enable row level security;
alter table public.references enable row level security;
alter table public.admin_users enable row level security;
-- Leitura pública apenas do acervo publicado; escrita restrita a usuários explicitamente promovidos.
drop policy if exists cultures_public_read on public.cultures;
create policy cultures_public_read on public.cultures for select to anon, authenticated using (published or public.is_admin());
drop policy if exists cultures_admin_write on public.cultures;
create policy cultures_admin_write on public.cultures for all to authenticated using (public.is_admin()) with check (public.is_admin());

do $$ declare t text; begin
  foreach t in array array['chapters','pages','images','credits','references'] loop
    execute format('drop policy if exists %I on public.%I', t||'_public_read', t);
    execute format('create policy %I on public.%I for select to anon, authenticated using (exists (select 1 from public.cultures c where c.id = culture_id and (c.published or public.is_admin())))', t||'_public_read', t);
    execute format('drop policy if exists %I on public.%I', t||'_admin_write', t);
    execute format('create policy %I on public.%I for all to authenticated using (public.is_admin()) with check (public.is_admin())', t||'_admin_write', t);
  end loop;
end $$;
-- Tabela de concessões: sem leitura ou escrita pública. A promoção inicial é feita por operador no SQL Editor.
revoke all on public.admin_users from anon, authenticated;
grant select, insert, update, delete on public.cultures, public.chapters, public.pages, public.images, public.credits, public.references to authenticated;
grant select on public.cultures, public.chapters, public.pages, public.images, public.credits, public.references to anon;

insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types)
values ('bestiario-images','bestiario-images',true,10485760,array['image/jpeg','image/png','image/webp','image/avif'])
on conflict(id) do update set public=true, file_size_limit=10485760, allowed_mime_types=excluded.allowed_mime_types;
drop policy if exists "Bestiario image public read" on storage.objects;
create policy "Bestiario image public read" on storage.objects for select to anon, authenticated using (bucket_id='bestiario-images');
drop policy if exists "Bestiario admin image insert" on storage.objects;
create policy "Bestiario admin image insert" on storage.objects for insert to authenticated with check (bucket_id='bestiario-images' and public.is_admin());
drop policy if exists "Bestiario admin image update" on storage.objects;
create policy "Bestiario admin image update" on storage.objects for update to authenticated using (bucket_id='bestiario-images' and public.is_admin()) with check (bucket_id='bestiario-images' and public.is_admin());
drop policy if exists "Bestiario admin image delete" on storage.objects;
create policy "Bestiario admin image delete" on storage.objects for delete to authenticated using (bucket_id='bestiario-images' and public.is_admin());

-- A migração é idempotente. Dados completos do HTML original em 002_seed.sql.

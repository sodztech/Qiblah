create extension if not exists pgcrypto;

create table if not exists public.listing_reports (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  listing_type text not null,
  listing_name text not null,
  listing_area text,
  listing_address text,
  source_page text,
  issue_types text[] not null default '{}'::text[],
  notes text,
  status text not null default 'new',
  reviewed_at timestamptz
);

alter table public.listing_reports enable row level security;

drop policy if exists "listing_reports_public_insert" on public.listing_reports;
create policy "listing_reports_public_insert"
on public.listing_reports
for insert
to anon, authenticated
with check (true);

drop policy if exists "listing_reports_public_select" on public.listing_reports;
create policy "listing_reports_public_select"
on public.listing_reports
for select
to anon, authenticated
using (true);

drop policy if exists "listing_reports_public_update" on public.listing_reports;
create policy "listing_reports_public_update"
on public.listing_reports
for update
to anon, authenticated
using (true)
with check (true);

drop policy if exists "listing_reports_public_delete" on public.listing_reports;
create policy "listing_reports_public_delete"
on public.listing_reports
for delete
to anon, authenticated
using (true);

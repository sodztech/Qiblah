create extension if not exists pgcrypto;

create table if not exists public.prayer_spaces (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  name text not null,
  venue text,
  address text,
  area text not null,
  city text default 'London',
  type text default 'Other',
  hours text,
  notes text,
  facilities text[] not null default '{}',
  url text,
  lat double precision,
  lon double precision,
  sort_order integer not null default 0,
  active boolean not null default true
);

alter table public.prayer_spaces enable row level security;

drop policy if exists "prayer_spaces_select" on public.prayer_spaces;
create policy "prayer_spaces_select"
on public.prayer_spaces
for select
to anon, authenticated
using (true);

drop policy if exists "prayer_spaces_insert" on public.prayer_spaces;
create policy "prayer_spaces_insert"
on public.prayer_spaces
for insert
to anon, authenticated
with check (true);

drop policy if exists "prayer_spaces_update" on public.prayer_spaces;
create policy "prayer_spaces_update"
on public.prayer_spaces
for update
to anon, authenticated
using (true)
with check (true);

drop policy if exists "prayer_spaces_delete" on public.prayer_spaces;
create policy "prayer_spaces_delete"
on public.prayer_spaces
for delete
to anon, authenticated
using (true);

create index if not exists prayer_spaces_sort_order_idx on public.prayer_spaces(sort_order, name);
create index if not exists prayer_spaces_active_idx on public.prayer_spaces(active);

-- Import existing bundled prayer spaces.
-- Safe to run more than once: existing rows with the same name/address are skipped.

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Selfridges Multi-Faith Prayer Room', '4th Floor near customer services and toilets', '400 Oxford St, London W1A 1AB', 'Oxford Circus / West End', 'London', 'Shopping Centre', null, null, array['Prayer space']::text[], null, null, null, 0, true
where not exists (select 1 from public.prayer_spaces where name = 'Selfridges Multi-Faith Prayer Room' and coalesce(address, '') = '400 Oxford St, London W1A 1AB');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Royal Festival Hall Multi-Faith Prayer Room', 'Level 2, Green Side', 'Southbank Centre, Belvedere Rd, London SE1 8XX', 'Southbank / Waterloo', 'London', 'Cultural Venue', null, null, array['Prayer space']::text[], null, null, null, 1, true
where not exists (select 1 from public.prayer_spaces where name = 'Royal Festival Hall Multi-Faith Prayer Room' and coalesce(address, '') = 'Southbank Centre, Belvedere Rd, London SE1 8XX');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Canary Wharf Prayer Room', 'Inside 2 Churchill Place', '2 Churchill Pl, London E14 5RB', 'Canary Wharf', 'London', 'Workplace', null, null, array['Prayer space']::text[], null, null, null, 2, true
where not exists (select 1 from public.prayer_spaces where name = 'Canary Wharf Prayer Room' and coalesce(address, '') = '2 Churchill Pl, London E14 5RB');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Westfield London Multi-Faith Prayer Room', 'Level -3, Lift Lobby 1, The Village', 'Ariel Way, London W12 7GF', 'White City / Shepherd''s Bush', 'London', 'Shopping Centre', null, null, array['Prayer space']::text[], null, null, null, 3, true
where not exists (select 1 from public.prayer_spaces where name = 'Westfield London Multi-Faith Prayer Room' and coalesce(address, '') = 'Ariel Way, London W12 7GF');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Westfield Stratford Multi-Faith Room', 'First-floor balcony behind World Food Court', '157 Montfichet Rd, London E20 1EJ', 'Stratford', 'London', 'Shopping Centre', null, null, array['Prayer space']::text[], null, null, null, 4, true
where not exists (select 1 from public.prayer_spaces where name = 'Westfield Stratford Multi-Faith Room' and coalesce(address, '') = '157 Montfichet Rd, London E20 1EJ');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'The Space@E20 Multi-Faith Room', 'Second floor near Nando''s', 'Montfichet Rd, London E15 1AZ', 'Stratford', 'London', 'Community Space', null, null, array['Prayer space']::text[], null, null, null, 5, true
where not exists (select 1 from public.prayer_spaces where name = 'The Space@E20 Multi-Faith Room' and coalesce(address, '') = 'Montfichet Rd, London E15 1AZ');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Westfield Stratford Friday Prayer Space', 'Friday-only Jumu''ah setup inside Stratford City', 'Montfichet Rd, London E15 1AZ', 'Stratford', 'London', 'Shopping Centre', null, null, array['Prayer space']::text[], null, null, null, 6, true
where not exists (select 1 from public.prayer_spaces where name = 'Westfield Stratford Friday Prayer Space' and coalesce(address, '') = 'Montfichet Rd, London E15 1AZ');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Piccadilly Prayer Space Community Centre', 'Basement level', '19 Rupert St, London W1D 7PA', 'Soho / Piccadilly', 'London', 'Community Space', null, null, array['Prayer space']::text[], null, null, null, 7, true
where not exists (select 1 from public.prayer_spaces where name = 'Piccadilly Prayer Space Community Centre' and coalesce(address, '') = '19 Rupert St, London W1D 7PA');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'King''s Cross St Pancras Prayer Space', 'Near Eurostar concourse', 'Euston Rd, London N1C 4QP', 'King''s Cross / St Pancras', 'London', 'Transport Hub', null, null, array['Prayer space']::text[], null, null, null, 8, true
where not exists (select 1 from public.prayer_spaces where name = 'King''s Cross St Pancras Prayer Space' and coalesce(address, '') = 'Euston Rd, London N1C 4QP');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Liverpool Street Station Prayer Room', 'Inside station complex', 'Liverpool St, London EC2M 7PY', 'City of London', 'London', 'Transport Hub', null, null, array['Prayer space']::text[], null, null, null, 9, true
where not exists (select 1 from public.prayer_spaces where name = 'Liverpool Street Station Prayer Room' and coalesce(address, '') = 'Liverpool St, London EC2M 7PY');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Victoria Station Prayer Room', 'Access via station staff/info desk', 'Victoria St, London SW1E 5ND', 'Victoria / Westminster', 'London', 'Transport Hub', null, null, array['Prayer space']::text[], null, null, null, 10, true
where not exists (select 1 from public.prayer_spaces where name = 'Victoria Station Prayer Room' and coalesce(address, '') = 'Victoria St, London SW1E 5ND');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'British Museum Multi-Faith Space', 'Visitor quiet/reflection area', 'Great Russell St, London WC1B 3DG', 'Bloomsbury', 'London', 'Cultural Venue', null, null, array['Prayer space']::text[], null, null, null, 11, true
where not exists (select 1 from public.prayer_spaces where name = 'British Museum Multi-Faith Space' and coalesce(address, '') = 'Great Russell St, London WC1B 3DG');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'British Library Quiet Room', 'Quiet contemplation room', '96 Euston Rd, London NW1 2DB', 'King''s Cross / Euston', 'London', 'Cultural Venue', null, null, array['Prayer space']::text[], null, null, null, 12, true
where not exists (select 1 from public.prayer_spaces where name = 'British Library Quiet Room' and coalesce(address, '') = '96 Euston Rd, London NW1 2DB');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Guy''s Hospital Multi-Faith Room', 'Near hospital complex', 'Great Maze Pond, London SE1 9RT', 'London Bridge', 'London', 'Hospital', null, null, array['Prayer space']::text[], null, null, null, 13, true
where not exists (select 1 from public.prayer_spaces where name = 'Guy''s Hospital Multi-Faith Room' and coalesce(address, '') = 'Great Maze Pond, London SE1 9RT');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'St Thomas'' Hospital Multi-Faith Room', 'Ground Floor, South Wing near Central Hall', 'Westminster Bridge Rd, London SE1 7EH', 'Westminster / Waterloo', 'London', 'Hospital', null, null, array['Prayer space']::text[], null, null, null, 14, true
where not exists (select 1 from public.prayer_spaces where name = 'St Thomas'' Hospital Multi-Faith Room' and coalesce(address, '') = 'Westminster Bridge Rd, London SE1 7EH');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'University College Hospital Prayer Room', 'Ground floor near cafe', '235 Euston Rd, London NW1 2BU', 'Euston', 'London', 'Hospital', null, null, array['Prayer space']::text[], null, null, null, 15, true
where not exists (select 1 from public.prayer_spaces where name = 'University College Hospital Prayer Room' and coalesce(address, '') = '235 Euston Rd, London NW1 2BU');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'UCL Quiet Contemplation Room', 'Various rooms across campus', 'Gower St, London WC1E 6BT', 'Bloomsbury / UCL', 'London', 'University', null, null, array['Prayer space']::text[], null, null, null, 16, true
where not exists (select 1 from public.prayer_spaces where name = 'UCL Quiet Contemplation Room' and coalesce(address, '') = 'Gower St, London WC1E 6BT');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Institute of Education Prayer Room', 'Room 794', '20 Bedford Way, London WC1H 0AL', 'Bloomsbury', 'London', 'University', null, null, array['Prayer space']::text[], null, null, null, 17, true
where not exists (select 1 from public.prayer_spaces where name = 'Institute of Education Prayer Room' and coalesce(address, '') = '20 Bedford Way, London WC1H 0AL');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'School of Pharmacy Quiet Room', 'Basement Room B34', '29-39 Brunswick Sq, London WC1N 1AX', 'Bloomsbury', 'London', 'University', null, null, array['Prayer space']::text[], null, null, null, 18, true
where not exists (select 1 from public.prayer_spaces where name = 'School of Pharmacy Quiet Room' and coalesce(address, '') = '29-39 Brunswick Sq, London WC1N 1AX');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'City University Multi-Faith Prayer Room', 'Northampton Square campus', 'Northampton Sq, London EC1V 0HB', 'Clerkenwell / Angel', 'London', 'University', null, null, array['Prayer space']::text[], null, null, null, 19, true
where not exists (select 1 from public.prayer_spaces where name = 'City University Multi-Faith Prayer Room' and coalesce(address, '') = 'Northampton Sq, London EC1V 0HB');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'LSE Faith Centre Prayer Rooms', 'Saw Swee Hock Student Centre', '1 Sheffield St, London WC2A 2AP', 'Holborn / Aldwych', 'London', 'University', null, null, array['Prayer space']::text[], null, null, null, 20, true
where not exists (select 1 from public.prayer_spaces where name = 'LSE Faith Centre Prayer Rooms' and coalesce(address, '') = '1 Sheffield St, London WC2A 2AP');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Imperial College Muslim Prayer Rooms', 'South Kensington campus', 'Exhibition Rd, London SW7 2AZ', 'South Kensington', 'London', 'University', null, null, array['Prayer space']::text[], null, null, null, 21, true
where not exists (select 1 from public.prayer_spaces where name = 'Imperial College Muslim Prayer Rooms' and coalesce(address, '') = 'Exhibition Rd, London SW7 2AZ');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Queen Mary University Multi-Faith Centre', 'Mile End campus', 'Mile End Rd, London E1 4NS', 'Mile End', 'London', 'University', null, null, array['Prayer space']::text[], null, null, null, 22, true
where not exists (select 1 from public.prayer_spaces where name = 'Queen Mary University Multi-Faith Centre' and coalesce(address, '') = 'Mile End Rd, London E1 4NS');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Gallions Reach Shopping Park Prayer Room', 'Inside retail park complex', 'Armada Way, London E6 7ER', 'Beckton', 'London', 'Retail Park', null, null, array['Prayer space']::text[], null, null, null, 23, true
where not exists (select 1 from public.prayer_spaces where name = 'Gallions Reach Shopping Park Prayer Room' and coalesce(address, '') = 'Armada Way, London E6 7ER');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Barking Shopping Centre Prayer Room', 'Inside Vicarage Field Shopping Centre', 'Ripple Rd, Barking IG11 7PG', 'Barking', 'London', 'Shopping Centre', null, null, array['Prayer space']::text[], null, null, null, 24, true
where not exists (select 1 from public.prayer_spaces where name = 'Barking Shopping Centre Prayer Room' and coalesce(address, '') = 'Ripple Rd, Barking IG11 7PG');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Excel London Prayer Room', 'Multi-faith rooms in ICC/ExCeL complex', '1 Western Gateway, London E16 1XL', 'Royal Docks / Custom House', 'London', 'Cultural Venue', null, null, array['Prayer space']::text[], null, null, null, 25, true
where not exists (select 1 from public.prayer_spaces where name = 'Excel London Prayer Room' and coalesce(address, '') = '1 Western Gateway, London E16 1XL');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'O2 Arena Prayer Room', 'Visitor services / arena complex', 'Peninsula Sq, London SE10 0DX', 'North Greenwich', 'London', 'Entertainment Venue', null, null, array['Prayer space']::text[], null, null, null, 26, true
where not exists (select 1 from public.prayer_spaces where name = 'O2 Arena Prayer Room' and coalesce(address, '') = 'Peninsula Sq, London SE10 0DX');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Bluewater Prayer Room', 'Guest services area', 'Bluewater Pkwy, Dartford DA9 9ST', 'Bluewater', 'London', 'Shopping Centre', null, null, array['Prayer space']::text[], null, null, null, 27, true
where not exists (select 1 from public.prayer_spaces where name = 'Bluewater Prayer Room' and coalesce(address, '') = 'Bluewater Pkwy, Dartford DA9 9ST');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Brent Cross Shopping Centre Prayer Room', 'Inside shopping centre services area', 'Prince Charles Dr, London NW4 3FP', 'Brent Cross', 'London', 'Shopping Centre', null, null, array['Prayer space']::text[], null, null, null, 28, true
where not exists (select 1 from public.prayer_spaces where name = 'Brent Cross Shopping Centre Prayer Room' and coalesce(address, '') = 'Prince Charles Dr, London NW4 3FP');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Heathrow Terminal 2 Prayer Room', 'Near Gate A21 and Gates B34/B35', 'Heathrow Terminal 2', 'Heathrow', 'London', 'Airport', null, null, array['Prayer space']::text[], null, null, null, 29, true
where not exists (select 1 from public.prayer_spaces where name = 'Heathrow Terminal 2 Prayer Room' and coalesce(address, '') = 'Heathrow Terminal 2');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Heathrow Terminal 3 Prayer Room', 'Arrivals Level 1 and near Gate 24', 'Heathrow Terminal 3', 'Heathrow', 'London', 'Airport', null, null, array['Prayer space']::text[], null, null, null, 30, true
where not exists (select 1 from public.prayer_spaces where name = 'Heathrow Terminal 3 Prayer Room' and coalesce(address, '') = 'Heathrow Terminal 3');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Heathrow Terminal 4 Prayer Room', 'Mezzanine level and near Gate 4', 'Heathrow Terminal 4', 'Heathrow', 'London', 'Airport', null, null, array['Prayer space']::text[], null, null, null, 31, true
where not exists (select 1 from public.prayer_spaces where name = 'Heathrow Terminal 4 Prayer Room' and coalesce(address, '') = 'Heathrow Terminal 4');

insert into public.prayer_spaces (name, venue, address, area, city, type, hours, notes, facilities, url, lat, lon, sort_order, active)
select 'Heathrow Terminal 5 Prayer Room', 'Check-in Zone A, Gate A8, Gate B34 and Gate C52', 'Heathrow Terminal 5', 'Heathrow', 'London', 'Airport', null, null, array['Prayer space']::text[], null, null, null, 32, true
where not exists (select 1 from public.prayer_spaces where name = 'Heathrow Terminal 5 Prayer Room' and coalesce(address, '') = 'Heathrow Terminal 5');

select count(*) as prayer_spaces_count from public.prayer_spaces;

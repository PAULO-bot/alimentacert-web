
-- AlimentaCert PRO - esquema base SaaS
create extension if not exists "pgcrypto";

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  company_name text,
  tax_id text,
  address text,
  phone text,
  logo_url text,
  created_at timestamptz not null default now()
);

create table if not exists public.subscriptions (
  user_id uuid primary key references auth.users(id) on delete cascade,
  stripe_customer_id text unique,
  stripe_subscription_id text unique,
  status text not null default 'inactive'
    check (status in ('inactive','trialing','active','past_due','unpaid','canceled','expired')),
  current_period_end timestamptz,
  updated_at timestamptz not null default now()
);

create table if not exists public.dishes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  category text,
  portion_g numeric,
  ingredients text,
  method text,
  allergens jsonb not null default '[]'::jsonb,
  traces jsonb not null default '[]'::jsonb,
  nutrition jsonb not null default '{}'::jsonb,
  cost numeric,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.audit_log (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  action text not null,
  detail text,
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.subscriptions enable row level security;
alter table public.dishes enable row level security;
alter table public.audit_log enable row level security;

drop policy if exists "profiles_own" on public.profiles;
create policy "profiles_own" on public.profiles for all using (auth.uid() = id) with check (auth.uid() = id);

drop policy if exists "subscriptions_read_own" on public.subscriptions;
create policy "subscriptions_read_own" on public.subscriptions for select using (auth.uid() = user_id);

drop policy if exists "dishes_own" on public.dishes;
create policy "dishes_own" on public.dishes for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "audit_own" on public.audit_log;
create policy "audit_own" on public.audit_log for select using (auth.uid() = user_id);

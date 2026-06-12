-- ============================================================
-- DUNEX Partner Portal — PostgreSQL Schema
-- ============================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ----------------------------------------------------------
-- Roles
-- ----------------------------------------------------------
CREATE TYPE user_role AS ENUM ('admin', 'partner');

-- ----------------------------------------------------------
-- Users
-- ----------------------------------------------------------
CREATE TABLE dunex_users (
  id            SERIAL PRIMARY KEY,
  username      VARCHAR(60)  NOT NULL UNIQUE,
  display_name  VARCHAR(120) NOT NULL,
  email         VARCHAR(255) NOT NULL UNIQUE,
  password_hash TEXT         NOT NULL,  -- bcrypt hash (cost factor 12)
  role          user_role    NOT NULL DEFAULT 'partner',
  is_active     BOOLEAN      NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
  last_login    TIMESTAMPTZ
);

CREATE INDEX idx_dunex_users_username ON dunex_users (username);
CREATE INDEX idx_dunex_users_role     ON dunex_users (role);

-- ----------------------------------------------------------
-- Sessions  (server-side token store)
-- ----------------------------------------------------------
CREATE TABLE dunex_sessions (
  id          UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     INTEGER      NOT NULL REFERENCES dunex_users (id) ON DELETE CASCADE,
  created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
  expires_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW() + INTERVAL '8 hours',
  ip_address  INET,
  user_agent  TEXT
);

CREATE INDEX idx_dunex_sessions_user_id    ON dunex_sessions (user_id);
CREATE INDEX idx_dunex_sessions_expires_at ON dunex_sessions (expires_at);

-- ----------------------------------------------------------
-- Partner portal data
-- ----------------------------------------------------------
CREATE TABLE dunex_partner_profiles (
  id              SERIAL PRIMARY KEY,
  user_id         INTEGER      NOT NULL UNIQUE REFERENCES dunex_users (id) ON DELETE CASCADE,
  company_name    VARCHAR(200),
  sector          VARCHAR(100),
  sponsorship_tier VARCHAR(30) DEFAULT 'bronze',  -- bronze | silver | gold | platinum
  subscription_active BOOLEAN  NOT NULL DEFAULT FALSE,
  subscription_start  DATE,
  subscription_end    DATE,
  notes           TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ----------------------------------------------------------
-- Audit log
-- ----------------------------------------------------------
CREATE TABLE dunex_audit_log (
  id          BIGSERIAL    PRIMARY KEY,
  user_id     INTEGER      REFERENCES dunex_users (id) ON DELETE SET NULL,
  action      VARCHAR(80)  NOT NULL,
  detail      JSONB,
  performed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  ip_address  INET
);

-- ----------------------------------------------------------
-- Helper function: auto-update updated_at
-- ----------------------------------------------------------
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_partner_profiles_updated_at
  BEFORE UPDATE ON dunex_partner_profiles
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

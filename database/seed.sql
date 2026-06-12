-- ============================================================
-- DUNEX Partner Portal — Seed Data
-- NOTE: Passwords below are bcrypt hashes (cost 12).
--       Plain-text credentials are in the partner portal
--       login-hint (demo only — rotate before production).
-- ============================================================

-- ----------------------------------------------------------
-- Users
--   Credentials (plain-text, demo environment only):
--     maureen   / Mau-Dunex26
--     darnell   / Dar-Dunex26
--     sosthene  / Sos-Admin26   (admin)
--     aurelie   / Aur-Dunex26
-- ----------------------------------------------------------
INSERT INTO dunex_users (username, display_name, email, password_hash, role) VALUES
  (
    'maureen',
    'Maureen',
    'maureen@dunex.fr',
    -- bcrypt hash of 'Mau-Dunex26' (cost 12) — regenerate with pgcrypto in prod:
    -- SELECT crypt('Mau-Dunex26', gen_salt('bf', 12));
    '$2a$12$KIX3ZqW1E8Hn2oBcN1uZCOGqWJn4MvUC3XsP7tLzRDkAYfEm9oQvK',
    'partner'
  ),
  (
    'darnell',
    'Darnell',
    'darnell@dunex.fr',
    -- bcrypt hash of 'Dar-Dunex26'
    '$2a$12$RzM4pL9kTvBq7nX2sHd6OO1TwUGcYaJf5BeK8rCsINe1LdFxPQmZu',
    'partner'
  ),
  (
    'sosthene',
    'Sosthène',
    'sosthene@dunex.fr',
    -- bcrypt hash of 'Sos-Admin26'
    '$2a$12$Vp8eN3hGmW2cL7uD4YkFJuoA5XbRnQ9tMpS6vZ1aBdKE0CfHgOsYl',
    'admin'
  ),
  (
    'aurelie',
    'Aurélie',
    'aurelie@dunex.fr',
    -- bcrypt hash of 'Aur-Dunex26'
    '$2a$12$WsJ6fP2nMkL9uE5rCqY8TvD3aXoNbH4mGKp7tZR1cBiS0DfIeQwXn',
    'partner'
  );

-- ----------------------------------------------------------
-- Partner profiles
-- ----------------------------------------------------------
INSERT INTO dunex_partner_profiles (user_id, company_name, sector, sponsorship_tier, subscription_active, subscription_start, subscription_end)
SELECT id, 'DUNEX', 'Fashion Events', 'gold', TRUE, '2026-07-01', '2027-06-30'
FROM dunex_users WHERE username = 'maureen';

INSERT INTO dunex_partner_profiles (user_id, company_name, sector, sponsorship_tier, subscription_active, subscription_start, subscription_end)
SELECT id, 'DUNEX', 'Fashion Events', 'silver', TRUE, '2026-07-01', '2027-06-30'
FROM dunex_users WHERE username = 'darnell';

INSERT INTO dunex_partner_profiles (user_id, company_name, sector, sponsorship_tier, subscription_active, subscription_start, subscription_end)
SELECT id, 'EOEX / DUNES Administration', 'Platform Admin', 'platinum', TRUE, '2026-07-01', '2027-06-30'
FROM dunex_users WHERE username = 'sosthene';

INSERT INTO dunex_partner_profiles (user_id, company_name, sector, sponsorship_tier, subscription_active, subscription_start, subscription_end)
SELECT id, 'DUNEX', 'Fashion Events', 'bronze', TRUE, '2026-07-01', '2027-06-30'
FROM dunex_users WHERE username = 'aurelie';

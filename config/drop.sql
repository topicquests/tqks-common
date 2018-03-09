\c tq_database

-- Switch to the tq_admin user to drop the database for TQ objects.
SET ROLE tq_admin;

DROP SCHEMA tq_contents CASCADE;
DROP SCHEMA tq_authentication CASCADE;
DROP SCHEMA audit CASCADE;

SET ROLE postgres;

DROP EXTENSION hstore;
DROP EXTENSION pgcrypto;

\c postgres

-- Switch to the tq_admin user to drop the database for TQ objects.
SET ROLE tq_admin;

DROP DATABASE tq_database;

SET ROLE postgres;

-- Primary roles
DROP ROLE tq_users;    -- full access to user information
DROP ROLE tq_users_ro; -- read-only access user information
DROP ROLE tq_proxy;    -- full access to proxy information
DROP ROLE tq_proxy_ro; -- read-only access to proxy information

-- DROP TABLESPACE tq_space;

DROP USER tq_admin;
DROP USER tq_user;

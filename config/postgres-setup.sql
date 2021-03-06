--
-- File: postgres-setup.sql
--
-- Copyright 2018, TopicQuests
--
-- This SQL script creates the roles, schemas, tables, and indexes
-- necessary for topic maps.
--

-- Run as superuser.

-- Create the tablespace for TopicQuests data.
-- 2018/02/15 - Use the default database until we can figure out
--              how to create the data directory for all platforms.
--
-- CREATE TABLESPACE tq_space LOCATION '/var/lib/pgsql/tq';

-- Primary roles
CREATE ROLE tq_users INHERIT;    -- full access to user information
CREATE ROLE tq_users_ro INHERIT; -- read-only access user information
CREATE ROLE tq_proxy INHERIT;    -- full access to proxy information
CREATE ROLE tq_proxy_ro INHERIT; -- read-only access to proxy information
CREATE ROLE tq_conv INHERIT;     -- full access to conversation tree information
CREATE ROLE tq_conv_ro INHERIT;  -- read-only access to conversation tree information

-- CREATE USER tq_admin PASSWORD 'md52c7c554fad386563506b43905bceb7d6'  -- full access
CREATE USER tq_admin PASSWORD 'tq-admin-pwd'  -- full access
    CREATEDB
    NOINHERIT IN ROLE tq_users, tq_proxy, tq_conv, tq_users_ro, tq_proxy_ro, tq_conv_ro;
-- GRANT CREATE ON TABLESPACE tq_space TO tq_admin;

-- CREATE USER tq_user PASSWORD 'md50c6d478265233f1cc3ff062c7e5ef382'  -- limited access
CREATE USER tq_user PASSWORD 'tq-user-pwd'  -- limited access
    NOINHERIT IN ROLE tq_users_ro, tq_proxy_ro;

-- Switch to the tq_admin user to create the database for TQ objects.
SET ROLE tq_admin;

-- Create the database.
CREATE DATABASE tq_database ENCODING UTF8;

-- Switch to tq_database.
\c tq_database

SET ROLE tq_admin;

--
-- Create a locator type.
--
CREATE DOMAIN locator text NOT NULL;

--
-- Create the audit log table.
--
\i audit.sql

--
-- Create the user tables.
--
\i authentication.sql

--
-- Create the tables for the proxies.
--
\i proxy.sql

--
-- Create the tables for the conversation tree.
--
\i convtree.sql

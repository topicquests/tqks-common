--
-- Clean all data from the topic map tables.
--

-- Switch to tq_database.
\c tq_database

SET ROLE tq_admin;

DELETE FROM tq_contents.properties;
DELETE FROM tq_contents.proxy;

SET ROLE tq_users;

DELETE FROM tq_authentication.users;

\q




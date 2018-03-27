--
-- Clean all data from the topic map tables.
--

SET ROLE tq_admin;

DELETE FROM tq_contents.properties;
DELETE FROM tq_contents.superclasses;
DELETE FROM tq_contents.transitive_closure;
DELETE FROM tq_contents.proxy;

SET ROLE tq_users;

DELETE FROM tq_authentication.users;

\q




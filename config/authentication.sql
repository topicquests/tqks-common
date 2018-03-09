--
-- Create a schema to hide the authentication table from public view.
--
CREATE SCHEMA IF NOT EXISTS tq_authentication;
GRANT ALL ON schema tq_authentication TO tq_users;
GRANT USAGE ON schema tq_authentication TO tq_users_ro;

COMMENT ON SCHEMA tq_authentication IS 'Tables to store topic quest users.';

-- Install the pgcrypto extension.
SET ROLE postgres;
CREATE EXTENSION IF NOT EXISTS pgcrypto;

SET ROLE tq_admin;

--
-- Create a locator type.
--
CREATE DOMAIN locator VARCHAR(50) NOT NULL;

CREATE TABLE IF NOT EXISTS
tq_authentication.users (
  userid       locator UNIQUE,
  email        text UNIQUE NOT NULL check ( email ~* '^.+@.+\..+$' ),
  password     varchar(512) NOT NULL,
  handle       varchar(32) UNIQUE NOT NULL,
  first_name   text,
  last_name    text,
  language     text DEFAULT 'en' check (length(language) = 2),
  active       boolean default true,  -- true = active user
  PRIMARY KEY(userid, handle)
);

GRANT ALL PRIVILEGES ON tq_authentication.users TO tq_users;
GRANT SELECT ON tq_authentication.users TO tq_users_ro;

-- Create an index on the email column.
CREATE INDEX IF NOT EXISTS users_idx
  ON tq_authentication.users (email);

-- Encrypt the password for in inserted user.
CREATE OR REPLACE FUNCTION
tq_authentication.encrypt_password() returns trigger
  language plpgsql
  as $$
begin
  if tg_op = 'INSERT' or new.password <> old.password then
    new.password = crypt(new.password, gen_salt('bf'));
  end if;
  return new;
end
$$;

-- Trigger on insert into users table to encrypt the password.
CREATE TRIGGER encrypt_password
  before insert or update on tq_authentication.users
  for each row
  execute procedure tq_authentication.encrypt_password();

-- Validate a password for a given handle. Return the user ID if valid.
CREATE OR REPLACE FUNCTION
tq_authentication.user_locator(handle text, password text) returns name
  LANGUAGE plpgsql
  AS $$
BEGIN
  RETURN (
  SELECT userid FROM tq_authentication.users
   WHERE users.handle = user_locator.handle
     AND users.password = crypt(user_locator.password, users.password)
  );
END;
$$;

--
-- Create audit record for authentication changes.
--
CREATE TRIGGER tablename_audit_users
  AFTER INSERT OR DELETE OR UPDATE ON tq_authentication.users FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

--
-- Create a schema to hide the proxy tables from public view.
--
CREATE SCHEMA IF NOT EXISTS tq_contents;
GRANT ALL ON schema tq_contents TO tq_proxy;
GRANT USAGE ON schema tq_contents TO tq_proxy_ro;

CREATE TABLE IF NOT EXISTS
tq_contents.proxy (
  proxyid      locator UNIQUE,
  userid       locator references tq_authentication.users(userid),
  node_type    text,
  url          text,
  version      text,
  is_virtual   boolean DEFAULT false,
  is_private   boolean DEFAULT false,
  is_live      boolean DEFAULT true,
  PRIMARY KEY (proxyid, userid)
);

GRANT ALL PRIVILEGES ON tq_contents.proxy TO tq_proxy;
GRANT SELECT ON tq_contents.proxy TO tq_proxy_ro;

--
-- Create audit record for proxy changes.
--
CREATE TRIGGER tablename_audit_proxy
  AFTER INSERT OR DELETE OR UPDATE ON tq_contents.proxy FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

--
-- Table to hold merge tuple locators.
--
CREATE TABLE IF NOT EXISTS
tq_contents.merge_tuple_locators (
  proxyid      locator NOT NULL references tq_contents.proxy(proxyid),
  mtlocator    locator, -- merge tuple locator: many locators can be
                        -- associated with a proxy
  PRIMARY KEY (proxyid, mtlocator)
);

GRANT ALL PRIVILEGES ON tq_contents.merge_tuple_locators TO tq_proxy;
GRANT SELECT ON tq_contents.merge_tuple_locators TO tq_proxy_ro;

--
-- Table to hold superclass IDs.
--
CREATE TABLE IF NOT EXISTS
tq_contents.superclasses (
  proxyid      locator NOT NULL references tq_contents.proxy(proxyid),
  superclass   text  -- superclass locator
);

GRANT ALL PRIVILEGES ON tq_contents.superclasses TO tq_proxy;
GRANT SELECT ON tq_contents.superclasses TO tq_proxy_ro;

--
-- Create audit record for superclasses changes.
--
CREATE TRIGGER tablename_audit_proxy_superclasses
  AFTER INSERT OR DELETE OR UPDATE ON tq_contents.superclasses FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

--
-- Table to hold superclass PSIs.
--
CREATE TABLE IF NOT EXISTS
tq_contents.psi (
  proxyid      locator NOT NULL references tq_contents.proxy(proxyid),
  psi          text
);
CREATE INDEX IF NOT EXISTS psi_idx
  ON tq_contents.psi (proxyid, psi);

GRANT ALL PRIVILEGES ON tq_contents.psi TO tq_proxy;
GRANT SELECT ON tq_contents.psi TO tq_proxy_ro;

--
-- Create audit record for psi changes.
--
CREATE TRIGGER tablename_audit_proxy_psi
  AFTER INSERT OR DELETE OR UPDATE ON tq_contents.psi FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

--
-- Table to hold properties.
--
CREATE TABLE IF NOT EXISTS
tq_contents.properties (
  proxyid      locator NOT NULL references tq_contents.proxy(proxyid),
  property_key text,
  property_val text
);
CREATE INDEX IF NOT EXISTS properties_idx
  ON tq_contents.properties (proxyid, property_key);

GRANT ALL PRIVILEGES ON tq_contents.properties TO tq_proxy;
GRANT SELECT ON tq_contents.properties TO tq_proxy_ro;

--
-- Create audit record for properties changes.
--
CREATE TRIGGER tablename_audit_proxy_properties
  AFTER INSERT OR DELETE OR UPDATE ON tq_contents.properties FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

--
-- Table to hold transitive closure.
--
CREATE TABLE IF NOT EXISTS
tq_contents.transitive_closure (
  proxyid       locator NOT NULL references tq_contents.proxy(proxyid),
  property_type text
);
CREATE INDEX IF NOT EXISTS transitive_closure_idx
  ON tq_contents.transitive_closure (proxyid, property_type);

GRANT ALL PRIVILEGES ON tq_contents.transitive_closure TO tq_proxy;
GRANT SELECT ON tq_contents.transitive_closure TO tq_proxy_ro;

--
-- Create audit record for transitive closure changes.
--
CREATE TRIGGER tablename_audit_proxy_transitive_closure
  AFTER INSERT OR DELETE OR UPDATE ON tq_contents.transitive_closure FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

--
-- Table to hold ACL information.
--
CREATE TABLE IF NOT EXISTS
tq_contents.acls (
  proxyid       locator NOT NULL references tq_contents.proxy(proxyid),
  acl           text
);
CREATE INDEX IF NOT EXISTS acls_idx
  ON tq_contents.acls (proxyid, acl);

GRANT ALL PRIVILEGES ON tq_contents.acls TO tq_proxy;
GRANT SELECT ON tq_contents.acls TO tq_proxy_ro;

--
-- Create audit record for ACL changes.
--
CREATE TRIGGER tablename_audit_proxy_acls
  AFTER INSERT OR DELETE OR UPDATE ON tq_contents.acls FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

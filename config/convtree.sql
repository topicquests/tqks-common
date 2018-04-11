--
-- Create a schema to hide the conversation tree table from public view.
--
CREATE SCHEMA IF NOT EXISTS tq_tree;
GRANT ALL ON schema tq_tree TO tq_conv;
GRANT USAGE ON schema tq_tree TO tq_conv_ro;

COMMENT ON SCHEMA tq_tree IS 'Tables to store the conversation tree.';

-- Install the pgcrypto extension.
SET ROLE postgres;
CREATE EXTENSION IF NOT EXISTS ltree;

SET ROLE tq_admin;

CREATE TABLE IF NOT EXISTS
tq_tree.conv (
    id          bigserial primary key,
    context     locator,
    lox         locator,
    parent_lox  locator,
    parent_path ltree
);
CREATE INDEX IF NOT EXISTS conv_path_idx
  ON tq_tree.conv USING gist(parent_path);

CREATE INDEX IF NOT EXISTS conv_loc_idx
  ON tq_tree.conv (context, lox);

CREATE INDEX conv_parent_lox_idx ON tq_tree.conv (parent_lox);

GRANT ALL PRIVILEGES ON tq_tree.conv TO tq_conv;
GRANT SELECT ON tq_tree.conv TO tq_conv_ro;

GRANT ALL PRIVILEGES ON tq_tree.conv_id_seq TO tq_conv;
GRANT SELECT ON tq_tree.conv_id_seq TO tq_conv_ro;

--
-- Function to generate the path in the tree for the inserted locator.
--
CREATE OR REPLACE FUNCTION tq_tree.update_conv_parent_path() RETURNS TRIGGER AS $$
DECLARE
   path    ltree;
   rootstr text;
BEGIN
   IF NEW.parent_lox = '' THEN
      rootstr = 'root' || NEW.id;
      NEW.parent_path = rootstr::ltree;
   ELSEIF TG_OP = 'INSERT' OR OLD.parent_lox IS NULL OR OLD.parent_lox != NEW.parent_lox THEN
      SELECT parent_path || NEW.id::text FROM tq_tree.conv
         WHERE lox = NEW.parent_lox AND context = NEW.context INTO path;
      IF path IS NULL THEN
         RAISE EXCEPTION 'Invalid parent_lox %', NEW.parent_lox;
      END IF;
      NEW.parent_path = path;
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER parent_path_tgr
   BEFORE INSERT OR UPDATE ON tq_tree.conv
   FOR EACH ROW EXECUTE PROCEDURE tq_tree.update_conv_parent_path();
    
--
-- Create audit record for conversation tree changes.
--
CREATE TRIGGER tablename_audit_tree
  AFTER INSERT OR DELETE OR UPDATE ON tq_tree.conv FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

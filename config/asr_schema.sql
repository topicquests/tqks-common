DO
$do$
BEGIN
   IF NOT EXISTS (
      SELECT
      FROM   pg_catalog.pg_roles
      WHERE  rolname = 'tq_proxy') THEN

      CREATE ROLE tq_proxy INHERIT;
   END IF;
END
$do$;

--
-- Create a schema to hide the proxy tables from public view.
--
CREATE SCHEMA IF NOT EXISTS tqos_asr;
GRANT ALL ON schema tqos_asr TO tq_proxy;

CREATE TABLE IF NOT EXISTS 
tqos_asr.sentences (
	id text NOT NULL PRIMARY KEY,
	docid text NOT NULL,
	parid text DEFAULT '',
	sentence text NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_id ON tqos_asr.sentences (id);
CREATE INDEX IF NOT EXISTS idx_doc ON tqos_asr.sentences (docId);
CREATE INDEX IF NOT EXISTS idx_par ON tqos_asr.sentences (parId);

GRANT ALL PRIVILEGES ON tqos_asr.sentences TO tq_proxy;

CREATE TABLE IF NOT EXISTS 
tqos_asr.documents (
	id text NOT NULL PRIMARY KEY,
	document text NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_doc_id ON tqos_asr.documents (id);

GRANT ALL PRIVILEGES ON tqos_asr.documents TO tq_proxy;

CREATE TABLE IF NOT EXISTS 
tqos_asr.tuples (
	id text NOT NULL PRIMARY KEY,
	tuple text NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_tup_id ON tqos_asr.tuples (id);

GRANT ALL PRIVILEGES ON tqos_asr.tuples TO tq_proxy;

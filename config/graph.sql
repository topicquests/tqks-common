--
-- Create a schema to hide the  tables from public view.
-- This builds on the established roles from the tq schema
--
CREATE SCHEMA IF NOT EXISTS tq_graph;
GRANT ALL ON schema tq_graph TO tq_proxy;
GRANT USAGE ON schema tq_graph TO tq_proxy_ro;

CREATE TABLE IF NOT EXISTS 
tq_graph.vertices (
	id text NOT NULL PRIMARY KEY,
	label text NOT NULL
);

GRANT ALL PRIVILEGES ON tq_graph.vertices TO tq_proxy;
GRANT SELECT ON tq_graph.vertices TO tq_proxy_ro;

CREATE INDEX IF NOT EXISTS idx_vertex_ids
	ON tq_graph.vertices (id);

CREATE INDEX IF NOT EXISTS idx_vertex_labels
	ON tq_graph.vertices (label);

CREATE TABLE IF NOT EXISTS 
tq_graph.edges (
	id text NOT NULL PRIMARY KEY,
	vertex_out text NOT NULL,
	vertex_in text NOT NULL,
	label text NOT NULL,
	CONSTRAINT fk_vertex_out FOREIGN KEY (vertex_out) REFERENCES tq_graph.vertices (id)
 		ON DELETE CASCADE,
	CONSTRAINT fk_vertex_in FOREIGN KEY (vertex_in) REFERENCES tq_graph.vertices (id)
		ON DELETE CASCADE
);

GRANT ALL PRIVILEGES ON tq_graph.edges TO tq_proxy;
GRANT SELECT ON tq_graph.edges TO tq_proxy_ro;

CREATE INDEX IF NOT EXISTS idx_edge_ids
	ON tq_graph.edges (id);

CREATE INDEX IF NOT EXISTS idx_edge_out
	ON tq_graph.edges (vertex_out);

CREATE INDEX IF NOT EXISTS idx_edge_in
	ON tq_graph.edges (vertex_in);

CREATE INDEX IF NOT EXISTS idx_edge_labels
	ON tq_graph.edges (label);

CREATE TABLE IF NOT EXISTS 
tq_graph.vertex_properties (
	vertex_id text NOT NULL,
	key text NOT NULL,
	value TEXT,
	CONSTRAINT fk_vertex FOREIGN KEY (vertex_id) REFERENCES tq_graph.vertices (id)
		ON DELETE CASCADE
);

GRANT ALL PRIVILEGES ON tq_graph.vertex_properties TO tq_proxy;
GRANT SELECT ON tq_graph.vertex_properties TO tq_proxy_ro;

CREATE INDEX IF NOT EXISTS idx_vertex_properties 
	ON tq_graph.vertex_properties (key);
CREATE INDEX IF NOT EXISTS idx_vertex_properties_2
	ON tq_graph.vertex_properties (left(value, 200));
	
CREATE TABLE IF NOT EXISTS 
tq_graph.edge_properties (
	edge_id text NOT NULL,
	key text NOT NULL,
	value TEXT,
	CONSTRAINT fk_edge FOREIGN KEY (edge_id) REFERENCES tq_graph.edges (id)
		ON DELETE CASCADE
);

GRANT ALL PRIVILEGES ON tq_graph.edge_properties TO tq_proxy;
GRANT SELECT ON tq_graph.edge_properties TO tq_proxy_ro;

CREATE INDEX IF NOT EXISTS idx_edge_properties 
	ON tq_graph.edge_properties (key);
CREATE INDEX IF NOT EXISTS idx_edge_properties_2 
	ON tq_graph.edge_properties (left(value, 200));
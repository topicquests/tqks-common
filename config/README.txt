PostgreSQL database configuration
---------------------------------
Install the repository RPM:

yum install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-1.noarch.rpm

Install the client packages:

yum install postgresql10

Optionally install the server packages:

yum install postgresql10-server

Optionally initialize the database and enable automatic start:

/usr/pgsql-10/bin/postgresql-10-setup initdb
systemctl enable postgresql-10
systemctl start postgresql-10

yum -y install postgresql10-contrib



How to set up a PostgreSQL database for topic maps
--------------------------------------------------

The SQL script postgres-setup.sql must be run as the database
superuser to set up the necessary roles, tablespace, database, schemas
and tables.

In the script, we set up a tablespace for all TopicQuest content. The
tablespace needs a location to store the data files. We need to set up
the directory for this. On Linux, you can run

sudo su - postgres
mkdir -p /var/lib/pgsql/tq

If you wish to change the location of the datafiles for the
tablespace, change the location in the CREATE TABLESPACE command and
create the directory as the postgres user.

Once the tablespace location directory has been created, you can run
the SQL script postgres-setup.sql by running the command

sudo -u postgres psql -a -f <path to postgres-setup.sql> template1

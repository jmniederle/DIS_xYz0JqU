sudo -i -u postgres createdb uni
sudo -i -u postgres psql -d uni -a -f createTables.sql


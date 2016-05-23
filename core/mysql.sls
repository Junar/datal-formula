{% set distrib_codename = salt['grains.get']('lsb_distrib_codename', '') %}

mysql:
  pkg.installed:
    - refresh: True
    - pkgs:
      {% if distrib_codename == "xenial" %}
      - mysql-server-5.7
      {% else %}
      - mysql-server-5.5
      {% endif %}
      - libmysqlclient-dev
      - python-mysqldb

{{ pillar['database']['user'] }}:
  mysql_user.present:
    - host: localhost
    - password: {{ pillar['database']['password'] }}

temporally_clear_db:
  mysql_database.absent:
    - name: {{ pillar['database']['name'] }}

{{ pillar['database']['name'] }}:
  mysql_database.present

test_{{ pillar['database']['name'] }}:
  mysql_database.present

db_perms:
  mysql_grants.present:
    - grant: all privileges
    - database: {{ pillar['database']['name'] }}.*
    - user: {{ pillar['database']['user'] }}

test_db_perms:
  mysql_grants.present:
    - grant: all privileges
    - database: test_{{ pillar['database']['name'] }}.*
    - user: {{ pillar['database']['user'] }}


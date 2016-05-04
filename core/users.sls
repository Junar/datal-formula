# User and Group settings
create_group:
  group.present:
    - name: {{ pillar['system']['group'] }}

create_user:
  user.present:
    - name: {{ pillar['system']['user'] }}
    - fullname: {{ pillar['system']['user'] }}
    - shell: /bin/bash
    - home: {{ pillar['system']['home'] }}
    - enforce_password: True
    - password: {{ pillar['system']['user_password_hash'] }}
    - groups:
      - {{ pillar['system']['group'] }}


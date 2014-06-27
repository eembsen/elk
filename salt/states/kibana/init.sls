nginx_kibana:
  pkg.installed:
    - name: nginx
    - version: {{ pillar['kibana_nginx_version'] }}

untar_kibana:
  archive.extracted:
    - source: https://download.elasticsearch.org/kibana/kibana/kibana-{{ pillar['kibana_version'] }}.tar.gz
    - source_hash: {{ pillar['source_hash'] }}
    - name: {{ pillar['install_dir'] }}
    - archive_format: tar
    - tar_options: z
    - if_missing: /opt/kibana-{{ pillar['kibana_version'] }}

group_kibana:
  group.present:
    - name: kibana
    - system: True

user_kibana:
  user.present:
    - name: kibana
    - fullname: Kibana Runtime User
    - shell: /bin/nologin
    - home: /opt/kibana-{{ pillar['kibana_version'] }}
    - system: True
    - gid_from_name: True

symlink_kibana:
  file.managed:
    - name: /usr/share/nginx/html/kibana
    - target: /opt/kibana-{{ pillar['kibana_version'] }}
    - force: True

chown_kibana:
  file.directory:
    - name: /opt/kibana-{{ pillar['kibana_version'] }}
    - user: kibana
    - group: kibana
    - recurse:
      - user
      - group

config_kibana:
  file.managed:
    - name: /opt/kibana-{{ pillar['kibana_version'] }}/config.js
    - source: salt://kibana/files/config.js
    - mode: 644
    - template: jinja

#upstart_nginx:
#  file.managed:
#    - name: /etc/init/kibana.conf
#    - source: salt://kibana/files/elasticsearch.upstart.conf
#    - mode: 644
#    - template: jinja
#
#service_kibana:
#  service:
#    - name: kibana
#    - running

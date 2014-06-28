untar_logstash:
  archive.extracted:
    - source: https://download.elasticsearch.org/logstash/logstash/logstash-{{ pillar['logstash_version'] }}.tar.gz
    - source_hash: {{ pillar['source_hash'] }}
    - name: {{ pillar['install_dir'] }}
    - archive_format: tar
    - tar_options: z
    - if_missing: /opt/logstash-{{ pillar['logstash_version'] }}

group_logstash:
  group.present:
    - name: logstash
    - system: True

user_logstash:
  user.present:
    - name: logstash
    - fullname: Kibana Runtime User
    - shell: /bin/nologin
    - home: /opt/logstash-{{ pillar['logstash_version'] }}
    - system: True
    - gid_from_name: True

chown_logstash:
  file.directory:
    - name: /opt/logstash-{{ pillar['logstash_version'] }}
    - user: logstash
    - group: logstash
    - recurse:
      - user
      - group

config_logstash:
  file.managed:
    - name: /opt/logstash-{{ pillar['logstash_version'] }}/logstash.conf
    - source: salt://logstash/files/logstash.conf
    - mode: 644
    - template: jinja

untar_elasticsearch:
  archive.extracted:
    - source: https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-{{ pillar['version'] }}.tar.gz
    - source_hash: {{ pillar['source_hash'] }}
    - name: {{ pillar['install_dir'] }}
    - archive_format: tar
    - tar_options: z
    - if_missing: /opt/elasticsearch-{{ pillar['version'] }}

group_elasticsearch:
  group.present:
    - name: elasticsearch
    - system: True

user_elasticsearch:
  user.present:
    - name: elasticsearch
    - fullname: Elasticsearch Runtime User
    - shell: /bin/nologin
    - home: /opt/elasticsearch-{{ pillar['version'] }}
    - system: True
    - gid_from_name: True

chown_elasticsearch:
  file.directory:
    - name: /opt/elasticsearch-{{ pillar['version'] }}
    - user: elasticsearch
    - group: elasticsearch
    - recurse:
      - user
      - group

config_elasticsearch:
  file.managed:
    - name: /opt/elasticsearch-{{ pillar['version'] }}/config/elasticsearch.yml
    - source: salt://elasticsearch/files/elasticsearch.yml
    - mode: 644
    - template: jinja

upstart_elasticsearch:
  file.managed:
    - name: /etc/init/elasticsearch.conf
    - source: salt://elasticsearch/files/elasticsearch.upstart.conf
    - mode: 644
    - template: jinja

service_elasticsearch:
  service:
    - name: elasticsearch
    - running

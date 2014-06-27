untar_elasticsearch:
  archive.extracted:
    - source: https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.tar.gz
    - source_hash: md5=327fa4ab2a4239972c7ce53832e50c02
    - name: /opt/
    - archive_format: tar
    - tar_options: z
    - if_missing: /opt/elasticsearch-1.2.1

group_elasticsearch:
  group.present:
    - name: elasticsearch
    - system: True

user_elasticsearch:
  user.present:
    - name: elasticsearch
    - fullname: Elasticsearch Runtime User
    - shell: /bin/nologin
    - home: /opt/elasticsearch-1.2.1
    - system: True
    - gid_from_name: True

chown_elasticsearch:
  file.directory:
    - name: /opt/elasticsearch
    - user: elasticsearch
    - group: elasticsearch
    - recurse:
      - user
      - group

init_elasticsearch:
  file.managed:
    - name: /etc/init.d/elasticsearch
    - source: salt://elasticsearch/files/elasticsearch
    - mode: 755

chkconfig_elasticsearch:
  cmd.run:
    - name: chkconfig elasticsearch on

service_elasticsearch:
  service:
    - name: elasticsearch
    - running

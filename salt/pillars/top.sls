base:
  'elastic1.localdomain':
    - elasticsearch/elastic_domain_01
    - logstash/default
  'elastic2.localdomain':
    - elasticsearch/elastic_domain_01
  'kibana.localdomain':
    - kibana/default

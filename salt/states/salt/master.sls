salt-master:
  service:
    - running
    - name: salt-master
    - enable: True
  cron:
    - absent
    - name: salt \* state.highstate

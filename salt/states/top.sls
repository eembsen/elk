base:
  '*':
    - base
    - iptables
    - salt.minion

  'master*':
    - salt.master

  'buildserver*':
    - java.openjdk.7
    - xlrelease
    - xldeploy.server
    - jenkins
    # - stash

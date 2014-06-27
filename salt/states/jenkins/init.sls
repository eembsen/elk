jenkins-repo:
  pkgrepo:
    - managed
    - name: jenkins
    - humanname: Jenkins-stable
    - baseurl: http://pkg.jenkins-ci.org/redhat-stable
    - gpgcheck: 0

jenkins-pkg:
  pkg:
    - installed
    - name: jenkins
    - fromrepo: jenkins

jenkins-service:
  service:
    - running
    - name: jenkins
    - enable: True

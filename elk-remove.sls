
filebeat:
  pkg:
    - removed

/etc/yum.repos.d/elk.repo:
  file.absent

/etc/profile.d/elk.sh:
  file.absent

/usr/local/sbin/bounce.filebeat:
  file.absent

rm -rf /etc/filebeat:
  cmd.run


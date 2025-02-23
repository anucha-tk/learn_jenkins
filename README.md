# Learning jenkins
- [Learning jenkins](#learning-jenkins)
  - [SSH](#ssh)
    - [Create key](#create-key)
    - [access](#access)
  - [MYSQL \& MinIO](#mysql--minio)
    - [Access mysql from remote-host](#access-mysql-from-remote-host)
    - [Dump database](#dump-database)

## SSH
### Create key
on centos7 folder create key
```bash
ssh-keygen -f remote-key
```
### access
```bash
ssh -i /tmp/remote-key remote_user@remote_host
```

## MYSQL & MinIO
### Access mysql from remote-host
make sure remote-host install `mysql-server`
```bash
root#remote: mysql -u root -h db_host -p
```
### Dump database
```bash
root#remote: mysqldump -u root -h db_host -p testdb > /tmp/db.sql
```
# Learning jenkins

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
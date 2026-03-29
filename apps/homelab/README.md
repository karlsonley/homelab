# Jottacloud NAS Backup (`jottacloud-backup.yaml`)

Daily backup of the Ugreen NAS (`10.0.2.100`) to Jottacloud using rclone, orchestrated by a Kubernetes CronJob.

## One-Time Setup

```bash
ssh <user>@10.0.2.100

# Install rclone
curl https://rclone.org/install.sh | sudo bash

# Configure the Jottacloud remote (interactive — follow the prompts)
rclone config
```

### Re-authenticating Jottacloud

If the rclone OAuth token expires, SSH into the NAS and run:

```bash
rclone config reconnect jottacloud:
```

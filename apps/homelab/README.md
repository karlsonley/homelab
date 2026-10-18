# Forgejo (`forgejo.yaml`)

## One-Time Setup: OIDC Authentication

After the initial deployment, configure Pocket-ID as the OIDC provider by running the following against the Forgejo pod:

```bash
DB_PASS=$(kubectl get secret -n forgejo forgejo-db-password -o jsonpath='{.data.password}' | base64 -d)
OIDC_ID=$(kubectl get secret -n forgejo forgejo-oidc -o jsonpath='{.data.client_id}' | base64 -d)
OIDC_SECRET=$(kubectl get secret -n forgejo forgejo-oidc -o jsonpath='{.data.client_secret}' | base64 -d)

kubectl exec -n forgejo deployment/forgejo -- /bin/sh -c "
  mkdir -p /tmp/conf
  cat > /tmp/conf/app.ini <<EOF
[database]
DB_TYPE  = postgres
HOST     = forgejo-postgres-rw:5432
NAME     = forgejo
USER     = forgejo
PASSWD   = ${DB_PASS}
SSL_MODE = disable
[security]
INSTALL_LOCK = true
[server]
APP_DATA_PATH = /tmp/forgejo-data
EOF
  forgejo --config /tmp/conf/app.ini admin auth add-oauth \
    --name 'pocket-id' \
    --provider openidConnect \
    --key '${OIDC_ID}' \
    --secret '${OIDC_SECRET}' \
    --auto-discover-url 'https://pocket-id.sonley.dev/.well-known/openid-configuration' \
    --scopes 'openid,profile,email'
"
```


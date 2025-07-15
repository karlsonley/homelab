ACCESS_KEY_ID=$(scw secret version access revision=1 region=nl-ams raw=true field=access_key_id 1467808a-4c08-46e2-b09f-42ac6fecd250)
SECRET_KEY=$(scw secret version access revision=1 region=nl-ams raw=true field=secret_key 1467808a-4c08-46e2-b09f-42ac6fecd250)

kubectl create secret generic scw-secrets-manager \
    --from-literal=access-key-id=$ACCESS_KEY_ID \
    --from-literal=secret-key=$SECRET_KEY

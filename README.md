# CAT-CHAT
## An application for some demo deployment strategies

### Dockerfile + pg + puma (no webserver)
This is a pretty basic setup with some defaults that could be improved. The default db user is
`postgres`, so if you wanted a specific user, you would need to create one and give it its own
credentials. I am setting a db password via host environment.

Build the image:

```bash
# Generate secret_key_base
  rails secret

# Set up your secret key with editor of your choice and put in secret_key_base: XXX. Save and exit.
  EDITOR="code --wait" rails credentials:edit

  export CAT_CHAT_DB_PW=XXXXXXXXXXXX

  make build-puma-pg
```

Run the image:

```bash
  make run-puma-pg
```

Stop and remove the container:

```bash
  make kill-puma-pg
```

### Cleanup docker

```bash
  make docker-clean
```

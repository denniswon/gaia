# gaia-docker

## Configuration
- Install make command `xcode-select --install` (Macos only)
- Edit `Dockerfile` update `DISTROLESS_TAG`, `IMG_TAG`, `GIT_SRC`
- Copy .env.example to .env, Edit `.env` update parameters for your own need

- build docker image
    ```shell
    make dev-build
    ```

## Bootstrap & Start Cluster
- bootstrap validator data
    ```
    make dev-init-validator
    ```
    - Old validator data is reset
    - New validator data is boostraped at `storage` folder

- bootstrap node data
    ```
    make dev-init-node
    ```
    - Old node data is reset
    - New node data is boostraped at `storage` folder

- start cluster
    ```
    make dev-start-cluster
    ```
    - Go to http://localhost:9000/, register admin user and select the first option: `Docker`

## Cleanup
```
make dev-reset
```

## Concerns
- `persistent-peers` currently using ip, not dns, might have an issue when running on production container
- need to decide `keyring-backend` (possibly implement `gpg`) instead of `test` on local setup
- How to seed default currency & amount?

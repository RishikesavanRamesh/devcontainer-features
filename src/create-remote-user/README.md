
# Create remote user with specific uid and gid (create-remote-user)

Creates user with specified uid and gid and remove if user with the specified uid already presents.

## Example Usage

```json
"features": {
    "ghcr.io/RishikesavanRamesh/devcontainer-features/create-remote-user:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| userUid | Enter UID for non-root user | string | 1001 |
| userGid | Enter GID for non-root user | string | 1001 |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/RishikesavanRamesh/devcontainer-features/blob/main/src/create-remote-user/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._

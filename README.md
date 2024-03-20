# Gatling Enterprise Certified Docker images for dedicated load generators

These image is published to [Docker Hub](
https://hub.docker.com/r/gatlingcorp/dedicated-load-generator).
The purpose is to ease the configuration of a dedicated host for generating
load with [Gatling Enterprise](https://gatling.io/products) (self-hosted or
private locations for cloud).
You can fork this repository or use the generated image as a base for your own
needs.

## Using the gatlingcorp/dedicated-load-generator image

```console
docker run \
  --publish 22:22 \
  --rm \
  -e PUBLIC_KEY="$(cat ~/.ssh/id_ed25519.pub)" \
  gatlingcorp/dedicated-load-generator
```

## Parameters

|                            Parameter                             | Function                                                                                                |
|:----------------------------------------------------------------:|---------------------------------------------------------------------------------------------------------|
|                           `-p 2222:22`                           | ssh port                                                                                                |
|                  `-e PUBLIC_KEY=yourpublickey`                   | Optional ssh public key, which will automatically be added to authorized_keys.                          |
|                `-e PUBLIC_KEY_FILE=/path/to/file`                | Optionally specify a file in the container containing the public key (works with docker secrets).       |
| `-e PUBLIC_KEY_DIR=/path/to/directory/containing/_only_/pubkeys` | Optionally specify a directory in the container containing the public keys (works with docker secrets). |
|       `-e PUBLIC_KEY_URL=https://github.com/username.keys`       | Optionally specify a URL containing the public key.                                                     |
|                   `-e USER_NAME=gatling-user`                    | Optionally specify a user name (Default:`gatling-user`)                                                 |

You need at least to define one public key parameter.

## What's inside

 * debian bullseye base
 * Azul Zulu openjdk 21
 * jq
 * curl

## Developing

```console
docker buildx build --tag gatlingcorp/dedicated-load-generator:local .
```

This base image is using a deprecated format, and I was getting an error of:
```
buildx failed with: ERROR: failed to solve: failed to load cache key: Pulling Schema 1 images have been deprecated and disabled by default since containerd v2.0. As a workaround you may set an environment variable `CONTAINERD_ENABLE_DEPRECATED_PULL_SCHEMA_1_IMAGE=1`, but this will be completely removed in containerd v2.1.
```
So as a solution I built locally (which didn't have the containerd issue yet) and pushed to github


My local commands:

(Password for login is the token generated at https://github.com/settings/tokens/new?scopes=write:packages)

```bash
docker login ghcr.io -u seansaleh
docker build . --tag ghcr.io/seansaleh/php:5.4.45-apache-with-pluginsV2
docker push ghcr.io/seansaleh/php:5.4.45-apache-with-pluginsV2
```

And then I made the package public at https://github.com/users/seansaleh/packages/container/php/settings

You can use it with `ghcr.io/seansaleh/php:5.4.45-apache-with-pluginsV2`

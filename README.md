sonarr
======

sonarr - http://sonarr.tv

Latest sonarr Git Test branch from Arch Linux AUR using Packer to compile.

**Pull image**

```
docker pull atbell/arch-sonarr
```

**Run container**

```
docker run -d -p 8989:8989 --name=<container name> -v <path for media files>:/media -v <path for data files>:/data -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro atbell/arch-sonarr
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

```
http://<host ip>:8989
```

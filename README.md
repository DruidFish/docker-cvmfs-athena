Centos7 images for Athena development
=====================================

Since I've been running my own Docker container for Athena development for ages, seemed like time to tidy everything up and do it properly.

There are two versions of this container: one using an internal CVMFS mount, and one using CVMFS provided by the host system

Internal CVMFS
--------------

Centos7 causes some Systemd-related headaches when running CVMFS inside a Docker container.
The workaround is provided with a replacement to systemctl.

https://stackoverflow.com/questions/50393525/failed-to-get-d-bus-connection-operation-not-permitted

https://github.com/gdraheim/docker-systemctl-replacement

To run the container (with a shared workdir) use:
```
sudo docker run --privileged -i -t -v $PWD/workdir:/workdir bwynne/centos7-cvmfs-athena
```

External CVMFS
--------------

The internal CVMFS mount doesn't seem to be 100% reliable, and is definitely on the slow side.
You can use a version of this container where the host OS provides CVMFS, just as suggested in the CVMFS documentation.

https://cvmfs.readthedocs.io/en/latest/cpt-containers.html#mounting-cvmfs-inside-a-container

To run the container (with a shared workdir and CVMFS mount) use:
```
sudo docker run --privileged -i -t -v $PWD/workdir:/workdir -v /cvmfs:/cvmfs:shared bwynne/centos7-athena
```

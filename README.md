# docker-replica [![Circle CI](https://circleci.com/gh/AlbanMontaigu/docker-replica.svg?style=shield)](https://circleci.com/gh/AlbanMontaigu/docker-replica)

## Purpose

This project is a two host replication solution with simple unison / ssh couple.

It aims to be as simple and "easy to configure" as possible. It means that it's not ready "as it" for production purpose.

## Usage

Basically you need to start 2 containers based on:
- amontaigu/replica-slave
- amontaigu/replica-master

To run your replica-master container:

```bash
docker run -d --rm -p 2222:22 -v /var/replica:/var/replica amontaigu/replica-slave
```

To run your replica-master container:

```bash
docker run -d --rm -v /var/replica:/var/replica -e REPLICA_SLAVE_HOST="xx.xx.xx.xx" -e REPLICA_SLAVE_PORT="2222" amontaigu/replica-master
```

`xx.xx.xx.xx`to be replaced by your remote host ip.

## Data storage

By default each container will store it's data to the `REPLICA_DATA_DIR` environment variable. 

Default value is `/var/replica` but you can change it in your `docker run` commands with the `-e REPLICA_DATA_DIR="/your/path"` flag.

Don't forget to use docker volumes flags in your `docker run` commands to mount any local path to the replica containers. Otherwise data will stay only in `replica-slave` and `replica-master` containers.

At the root of `REPLICA_DATA_DIR` you can add a file with the name `SYNC_PATHS` to specify the specific path you want to sync insideyour dir:

```
# Sub path to sync (compliant with unison configuration format)
path=subfolder1
path=subfolder2/subfolder 3
```

If this file not exist all files / folder will be sync.

## License

This project is licensed under the terms of the MIT license.

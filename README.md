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

Each container will store it's data internally where the `REPLICA_DATA_DIR` environment variable says. 

Default value is `/var/replica` but you can change it in your `docker run` commands with the `-e REPLICA_DATA_DIR="/your/path"` flag.

Don't forget to use docker volumes flags in your `docker run` commands to mount any local path to the replica containers. Otherwise data will stay only in `replica-slave` and `replica-master` containers.

At the root of `REPLICA_DATA_DIR` you can add a file with the name `SYNC_PATHS` to specify the specific path you want to sync inside your dir:

```
# Sub path to sync (compliant with unison configuration format)
path=subfolder1
path=subfolder2/subfolder 3
```

If this file not exist all files / folder will be sync.

**Important**

By default unison is configured with `repeat = watch` option. Meaning it will rely on file system notification to detect changes fore resync.

Unfortunately, filesystem notification may not work in case of volume mounting in docker. Here you can make a workaround by setting `-e UNISON_PRF_REPEAT="1"` **on replica-slave** to tell unison to sync every 1 sec instead of waiting for file system notifications.

See [Unison documentation](http://www.cis.upenn.edu/~bcpierce/unison/download/releases/stable/unison-manual.html) for more information on configuration.

## License

This project is licensed under the terms of the MIT license.

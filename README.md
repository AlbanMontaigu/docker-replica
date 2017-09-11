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
docker run -d --rm -p 2222:22 amontaigu/replica-slave
```

To run your replica-master container:

```bash
docker run -d --rm -e REPLICA_SLAVE_HOST="xx.xx.xx.xx" -e REPLICA_SLAVE_PORT="2222" amontaigu/replica-master
```

`xx.xx.xx.xx`to be replaced by your remote host ip.

## License

This project is licensed under the terms of the MIT license.
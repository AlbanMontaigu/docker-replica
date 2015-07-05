DOCKER_IMG_TAG = 0.1
DOCKER_IMG_NAME = replica-master

DOCKER_IMG_FULL_NAME = $(DOCKER_IMG_NAME):$(DOCKER_IMG_TAG)

DOCKER_CMD = docker

build:
	# Build that image
	$(DOCKER_CMD) build -t $(DOCKER_IMG_FULL_NAME) .

run:
	# Run that image
	rm -rf /tmp/replica-master
	mkdir /tmp/replica-master
	$(DOCKER_CMD) run -d --name $(DOCKER_IMG_NAME) --link replica-slave -v /tmp/replica-master:/var/local/replica-data $(DOCKER_IMG_FULL_NAME)

rm:
	# Remove that container
	$(DOCKER_CMD) rm $(DOCKER_IMG_NAME)

start:
	# Start that container
	$(DOCKER_CMD) start $(DOCKER_IMG_NAME)

stop:
	# Stop that image
	$(DOCKER_CMD) stop $(DOCKER_IMG_NAME)

test:
	# Run a client to test the image
	$(DOCKER_CMD) run -it --rm --link replica-slave --entrypoint /bin/sh $(DOCKER_IMG_FULL_NAME)

.PONY: build
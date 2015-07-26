DOCKER_IMG_TAG = 0.1
DOCKER_IMG_NAME = replica-slave

DOCKER_IMG_FULL_NAME = $(DOCKER_IMG_NAME):$(DOCKER_IMG_TAG)

DOCKER_CMD = docker

build:
	# Build that image
	$(DOCKER_CMD) build -t $(DOCKER_IMG_FULL_NAME) .

run:
	# Run that image
	rm -rf /tmp/replica-slave
	mkdir /tmp/replica-slave
	$(DOCKER_CMD) run -d --name $(DOCKER_IMG_NAME) -v /tmp/replica-slave:/var/local/replica-data $(DOCKER_IMG_FULL_NAME)

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
	$(DOCKER_CMD) run -it --rm --link $(DOCKER_IMG_NAME) -e HOST=$(DOCKER_IMG_NAME) trsouz/ssh $(DOCKER_IMG_NAME)@$(DOCKER_IMG_NAME)

.PONY: build
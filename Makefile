CURRENT_DIRECTORY := $(shell pwd)
include environment

build:
	sed -i.bak 's|^FROM.*|FROM $(DOCKER_BASE)|' Dockerfile && \
	docker build --build-arg FILEBEAT_VERSION=$(FILEBEAT_VERSION) --build-arg FILEBEAT_DOWNLOAD_URL=$(FILEBEAT_DOWNLOAD_URL) -t $(DOCKER_USER)/filebeat --rm=true . && \
	mv Dockerfile.bak Dockerfile

debug:
	docker run -it -v $(REPO_WORKING_DIR)/config:/usr/share/filebeat/config -v /var/log:/log --entrypoint=sh $(DOCKER_USER)/filebeat

run:
	sed -i.bak 's|^    hosts: ["localhost:9200"]|    hosts: ["$(ELASTIC_URL)"]|' config/filebeat.yml && \
	docker run -d --name filebeat -v $(REPO_WORKING_DIR)/config:/usr/share/filebeat/config -v /var/log:/log $(DOCKER_USER)/filebeat 

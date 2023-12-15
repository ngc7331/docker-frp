DOCKER_USER ?= ngc7331
DOCKER_REPO ?= frp

FRP_VERSION ?= 0.52.3

all: build push

update:
	NEW_VERSION=$(subst v,,$(shell curl -s https://api.github.com/repos/fatedier/frp/releases/latest | jq '.name')) && \
	sed -i "s/^FRP_VERSION ?= .*$$/FRP_VERSION ?= $$NEW_VERSION/" Makefile && \
	sed -i "s/^ARG FRP_VERSION=.*$$/ARG FRP_VERSION=$$NEW_VERSION/" frpc/Dockerfile && \
	sed -i "s/^ARG FRP_VERSION=.*$$/ARG FRP_VERSION=$$NEW_VERSION/" frps/Dockerfile

TARGETS := s c
ifeq ($(filter $(TARGETS), $(TARGET)), )
$(error "TARGET must be 'c' or 's'")
endif

build:
	cd $(DOCKER_REPO)$(TARGET) && \
	docker build -t $(DOCKER_USER)/$(DOCKER_REPO)$(TARGET):latest . && \
	docker tag $(DOCKER_USER)/$(DOCKER_REPO)$(TARGET):latest $(DOCKER_USER)/$(DOCKER_REPO)$(TARGET):$(FRP_VERSION)

push:
	docker push $(DOCKER_USER)/$(DOCKER_REPO)$(TARGET):latest
	docker push $(DOCKER_USER)/$(DOCKER_REPO)$(TARGET):$(FRP_VERSION)

.PHONY: build clean

export BUILD_DIR ?= bin

-include .env

build: bin/lambda-resource-linux-amd64
	ln -s lambda-resource-linux-amd64 bin/in || true
	ln -s lambda-resource-linux-amd64 bin/out || true
	ln -s lambda-resource-linux-amd64 bin/check || true


bin/lambda-resource-linux-amd64:
	$(GOPATH/bin/)dep ensure
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o bin/lambda-resource-linux-amd64

image: clean build
	docker build -t dil001/lambda-resource:latest .

clean:
	rm bin/* || true
	rm -rf vendor || true

pipeline:
	@echo $(TEST)

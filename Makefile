.PHONY: all default install test build release clean
MAJORVERSION := 5
MINORVERSION := $(shell git rev-list --count master)
VERSION := ${MAJORVERSION}.${MINORVERSION}
LDFLAGSi = -ldflags '-s -w -X main.version=${VERSION}'
GOFILES := $(shell ls *.go | grep -v /vendor/)
ARCH = $(shell uname -m)
PKGNAME = yay
PACKAGE = ${PKGNAME}_${VERSION}_${ARCH}

default: build

all: clean build release package

install:
	go install -v ${LDFLAGS} ${GO_FILES}
test:
	gofmt -l *.go
	@test -z "$$(gofmt -l *.go)" || (echo "Files need to be linted" && false)

	go vet -v
	go test -v
build:
	go build -v ${LDFLAGS} -o ${PKGNAME}
release:
	mkdir ${PACKAGE}
	cp ./${PKGNAME} ${PACKAGE}/
	cp ./doc/yay.8 ${PACKAGE}/
	cp ./completions/zsh ${PACKAGE}/
	cp ./completions/fish ${PACKAGE}/
	cp ./completions/bash ${PACKAGE}/
package:
	tar -czvf ${PACKAGE}.tar.gz ${PACKAGE}
clean:
	-rm -rf ${PKGNAME}_*
	-rm -rf ${PKGNAME}


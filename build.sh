#!/bin/bash

set -e

PROJECT_NAME="app-api"
BINARY="app-api"

OUTPUT_DIR=output
GOOS=$(go env GOOS)

APP_NAME=${PROJECT_NAME}
APP_VERSION=$(git log -1 --oneline)
BUILD_VERSION=$(git log -1 --oneline)
BUILD_TIME=$(date "+%FT%T%z")
GIT_REVISION=$(git rev-parse --short HEAD)
GIT_BRANCH=$(git name-rev --name-only HEAD)
GO_VERSION=$(go version)

# 本质上是用 -ldflags 参数注入了的外部参数到 go 的变量当中
CGO_ENABLED=0 go build \
-ldflags "-X 'main.AppName=${APP_NAME}' \
            -X 'main.AppVersion=${APP_VERSION}' \
            -X 'main.BuildVersion=${BUILD_VERSION}' \
            -X 'main.BuildTime=${BUILD_TIME}' \
            -X 'main.GitRevision=${GIT_REVISION}' \
            -X 'main.GitBranch=${GIT_BRANCH}' \
            -X 'main.GoVersion=${GO_VERSION}'" \
main.go

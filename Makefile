.PHONY: all buildpack buildpack-10 runtime runtime-10 runtime-10-cjk
all: buildpack buildpack-10 runtime runtime-10 runtime-10-cjk

buildpack:
	./build.sh buildpack buildpack node-8

buildpack-10:
	./build.sh buildpack-10 buildpack node-10

runtime:
	./build.sh runtime runtime node-8

runtime-10:
	./build.sh runtime-10 runtime node-10

runtime-10-cjk:
	./build.sh runtime-10 runtime node-10 Dockerfile-cjk

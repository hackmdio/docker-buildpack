.PHONY: all buildpack buildpack-10 runtime runtime-10 runtime-10-cjk
all: buildpack buildpack-10 runtime runtime-10 runtime-10-cjk

buildpack:
	./build.sh buildpack buildpack 8

buildpack-10:
	./build.sh buildpack-10 buildpack 8

runtime:
	./build.sh runtime runtime 8

runtime-10:
	./build.sh runtime-10 runtime 10

runtime-10-cjk:
	./build.sh runtime-10 runtime 10 Dockerfile-cjk

## How to build docker image for multi-arch

### Using Docker Buildx (Cross-platform emulation)

```bash
./build-multi-arch.sh runtime-16 runtime 16.20.2
./build-multi-arch.sh runtime-18.15 runtime 18.15.0
./build-multi-arch.sh buildpack-18.15 buildpack 18.15.0
```

### Using GitHub Actions Workflow

Use the "Build Multi-Arch Docker Images (Native Runners)" workflow in GitHub Actions with workflow_dispatch trigger. This uses a digest-based approach for robust multi-arch builds.

Example parameters:
- `docker_dir`: `runtime-18.15`
- `image_name`: `runtime`
- `tag_prefix`: `18.15.0`
- `dockerfile`: `Dockerfile` (optional)

**Prerequisites**: Set up `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets in your GitHub repository.

### Manual Native Build Process

```bash
# Build for each platform natively
./build-native.sh runtime-18.15 runtime 18.15.0 linux/amd64
./build-native.sh runtime-18.15 runtime 18.15.0 linux/arm64

# Create multi-arch manifest
./create-manifest.sh runtime 18.15.0
```

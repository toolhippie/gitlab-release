FROM ghcr.io/dockhippie/alpine:3.23@sha256:ecf1af2fb0a1dd8a7c5db631a254ac3b77fcb53c51b18ab7bc8548699afad289
ENTRYPOINT [""]

# renovate: datasource=gitlab-releases depName=gitlab-org/release-cli
ENV GITLAB_RELEASE_VERSION=0.24.0

ARG TARGETARCH

RUN apk update && \
  apk upgrade && \
  case "${TARGETARCH}" in \
		'amd64') \
			curl -sSLo /usr/bin/release-cli https://gitlab.com/gitlab-org/release-cli/-/releases/v${GITLAB_RELEASE_VERSION}/downloads/bin/release-cli-linux-amd64; \
			;; \
		'arm64') \
			curl -sSLo /usr/bin/release-cli https://gitlab.com/gitlab-org/release-cli/-/releases/v${GITLAB_RELEASE_VERSION}/downloads/bin/release-cli-linux-arm64; \
			;; \
		'arm') \
			curl -sSLo /usr/bin/release-cli https://gitlab.com/gitlab-org/release-cli/-/releases/v${GITLAB_RELEASE_VERSION}/downloads/bin/release-cli-linux-arm; \
			;; \
		*) echo >&2 "error: unsupported architecture '${TARGETARCH}'"; exit 1 ;; \
	esac && \
  chmod +x /usr/bin/release-cli && \
  rm -rf /var/cache/apk/*

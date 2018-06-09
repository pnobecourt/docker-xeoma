# Download base image
FROM barbak/alpine-s6:latest

# Define the ARG variables for creating docker image
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

# Labels
LABEL org.label-schema.name="Xeoma" \
      org.label-schema.description="Alpine based Xeoma Docker image" \
      org.label-schema.vendor="Paul NOBECOURT <paul.nobecourt@orange.fr>" \
      org.label-schema.url="https://github.com/pnobecourt/" \
      org.label-schema.version=$VERSION \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/pnobecourt/docker-xeoma" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0"

# Define the ENV variable for creating docker image
ENV XEOMA_VOL=/srv/apps/xeoma \
LATEST_VERSIONS_URL=http://felenasoft.com/xeoma/en/download/ \
VERSION_DOWNLOAD_URL='http://felenasoft.com/xeoma/downloads/xeoma_previous_versions/?get=xeoma_linux64_$VERSION.tgz' \
LATEST_STABLE_DOWNLOAD_URL='http://felenasoft.com/xeoma/downloads/xeoma_linux64.tgz' \
LATEST_BETA_DOWNLOAD_URL='http://felenasoft.com/xeoma/downloads/xeoma_beta_linux64.tgz' \
DOWNLOAD_LOCATION=/config/downloads \
DEFAULT_CONFIG_FILE=/files/xeoma.conf.default \
CONFIG_FILE=/config/xeoma.conf \
FIXED_CONFIG_FILE=/tmp/xeoma.conf \
INSTALL_LOCATION=/files/xeoma \
LAST_INSTALLED_BREADCRUMB=$INSTALL_LOCATION/last_installed_version.txt \
CONFIG_FILE=/config/xeoma.conf \
MAC_FILE=/config/macs.txt

# Install Xeoma
RUN apk update && \
    apk add --no-cache curl

# Add files
ADD /root /

# Define Workdir
WORKDIR $XEOMA_VOL

# Define Volumes
VOLUME [ "/config", "/archive" ]

# Ports configuration
EXPOSE 8090

# Entrypoint
ENTRYPOINT [ "/init" ]

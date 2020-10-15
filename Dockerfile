# docker build --rm -f Dockerfile -t netzon-docker-phusion-dotnet-core:latest .
# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.10.1

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install all other apps
RUN AZ_REPO=$(lsb_release -cs) \
    && echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get -y update \
    && apt-get -y install nodejs \
    && apt-get -y install ansible \
    && npm install -g @angular/cli@8.3.23 \
    && npm install -g ionic@5.4.16 cordova@9.0.0 \
    && npm install -g puppeteer

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM jenkins/inbound-agent:latest

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG AGENT_HOME=/var/agent_home
ARG CCACHE_SIZE=50G
ARG REPO_BRANCH=lineage-16.0
ARG REPO_SYNC_THREADS=2
ARG REPO_URL=https://github.com/LineageOS/android.git

ENV AGENT_HOME $AGENT_HOME
ENV CCACHE_SIZE $CCACHE_SIZE
ENV REPO_BRANCH $REPO_BRANCH
ENV REPO_SYNC_THREADS $REPO_SYNC_THREADS
ENV REPO_URL $REPO_URL

USER root

# Install ROM build dependencies
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y bc bison build-essential ccache curl flex g++-multilib \
                       gcc-multilib git gnupg gperf imagemagick \
                       lib32ncurses5-dev lib32readline-dev lib32z1-dev \
                       liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev \
                       libssl-dev libxml2 libxml2-utils lzop pngcrush rsync \
                       schedtool squashfs-tools xsltproc zip zlib1g-dev \
                       libwxgtk3.0-dev git curl rsync patch wget

# Install repo script
RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo \
  && chmod a+x /usr/local/bin/repo

# Jenkins Agent is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN mkdir -p $AGENT_HOME \
  && chown ${uid}:${gid} $AGENT_HOME

# Mirrors directory is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME $AGENT_HOME

COPY entrypoint.sh .
RUN chmod a+x ./entrypoint.sh

USER ${user}

ENTRYPOINT ["./entrypoint.sh"]

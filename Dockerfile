FROM jenkins/inbound-agent:latest

ARG user=jenkins
ARG CCACHE_SIZE=50G
ARG REPO_INIT_BRANCH=lineage-16.0
ARG REPO_INIT_URL=https://github.com/LineageOS/android.git
ARG REPO_SYNC_THREADS=2
ARG REPO_USER_EMAIL=jenkins@rom.kitchen
ARG REPO_USER_NAME=Jenkins

ENV CCACHE_SIZE $CCACHE_SIZE
ENV REPO_INIT_BRANCH $REPO_INIT_BRANCH
ENV REPO_INIT_URL $REPO_INIT_URL
ENV REPO_SYNC_THREADS $REPO_SYNC_THREADS
ENV REPO_USER_EMAIL $REPO_USER_EMAIL
ENV REPO_USER_NAME $REPO_USER_NAME

USER root

# Install ROM build dependencies
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y aapt bc bison brotli build-essential ccache curl \
                       diffstat flex g++-multilib gcc-multilib git gnupg gperf \
                       imagemagick lib32ncurses5-dev lib32readline-dev \
                       lib32z1-dev liblz4-tool libncurses5 libncurses5-dev \
                       libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 \
                       libxml2-utils lzop p7zip-full patch pcregrep pngcrush \
                       python python-protobuf rsync schedtool splitpatch \
                       squashfs-tools unzip wget xsltproc zip zlib1g-dev

# Install repo script
RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo \
  && chmod a+x /usr/local/bin/repo

COPY entrypoint.sh .
RUN chmod a+x ./entrypoint.sh

USER ${user}

ENTRYPOINT ["./entrypoint.sh"]

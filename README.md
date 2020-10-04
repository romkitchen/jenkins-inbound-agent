# Docker image for inbound Jenkins romkitchen agents

This is an image for [Jenkins](https://jenkins.io) [romkitchen](https://rom.kitchen) agents using TCP or WebSockets to establish inbound connection to the Jenkins master.

See [Jenkins Distributed builds](https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds) for more info.

## Requirements

* [Docker](https://www.docker.com)
* At least 6 GB RAM
* At least 150 GB free disk space

## Usage

To run a Jenkins romkitchen agent you first need to ask for the `<URL>`, `<secret>` and `<name>` on our [Discord server](https://discord.gg/SU2twV). The first start will take several hours (depending on your internet connection speed) as it's mirroring Android ROMs. So grab a beer and put your feet up.

Create a file `.env` for environment variables (see the list below if you want to set some optional environment variables):
```
JENKINS_URL=...
JENKINS_AGENT_SECRET=...
JENKINS_AGENT_NAME=...
JENKINS_AGENT_WORKDIR=/home/jenkins/agent
```

Run the agent as a container:
```
docker run -dit \
           --init \
           --env-file .env
           --name romkitchen_agent_lineage-16.0 \
           -v agent_workdir_lineage-16.0:/home/jenkins/agent \
           romkitchen/jenkins-inbound-agent:latest
```

Optional environment variables:

* `CCACHE_SIZE`: `50G` Maximum amount of disk space ccache can use to speed up subsequent builds
* `REPO_INIT_BRANCH`: `lineage-16.0` Repository branch
* `REPO_INIT_URL`: `https://github.com/LineageOS/android.git` Repository URL
* `REPO_SYNC_THREADS`: `2` Split the sync across threads for faster completion. Make sure not to overwhelm your machine by leaving some CPU reserved for other tasks. To see the number of available CPUs, first run: `nproc --all`
* `REPO_USER_EMAIL`: `jenkins@rom.kitchen` Git config `user.email`
* `REPO_USER_NAME`: `Jenkins` Git config `user.name`

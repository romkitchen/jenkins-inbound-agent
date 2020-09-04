# Docker image for inbound Jenkins romkitchen agents

This is an image for [Jenkins](https://jenkins.io) [romkitchen](https://rom.kitchen) agents using TCP or WebSockets to establish inbound connection to the Jenkins master.

See [Jenkins Distributed builds](https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds) for more info.

## Requirements

* [Docker](https://www.docker.com)
* At least 6 GB RAM
* At least 250 GB free disk space

## Running

To run a Jenkins romkitchen agent you first need to ask for the `<URL>`, `<secret>` and `<name>` on our [Discord server](https://discord.gg/SU2twV). The first start will take several hours (depending on your internet connection speed) as it's mirroring Android ROMs. So grab a beer and put your feet up.

```
docker run -dit \
           --init \
           --name romkitchen-agent-lineageos16.0 \
           -v lineageos16.0:/var/agent_home \
           romkitchen/jenkins-inbound-agent:latest \
           -url <URL> \
           -workDir=/home/jenkins/agent \
           <secret> \
           <name>
```

Optional environment variables:

* `AGENT_HOME`: `/var/agent_home` Agent home directory
* `CCACHE_SIZE`: `50G` Maximum amount of disk space ccache can use to speed up subsequent builds
* `REPO_INIT_BRANCH`: `lineage-16.0` Repository branch
* `REPO_INIT_URL`: `https://github.com/LineageOS/android.git` Repository URL
* `REPO_SYNC_THREADS`: `2` Split the sync across threads for faster completion. Make sure not to overwhelm your machine by leaving some CPU reserved for other tasks. To see the number of available CPUs, first run: `nproc --all`

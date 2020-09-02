# Docker image for inbound Jenkins romkitchen agents

This is an image for [Jenkins](https://jenkins.io) [romkitchen](https://romkitchen.io) agents using TCP or WebSockets to establish inbound connection to the Jenkins master.

See [Jenkins Distributed builds](https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds) for more info.

## Requirements

* [Docker](https://www.docker.com)
* At least 8 GB RAM
* At least 365 GB free disk space

## Running

To run a Jenkins romkitchen agent you first need to ask for the `<URL>`, `<secret>` and `<name>` on our Discord server. The first start will take several hours (depending on your internet connection speed) as it's mirroring Android ROMs. So grab a beer and put your feet up.

```
docker run -dit \
           --init \
           --name romkitchen-agent-lineageos16.0 \
           -v lineageos16.0:/var/agent_home \
           romkitchen/jenkins-inbound-agent:latest \
           -url <URL> \
           -workDir=/home/jenkins/agent \
           <secret> \
           <name> | docker logs --follow
```

Optional environment variables:

* `AGENT_HOME`: `/var/agent_home` Agent home directory
* `REPO_BRANCH`: `lineage-16.0` Repository branch
* `REPO_SYNC_THREADS`: `2` Split the sync across threads for faster completion. Make sure not to overwhelm your machine by leaving some CPU reserved for other tasks. To see the number of available CPUs, first run: `nproc --all`
* `REPO_URL`: `https://github.com/LineageOS/android.git` Repository URL

[//]: # (docker build --tag romkitchen/jenkins-inbound-agent:1.0 .)
[//]: # (docker run -dit --init --name romkitchen-agent-lineageos16.0 -v lineageos16.0:/var/jenkins_home -e REPO_SYNC_THREADS=8 romkitchen/jenkins-inbound-agent:1.0 -url http://172.17.0.2:8080 -workDir=/home/jenkins/agent 5911c56eb54c698ba4d85179dff26afc51dce0e9d5455eeab7a259568d0c971c agent1)

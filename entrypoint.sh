#!/bin/sh

# Initialize Repository
if find -- $AGENT_HOME -prune -type d -empty | grep -q .; then
	cd $AGENT_HOME
	repo init -u $REPO_URL -b $REPO_BRANCH --depth=1
	repo sync -c -j$REPO_SYNC_THREADS
fi

# Run Jenkins Agent
jenkins-agent $@

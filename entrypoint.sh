#!/bin/sh

# Set git identity
git config --global user.email "$REPO_USER_EMAIL"
git config --global user.name "$REPO_USER_NAME"

# Make repo init stop asking for colors
git config --global color.ui false

# Initialize Repository
mkdir -p "$AGENT_WORKDIR/workspace"
if find -- "$AGENT_WORKDIR/workspace" -prune -type d -empty | grep -q .; then
	cd "$AGENT_WORKDIR/workspace"
	repo init -u "$REPO_INIT_URL" -b "$REPO_INIT_BRANCH" --depth=1
	repo sync -c -j$REPO_SYNC_THREADS
fi

# Create local manifest for proprietary blobs
mkdir -p "$AGENT_WORKDIR/workspace/.repo/local_manifests"
if ! -e "$AGENT_WORKDIR/workspace/.repo/local_manifests/romkitchen.xml"; then
	tee "$AGENT_WORKDIR/workspace/.repo/local_manifests/romkitchen.xml" << '<?xml version="1.0" encoding="UTF-8"?><manifest/>'
fi

# Run Jenkins Agent
jenkins-agent $@

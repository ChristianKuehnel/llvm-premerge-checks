#!/bin/bash
# Copyright 2020 Google LLC
#
# Licensed under the the Apache License v2.0 with LLVM Exceptions (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://llvm.org/LICENSE.txt
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Buildkite installation creates 'buildkite-agent' user.
USER=buildkite-agent
SSD_ROOT="/mnt/disks/ssd0"
AGENT_ROOT="${SSD_ROOT}/agent"
CCACHE_PATH="${SSD_ROOT}/ccache"

# prepare root folder for Jenkins agent
mkdir -p "${AGENT_ROOT}"
chown -R ${USER}:${USER} "${AGENT_ROOT}"
# TODO: this is needed if we want to use SSH auth.
#mkdir -p /var/lib/buildkite-agent/.ssh
#cp /mnt/ssh/id_rsa /var/lib/buildkite-agent/.ssh
#cp /mnt/ssh/id_rsa.pub /var/lib/buildkite-agent/.ssh
#chown -R ${USER}:${USER} /var/lib/buildkite-agent/.ssh

# prepare folder for ccache
mkdir -p "${CCACHE_PATH}"
chown -R ${USER}:${USER} "${CCACHE_PATH}"

# TODO(kuhnel): wipe the disk(s) on startup

# start the buildkite agent
su buildkite-agent -c "buildkite-agent start --build-path=/mnt/disks/ssd0/agent"
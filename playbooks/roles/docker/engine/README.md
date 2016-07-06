# Ansible Docker Role

[![Circle CI](https://circleci.com/gh/playlist-ansible/docker.svg?style=shield)](https://circleci.com/gh/playlist-ansible/docker)
[![Galaxy](https://img.shields.io/badge/galaxy-playlist.docker-blue.svg)](https://galaxy.ansible.com/list#/roles/3245)

Manages installations of Docker.

## Requirements and Dependencies

None.

## Installation

Using `ansible-galaxy`:

```
$ ansible-galaxy install playlist.docker
```

## Role Variables

```yaml
# lxc-docker is the default
docker_pkg_name: lxc-docker
# docker_pgk_name: docker.io
# Change these to 'present' if you're running Ubuntu 12.04-13.10 and are fine with less-than-latest packages
kernel_pkg_state: latest
cgroup_lite_pkg_state: latest
# Important if running Ubuntu 12.04-13.10 and ssh on a non-standard port
ssh_port: 22
# Place to get apt repository key
apt_key_url: http://get.docker.io/gpg
# apt repository key signature
apt_key_sig: A88D21E9
# Name of the apt repository for docker
apt_repository: deb http://get.docker.io/ubuntu docker main

# The following help expose a docker port or to add additional options when
# running docker daemon.  The default is to not use any special options.
#docker_opts: >
#  -H unix://
#  -H tcp://0.0.0.0:2375
#  --log-level=debug
docker_opts: ""

#docker_version: 1.5.0
```

## Example Playbook

```yaml
- hosts: servers
  roles:
    - playlist.docker
```

## Testing

```
$ git clone https://github.com/playlist-ansible/docker.git
$ cd docker
$ make
```

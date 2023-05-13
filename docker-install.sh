#!/bin/bash

# This script installs docker and activates it. If you run this script as a noon root user it will set up Docker for you as a non root user.

me=$(whoami)

IS_DOCKER_INSTALLED=0
check_if_docker_installed () {
  docker ps > /dev/null 2>&1
  return_code=$?
  if [ $return_code -eq 0 ]
  then
    echo Docker is already installed on your machine
    IS_DOCKER_INSTALLED=1
  fi
}


install_docker () {
  # Install docker
  curl -sSL https://get.docker.com | sh
  install_rc=$?
  if [ $install_rc -ne 0 ];
  then
    echo Could not install docker properly from official script!
    exit $install_rc
  fi

  # start docker service
  sudo systemctl start docker

  if [[ "$me" == 'root' ]];
  then
    echo Installed docker as a root user
    return
  fi

  # Run docker as non-root user
  sudo usermod -aG docker $me


  # Check if docker works for a non root user
  docker ps > /dev/null 2>&1
  return_code=$?
  if [ $return_code -ne 0 ];
  then
    # execute in another shell
    sudo su $me -c 'docker ps > /dev/null 2>&1'
    return_code=$?
    if [ $return_code -eq 0 ];
    then
      echo Successfully installed docker as a non rot user
    else
      echo Failed installing docker or setting up it as a noon root user!
      exit $return_code
    fi
  fi
}


check_if_docker_installed

if [ $IS_DOCKER_INSTALLED -ne 1 ]; then
  install_docker
fi

#!/bin/bash

PROVIDER_BASE_URL=https://github.com/smehboub/terraform-provider-ultradns/releases/download
PROVIDERS_FOLDER=terraform.d/plugins
PROVIDER_FILE=terraform-provider-ultradns
PROVIDER_VERSION=v0.1.1
PREFIX_FOLDER=~/

unameMachine="$(uname -s)"
unameArch="$(uname -m)"
case "${unameMachine}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=darwin;;
    CYGWIN*)    machine=windows;;
    MINGW*)     machine=windows;;
    *)          machine="UNKNOWN:${unameMachine}"
esac

case "${unameArch}" in
    x86_64*)     arch=amd64;;
    *)           arch="UNKNOWN:${unameArch}"
esac

if [[ "${machine}" = "linux" && "${arch}" = "amd64" ]] ; then
    PREFIX_FOLDER=~/.
elif [[ "${machine}" = "darwin" && "${arch}" = "amd64" ]] ; then
    PREFIX_FOLDER=~/.
elif [[ "${machine}" = "windows" && "${arch}" = "amd64" ]] ; then
    PREFIX_FOLDER=$APPDATA/
else
    echo "Ooops ... Your operating system isn't supported... Sorry for you !"
    exit 1
fi

FOLDER=${PREFIX_FOLDER}${PROVIDERS_FOLDER}/${machine}_${arch}
FILE=${FOLDER}/${PROVIDER_FILE}_${PROVIDER_VERSION}
URL=${PROVIDER_BASE_URL}/${PROVIDER_VERSION}/${PROVIDER_FILE}-${machine}_${arch}
mkdir -p ${FOLDER}
if ! curl --fail -L ${URL} -o ${FILE} ; then 
  echo "Ooops ... The file ${URL} doesn't exist... Sorry for you !"
  exit 1
fi
chmod 755 ${FILE}

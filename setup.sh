#!/bin/bash

source ./init.sh

rm -R ${NSC_HOME}/nats/
rm -R ${NSC_HOME}/nkeys/
nsc init -n main
./gen-accounts.sh
nsc generate config --mem-resolver > ./resolver.conf

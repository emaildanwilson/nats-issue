#!/bin/bash

source ./init.sh

nsc add operator op

nsc add account main

nsc add export --account main --subject "city.>"

nsc add user --account main --name publisher --allow-pub 'city.>'

# for debug only
nsc add user --account main --name debug --allow-sub '>'

for a in $(seq $MAX_ACCOUNTS); do
    nsc add account secondary-$a

    nsc add export --account "${account}" --subject "internal.*" || true
    nsc add import --account main --src-account secondary-$a --remote-subject "internal.${MAX_ACCOUNTS}" || true
        
    nsc add user --account secondary-$a --name subscriber \
        --allow-sub "city.>" \
        --allow-pubsub "internal.*"
    nsc add import --account secondary-$a --src-account main --remote-subject "city.$a-1.*"

    # for debug only
    nsc add user --account secondary-$a --name debug --allow-sub '>'
done

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

    # comment this out to use the workaround
    nsc add export --account "secondary-$a" --subject "internal.*" || true
    nsc add import --account main --src-account secondary-$a --remote-subject "internal.${a}" || true

    # workaround; still testing
    # nsc add export --account "secondary-$a" --subject "internal.*" --service || true
    # nsc add import --account "secondary-$a" --src-account main --remote-subject "internal.${a}" --service || true
        
    nsc add user --account secondary-$a --name subscriber \
        --allow-sub "city.>" \
        --allow-pubsub "internal.*"
    nsc add import --account secondary-$a --src-account main --remote-subject "city.$a-1.*"

    # for debug only
    nsc add user --account secondary-$a --name debug --allow-sub '>'
done

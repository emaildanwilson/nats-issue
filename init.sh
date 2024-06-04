# this directory
export NSC_HOME="$(dirname $(realpath "${BASH_SOURCE[0]}"))"
export NKEYS_PATH="$NSC_HOME/nkeys"
export MAX_ACCOUNTS=10


subscribe() {
    for imp in $(seq $MAX_ACCOUNTS); do
        local index="$1"
        nats --creds ./nkeys/creds/op/secondary-$imp/subscriber.creds -s nats://127.0.0.1:4222 sub "city.>" &
    done
}

unsubscribe() {
    ps -eaf | grep nats | grep sub | awk '{print "kill " $2}' | bash
}

## generate the nats accounts and configuration in this directory

The script generates 
- a main account with a publisher for `city.>`
- 10 secondary-$number subscriber accounts with imports/exports configured so it can receive messages on `city.$sub-1.*` and publish messages on `internal.*`.

After running the setup script you'll have the `./nats` and `./nkeys` folders and a nats server configuration using teh memory resolver: `resolver.conf`.

```bash
./setup.sh
```

### start nats server

```bash
/nats-server -c resolver.conf -D
```


### start publisher

The publisher connects using the publisher user of the main account and publishes a message every second on the topic `city.1-1.*`

1. pip install nats-py nkeys
1. python ./publish.py

### start subscribers

The subscribe function in `init.sh` starts up 10 subscribers, one from each of the 10 accounts created.

1. source ./init.sh
1. subscribe


# reproduce the issue

Stop and start nats server until no messages appear after startup, this will take no more than 10 tries in my experience. 

Once it's in this state, stopping and restarting the publisher or subscribers has no effect.

You can subscribe using the debug user creds in the main account to see messages are still being published.

You can subscribe using teh debug user creds in the secondary-1 account to see that no messages are being received by this subaccount.

The only way to correct the issue is to restart the nats server. Once that is complete messages will start flowing again unless you happen to hit the issue again.
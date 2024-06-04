import asyncio
import time
from nats.aio.client import Client as NATS

async def publish_message():
    # Create a NATS client instance
    nc = NATS()

    # Define the path to the credentials file
    creds_file = './nkeys/creds/op/main/publisher.creds'

    # Connect to the NATS server using the credentials file
    await nc.connect("nats://127.0.0.1:4222", user_credentials=creds_file)

    # Publish a message every second
    while True:
        message = "important message!"
        await nc.publish("city.1-1.A4BDB048-69DC-4F10-916C-2B998249DC11", message.encode())
        # print(f"Published: {message}")
        await asyncio.sleep(1)

    # Close the connection
    await nc.close()

# Run the publish_message function
if __name__ == "__main__":
    try:
        asyncio.run(publish_message())
    except KeyboardInterrupt:
        print("Connection closed.")

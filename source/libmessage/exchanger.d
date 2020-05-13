module libmessage.exchanger;

import core.thread : Thread;
import libester.client : BesterClient;
import std.conv : to;
import std.json : JSONValue;
import libmessage.message : Message;

public final class Exchanger : Thread
{
    /**
    * The connection to the Bester server.
    * This is represented via an instance
    * of `BesterClient`.
    */
    private BesterClient client;

    /**
    * The `autoID` queue is used to keep an ID
    * counter for each message type as to keep
    * order.
    */
    private ulong[string] idQueue;

    /**
    * The message queue (indexed via `type~idQueue`)
    */
    private Message[string] messageQueue;

    this(string address, ushort port)
    {
        client = new BesterClient(address, port);
        client.connect();
        startWatcher();
    }

    /* TODO: Implement me */
    private void startWatcher()
    {

    }

    public void sendMessage(string type, JSONValue message)
    {
        /**
        * Firstly check if the `idQueue` has a tracker
        * in place for the message type, `type`, provided.
        */
        if(!(type in idQueue))
        {
            /* If not then add it. */
            idQueue[type] = 0;
        }

        /* The queued message */
        Message messageQueued;

        /**
        * Construct the payload.
        * This consists of the `message` and the
        * `autoID` value.
        */
        JSONValue payload;
        payload["message"] = message;
        payload["id"] = to!(string)(idQueue[type]);

        /* Send the message */
        client.send(type, payload);

        /* Create the queue message */
        messageQueued = new Message();

        /* Construct the global ID */
        string globalID = type~to!(string)(idQueue[type]);

        /* Add the message to the `messageQueue` */
        messageQueue[globalID] = messageQueued;

        /* Increment the next ID */
        idQueue[type]++;
    }

    public JSONValue receiveMessage(string type)
    {

    }

}
module source.exchanger;

import core.thread : Thread;
import libester.client : BesterClient;
import std.conv : to;
import std.json : JSONValue;

public final class Exchanger : Thread
{
    /**
    * The connection to the Bester server.
    * This is represented via an instance
    * of `BesterClient`.
    */
    private BesterClient client;

    /* The current ID */
    private ulong autoID;

    this(string address, ushort port)
    {
        client = new BesterClient(address, port);
        client.connect();
    }

    public void sendMessage(string type, JSONValue message)
    {
        /* TODO: Encode message here */

        /* Get the id */
        ulong currentID = autoID;

        /**
        * Construct the payload.
        * This consists of the `message` and the
        * `autoID` value.
        */
        JSONValue payload;
        payload["message"] = message;
        payload["id"] = to!(string)(currentID);

        /* Send the message */
        client.send(type, payload);


        /* Increment the next ID */
        autoID++;
    }

}
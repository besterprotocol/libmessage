module libmessage.message;

import std.json : JSONValue;

public final class Message
{
    /**
    * If the message has been received or not.
    */
    private bool receivedStatus;

    /**
    * The associated message ID.
    */
    private ulong messageID;

    /**
    * The received message.
    */
    private JSONValue receivedMessage;

    this()
    {
        // this.messageID = messageID;
    }

    public bool hasReceived()
    {
        return receivedStatus;
    }

    public void setReceived(JSONValue receivedMessage)
    {
        this.receivedMessage =  receivedMessage;
    }

    public JSONValue getMessage()
    {
        return receivedMessage;
    }
}
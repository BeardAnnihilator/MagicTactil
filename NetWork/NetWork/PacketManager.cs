using System;
using System.Collections.Generic;

public class PacketManager
{
    public List<Packet> listSend;
    public List<Packet> listRec;

	public PacketManager()
	{
        listSend = new List<Packet>();
        listRec = new List<Packet>();
	}
}

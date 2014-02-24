using System;
using System.Collections.Generic;

public class Packet
{
    public string IP { get; set; }
    public string destination { get; set; }
    public string function { get; set; }
    public int size { get; set; }
    public Dictionary<string, string> functionparam { get; set; }

	public Packet(string ip, string dest, string func, Dictionary<string, string> functionparam)
	{
        this.IP = ip;
        this.destionation = dest;
        this.function = func;
        this.functionparam = functionparam;
	}
}

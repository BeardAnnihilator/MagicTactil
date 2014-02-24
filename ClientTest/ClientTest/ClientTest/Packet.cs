using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

public struct HeadPacket
{
    public int destination;
    public int source;
    public int size;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 5)]
    public string function;
}

public struct Packet
{
    public HeadPacket headpacket;
    //public Dictionary<string, string> functionparam { get; set; }
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 255)]
    public string data;
}

using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace MagicTactilForWindows.Model
{
    /// <summary>
    /// Describe HeadPacket and Packet (data)
    /// used for communication with server
    /// </summary>
    public struct HeadPacket
    {
        public int destination;
        public int source;
        public int size;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 5)]
        public string function;
    }

    /// <summary>
    /// Describe HeadPacket and Packet (data)
    /// used for communication with server
    /// </summary>
    public struct Packet
    {
        public HeadPacket headpacket;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 255)]
        public string data;
    }
}
using System;

namespace MagicTactilForWindows.Utilities
{

    /// <summary>
    /// Represent an event with information about navigation.
    /// </summary>
    public class MoveToEventArgs : EventArgs
    {
        public string page { get; set; }
        public string name { get; set; }
        public MoveToEventArgs(string str)
        {
            page = str;
        }
        public MoveToEventArgs(string str, string nam)
        {
            page = str;
            name = nam;
        }
    }
}

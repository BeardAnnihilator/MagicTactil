using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MagicTactilForWindows.Model
{
    class serverReturnEventArgs : EventArgs
    {
        public int srce { get; set; }
        public int dest { get; set; }
        public String func { get; set; }
        public int size { get; set; }
        public String data { get; set; }

        public serverReturnEventArgs(int _srce, int _dest, String _func, int _size, String _data)
        {
            this.srce = _srce;
            this.dest = _dest;
            this.func = _func;
            this.size = _size;
            this.data = _data;
        }
    }
}
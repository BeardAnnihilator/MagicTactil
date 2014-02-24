using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MagicTactilForWindows.Model;
using System.Windows.Input;
using MagicTactilForWindows.Utilities;

namespace MagicTactilForWindows.ViewModel
{
    class VMRoom : APage
    {
        #region attribute
        /*
         * link to the server
         */
        private Network _Server;
        private Room _roomAssociated;
        public Room roomAssociated
        {
            get { return _roomAssociated; }
            set { _roomAssociated = value; }
        }

        private String name;

        #region command
        private ICommand __leave;
        public ICommand leave
        {
            get
            {
                if (__leave == null)
                    __leave = new RelayCommand<object>(leaveRoom, null);
                return __leave;
            }
        }
        #endregion command

        #endregion attribute
        public VMRoom(Network Server)
        {
            _Server = Server;

            _Server.LEARReturn += new EventHandler<serverReturnEventArgs>(r_LEAR);
            _Server.DEROReturn += new EventHandler<serverReturnEventArgs>(r_DERO);
            _Server.GETUReturn += new EventHandler<serverReturnEventArgs>(r_GETU);
        }

        #region server_return

        void r_LEAR(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {
                MoveToEventArgs args = new MoveToEventArgs("Rooms");
                EventHandler<MoveToEventArgs> handler = this.getMoveTo();

                if (handler != null)
                    handler(this, args);
            }
        }

        void r_DERO(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {
                MoveToEventArgs args = new MoveToEventArgs("Rooms");
                EventHandler<MoveToEventArgs> handler = this.getMoveTo();

                if (handler != null)
                    handler(this, args);
            }
        }

        void r_GETU(object sender, serverReturnEventArgs e)
        {
            name = VMProfile.getval(e.data, "username");
            _Server.GETUReturn -= new EventHandler<serverReturnEventArgs>(r_GETU);
        }

        #endregion server_return


        #region event

        public void roomAssociation(object sender, RoomEventArgs e)
        {
            roomAssociated = e.associated;
        }

        private void leaveRoom(object param)
        {
            if (name.Equals(roomAssociated.nameOwner))
            {
                _Server.DeleteRoom(name, roomAssociated.nameRoom);
            }
            else
            {
                _Server.LeaveRoom(name, roomAssociated.nameRoom);
            }
        }
        #endregion event

    }
}

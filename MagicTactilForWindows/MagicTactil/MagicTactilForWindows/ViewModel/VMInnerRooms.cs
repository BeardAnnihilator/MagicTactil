using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MagicTactilForWindows.Model;
using MagicTactilForWindows.Utilities;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Windows.Data;

namespace MagicTactilForWindows.ViewModel
{

    enum InnerRoomView
    {
        ROOMS,
        CR_ROOM,
        ROOM
    };

    class VMInnerRooms : APage
    {
        #region attribute
        /*
         * link to the server
         */
        private Network _Server;
        

        #region collection of views
        /*
         * The collections of VM classes (representing Views)
         */
        private ObservableCollection<ViewModelBase> _ViewModels;
        public ObservableCollection<ViewModelBase> ViewModels
        {
            get { return _ViewModels; }
            set
            {
                _ViewModels = value;
                OnPropertyChanged("ViewModels");
            }
        }

        /*
         * These ones are used for bindings
         */
        private ICollectionView _ViewModelView;
        public ICollectionView ViewModelView
        {
            get { return _ViewModelView; }
            set
            {
                _ViewModelView = value;
                OnPropertyChanged("ViewModelView");
            }
        }
        #endregion collection of views
        #endregion attribute

        #region constructor
        public VMInnerRooms(Network Server)
        {
            _Server = Server;

            VMRooms rooms = new VMRooms(_Server);
            VMCreateRoom cr_room = new VMCreateRoom(_Server);
            VMRoom room = new VMRoom(_Server);

            rooms.moveTo += new EventHandler<MoveToEventArgs>(Inner_moveTo);
            cr_room.moveTo += new EventHandler<MoveToEventArgs>(Inner_moveTo);
            room.moveTo  += new EventHandler<MoveToEventArgs>(Inner_moveTo);

            cr_room.roomCreation += new EventHandler<RoomEventArgs>(room.roomAssociation);
            rooms.roomJoin += new EventHandler<RoomEventArgs>(room.roomAssociation);

            ViewModels = new ObservableCollection<ViewModelBase>()
            {
                rooms,
                cr_room,
                room
            };

            
            ViewModelView = CollectionViewSource.GetDefaultView(ViewModels);
        }
        #endregion constructor

        #region event handler
        private void Inner_moveTo(object sender, MoveToEventArgs e)
        {
            this.move_To(e.page);
        }
        #endregion event handler

        #region navigation
        /*
         * this function change the value of ViewModelView.current
         * so the screen change.
         */
        private void move_To(string page)
        {
             if (ViewModelView != null)
             {
                 switch (page)
                 {
                     case "Rooms":
                         ((VMRooms)ViewModels.ElementAt((int)InnerRoomView.ROOMS)).refreshRoomList(null);
                         ViewModelView.MoveCurrentToPosition((int)InnerRoomView.ROOMS);
                         break;
                     case "CreateRoom":
                         ViewModelView.MoveCurrentToPosition((int)InnerRoomView.CR_ROOM);
                         break;
                     case "Room":
                         ViewModelView.MoveCurrentToPosition((int)InnerRoomView.ROOM);
                         break;
                 }
             }
        }

        public void refreshRoomList()
        {
            if (ViewModelView.CurrentPosition == (int)InnerRoomView.ROOMS)
                ((VMRooms)ViewModels.ElementAt((int)InnerRoomView.ROOMS)).refreshRoomList(null);
        }

        #endregion navigation
    }
}

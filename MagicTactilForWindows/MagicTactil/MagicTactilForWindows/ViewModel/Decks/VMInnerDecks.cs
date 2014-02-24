using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Windows.Data;
using MagicTactilForWindows.Model;
using MagicTactilForWindows.Utilities;

namespace MagicTactilForWindows.ViewModel
{
    enum InnerDecksView
    {
        DECKS,
        BUILDING,
    };


    public class VMInnerDecks : APage
    {
        #region attribute
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

        /// <summary>
        /// constructor takes server in arguments
        /// </summary>
        /// <param name="Server"></param>
        public VMInnerDecks(Network Server)
        {
            _Server = Server;
            VMDecks decks = new VMDecks(Server);
            decks.moveTo += new EventHandler<MoveToEventArgs>(Inner_moveTo);
            VMBuilding building = new VMBuilding(Server);
            building.moveTo += new EventHandler<MoveToEventArgs>(Inner_moveTo);

            ViewModels = new ObservableCollection<ViewModelBase>()
            {
                decks,
                building
            };
            ViewModelView = CollectionViewSource.GetDefaultView(ViewModels);
        }

        /// <summary>
        /// general fonction to move
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Inner_moveTo(object sender, MoveToEventArgs e)
        {
            if (e.page.Equals("BuildingNew"))
            {
                ((VMBuilding)ViewModels.ElementAt((int)InnerDecksView.BUILDING)).Clear();
                e.page = "Building";
            }
            this.move_To(e.page);
        }
        /// <summary>
        /// this function change the value of ViewModelView.current
        /// so the screen change.
        /// </summary>
        /// <param name="page"></param>
        private void move_To(string page)
        {
            if (ViewModelView != null)
            {
                switch (page)
                {
                    case "Decks":
                        ((VMDecks)ViewModels.ElementAt((int)InnerDecksView.DECKS)).refreshDeckList(); //TODO : something cleaner for the same thing
                        ViewModelView.MoveCurrentToPosition((int)InnerDecksView.DECKS);
                        break;
                    case "Building":
                        ViewModelView.MoveCurrentToPosition((int)InnerDecksView.BUILDING);
                        break;
                }
            }
        }

        /// <summary>
        /// refresh deck list
        /// </summary>
        public void refreshDeckList()
        {
            ((VMDecks)ViewModels.ElementAt((int)InnerDecksView.DECKS)).refreshDeckList();
        }
        public override void refresh_label() { }
    }
}

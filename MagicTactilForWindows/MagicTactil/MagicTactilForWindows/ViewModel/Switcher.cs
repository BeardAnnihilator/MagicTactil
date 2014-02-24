using System.ComponentModel;
using System.Collections.ObjectModel;
using System.Windows.Data;
using MagicTactilForWindows.Utilities;
using System;
using MagicTactilForWindows.Model;
using System.Net.Sockets;
using System.Configuration;
using System.Xml;


namespace MagicTactilForWindows.ViewModel
{
    enum View
    {
        LOGIN,
        INNERBOARD
    };

    public class Switcher : ViewModelBase
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
        /*
         * Creating the collection of view, and linking the source 
         * of the binded collection to it
         */ 
        public Switcher()
        {
            string message = "";
            try {this._Server = new Network();
            this._Server.connect(ConfigurationManager.AppSettings["ip"], 3000);  //127.0.0.1
            }
            catch (Exception) 
            {
                message = "Unable to connect to the server";
            }

            /*
             * The root element contains, a VMLogIn and a VMInnerBoard.
             */
            Initialize(message);
        }

        void Initialize(String message)
        {
            VMLogIn login = new VMLogIn(_Server);
            login.message = message;
            VMInnerBoard innerBoard = new VMInnerBoard(_Server);

            login.moveTo += new EventHandler<MoveToEventArgs>(Switcher_moveTo);
            innerBoard.moveTo += new EventHandler<MoveToEventArgs>(Switcher_moveTo);

            ViewModels = new ObservableCollection<ViewModelBase>()
            {
                login,
                innerBoard
            };
            ViewModelView = CollectionViewSource.GetDefaultView(ViewModels);
        }

        #endregion constructor

        #region event handler
        /*
         * event for navigation 
         */
        private void Switcher_moveTo(object sender, MoveToEventArgs e)
        {
            this.moveTo(e.page);
        }
        #endregion event handler

        #region navigation
        /*
         * this function change the value of ViewModelView.current
         * so the screen change.
         */
        private void moveTo(string page)
        {
            if (ViewModelView != null)
            {
                switch (page)
                {
                    case "logIn":
                        ViewModelView.MoveCurrentToPosition((int)View.LOGIN);
                        disconect();
                        Initialize("");
                        break;
                    case "InnerBoard":
                        _Server.GetInfoUser(((VMLogIn)ViewModels[(int)View.LOGIN]).name); // TODO: something cleaner
                        _Server.GetListEvent();
                        ViewModelView.MoveCurrentToPosition((int)View.INNERBOARD);
                        break;
                }
            }
        }
        #endregion navigation

        public void savePreferencies()
        {
            XmlDocument doc = new XmlDocument();
            doc.Load("MagicTactilForWindows.exe.config");
            XmlNodeList l = doc.GetElementsByTagName("add");
            
                var valueAttribute = l.Item(0).Attributes["value"];
                if (!ReferenceEquals(null, valueAttribute))
                {
                    valueAttribute.Value = _Server.Ip;
                }
            
            doc.Save("MagicTactilForWindows.exe.config");
        }
        public void disconect()
        {
            if (_Server.isConnected) _Server.SignOut(((VMLogIn)ViewModels[(int)View.LOGIN]).name, ((VMLogIn)ViewModels[(int)View.LOGIN]).password);
        }
    }
}

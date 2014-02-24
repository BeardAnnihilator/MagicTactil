using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.ObjectModel;
using MagicTactilForWindows.Model;
using System.Windows;
using System.Windows.Media;

namespace MagicTactilForWindows.ViewModel
{
    /// <summary>
    /// view model for conversation
    /// </summary>
    public class Conversation : ViewModelBase
    {
        public String name;
        private String _dest;
        public String dest { get { return _dest; } }
        private Room _roomdest;
        public Room roomdest { get { return _roomdest; } }

        private Boolean isPrivate;

        private String _content;
        public String content { get { return _content; } set { _content = value; OnPropertyChanged("content"); } }
        
        
        private Visibility _visib = new Visibility();
        public Visibility visib { get { return _visib; } set { _visib = value; OnPropertyChanged("visib"); OnPropertyChanged("color"); } }

        public SolidColorBrush color { get { if (visib == Visibility.Visible) return Brushes.Aquamarine; else return Brushes.CornflowerBlue; } }

        public event EventHandler<EventArgs> delete;
        public event EventHandler<EventArgs> focus;

        private Network _Server;

        /// <summary>
        /// constructor with server in argument
        /// </summary>
        /// <param name="server"></param>
        /// <param name="name"></param>
        /// <param name="room"></param>
        public Conversation(Network server, String name, Room room)
        {
            this.name = name;
            isPrivate = false;
            visib = Visibility.Visible;
            _Server = server;
            this._roomdest = room;
            this.content = "";
            _Server.MESBReturn += new EventHandler<serverReturnEventArgs>(r_MESB);
        }
        /// <summary>
        /// constructor with server in argument
        /// </summary>
        /// <param name="server"></param>
        /// <param name="name"></param>
        /// <param name="dest"></param>
        public Conversation(Network server, String name, String dest)
        {
            this.name = name;
            isPrivate = true;
            visib = Visibility.Collapsed;
            _Server = server;
            this._dest = dest;
            this.content = "";
        }
        /// <summary>
        /// constructor with server in argument
        /// </summary>
        /// <param name="server"></param>
        /// <param name="name"></param>
        /// <param name="dest"></param>
        /// <param name="content"></param>
        public Conversation(Network server, String name, String dest, String content)
        {
            this.name = name;
            isPrivate = true;
            visib = Visibility.Collapsed;
            _Server = server;
            this._dest = dest;
            this.content = "";
            addContent(content);
        }
        /// <summary>
        /// add message to conversatino stream
        /// </summary>
        /// <param name="content"></param>
        public void addContent(String content)
        {
            this.content = this.content += content + '\n';
        }
        /// <summary>
        /// send message to chatee
        /// </summary>
        /// <param name="message"></param>
        public void sendMessage(String message)
        {
            message = this.name + " : " + message;
            if (isPrivate)
                _Server.PrivateMessage(dest, message);
            else
                _Server.BroadcastMessage(roomdest.nameRoom, message);
            addContent(message);
        }

        public override string ToString()
        {
            return dest;
        }

        public override bool Equals(object obj)
        {
            try
            {
                Conversation other = (Conversation)obj;
                return other.dest.Equals(dest);
            }
            catch (InvalidCastException)
            {
                return false;
            }
            
        }

        public void deleteMe()
        {
            if (delete != null)
            {
                delete(this, null);
            }
        }

        public void focusMe()
        {
            if (focus != null)
            {
                focus(this, null);
            }
        }

        void r_MESB(object sender, serverReturnEventArgs e)
        {
            if (e.data.Equals("OK") || e.data.Equals("KO"))
            {
            }
            else
            {
                addContent(e.data);
            }
        }

    }


    public class VMConversationManager : APage
    {
        private string name;
        private Network _Server;

        private ObservableCollection<Conversation> _Conversations;
        public ObservableCollection<Conversation> Conversations { get { return _Conversations; } set { _Conversations = value;
            OnPropertyChanged("Conversations"); } }

        private Conversation _focus;
        public Conversation focus { get { return _focus; } set { _focus = value; OnPropertyChanged("focus"); OnPropertyChanged("privateChatVisi"); } }


        public void setFocus(Conversation convers)
        {
            focus = convers;
        }

        public void setName(String name)
        {
            this.name = name;
        }

        /// <summary>
        /// constructor with server as arg
        /// </summary>
        /// <param name="server"></param>
        public VMConversationManager(Network server)
        {
            focus = new Conversation(_Server, "tmp", "tmp");
            _Server = server;
            _Conversations = new ObservableCollection<Conversation>();
            _Server.MESPReturn +=new EventHandler<serverReturnEventArgs>(r_MESP);
        }

        void r_MESP(object sender, serverReturnEventArgs e)
        {
            if (e.data.Equals("OK") || e.data.Equals("KO"))
            {
            }
            else
            {
                Add(e.data.Substring(0, e.data.IndexOf(" ")), e.data);
            }
        }
        /// <summary>
        /// add content to the stream
        /// </summary>
        /// <param name="dest"></param>
        public void Add(String dest)
        {
            Conversation neo = new Conversation(_Server, name, dest);

            if (!Conversations.Contains(neo))
            {
            Conversations.Add(neo);
            neo.delete += new EventHandler<EventArgs>(neo_delete);
            neo.focus += new EventHandler<EventArgs>(neo_focus);
            OnPropertyChanged("Conversations");
            }
        }

        
        /// <summary>
        ///  add content to the stream and create a chat
        /// </summary>
        /// <param name="dest"></param>
        /// <param name="content"></param>
        public void Add(String dest, String content)
        {
            Application.Current.Dispatcher.Invoke(new Action(delegate()
                {
            Conversation neo = new Conversation(_Server, name, dest, content);

            if (!Conversations.Contains(neo))
            {
                
                    Conversations.Add(neo);
                
                
                neo.delete += new EventHandler<EventArgs>(neo_delete);
                neo.focus += new EventHandler<EventArgs>(neo_focus);
                OnPropertyChanged("Conversations");
            }
            else
            {
                Conversations.ElementAt(Conversations.IndexOf(neo)).addContent(content);
            }
                }), null);
        }

        /// <summary>
        /// create new conversation
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void neo_focus(object sender, EventArgs e)
        {
            Conversation obj = (Conversation)sender;
            if (focus != null && focus.Equals(obj))
            {
                focus = new Conversation(_Server, "tmp", "tmp"); 
                obj.visib = Visibility.Collapsed;
            }
            else
            {
                if (focus != null)
                focus.visib = Visibility.Collapsed;
                focus = obj;
                obj.visib = Visibility.Visible;
            }
        }

        /// <summary>
        /// delete tmp conversation
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void neo_delete(object sender, EventArgs e)
        {
            if (focus != null && focus.Equals(sender))
                focus = new Conversation(_Server, "tmp", "tmp"); 

            Conversations.Remove((Conversation)sender);

            OnPropertyChanged("Conversations");
        }

        public override void refresh_label() { }
    }
}

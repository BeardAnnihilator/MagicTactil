using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MagicTactilForWindows.Model;
using MagicTactilForWindows.Utilities;

namespace MagicTactilForWindows.ViewModel
{
    public class VMProfile : APage
    {
        #region attribute
        /// <summary>
        /// link to the server
        /// </summary>
        private Network _Server;

        /// <summary>
        /// real infos (get from server)
        /// </summary>
        #region infos
        private string _name;
        public string name { get { return _name; } set { _name = value; OnPropertyChanged("name"); } }

        private string _mail;
        public string mail
        {
            get { return _mail; }
            set
            {
                _mail = value; OnPropertyChanged("mail");
            } 
        }

        private string _firstName;
        public string firstName
        {
            get { return _firstName; }
            set
            {
                _firstName = value; OnPropertyChanged("firstName");
        
        }
        }

        private string _surName;
        public string surName
        {
            get { return _surName; }
            set
            {
                _surName = value; OnPropertyChanged("surName");
        
        }
        }

        private string _birth;
        public string birth
        {
            get { return _birth; }
            set
            {
                _birth = value; OnPropertyChanged("birth");
        
        }
        }

        private string _location;
        public string location
        {
            get { return _location; }
            set
            {
                _location = value; OnPropertyChanged("location");
       
        }
        }

        private string _phone;
        public string phone
        {
            get { return _phone; }
            set
            {
                _phone = value; OnPropertyChanged("phone");
        
        }
        }

        private string _gender;
        public string gender
        {
            get { return _gender; }
            set
            {
                _gender = value; OnPropertyChanged("gender");
        
        }
        }

        #endregion infos

        /// <summary>
        /// tmp infos used before confirmation of modification
        /// </summary>
        #region tmpinfos
        private string _tmpmail;
        public string tmpmail
        {
            get { return _tmpmail; }
            set
            {_tmpmail = value; OnPropertyChanged("tmpmail");}
        }

        private string _tmpfirstName;
        public string tmpfirstName
        {
            get { return _tmpfirstName; }
            set
            {_tmpfirstName = value; OnPropertyChanged("tmpfirstName");}
        }

        private string _tmpsurName;
        public string tmpsurName
        {
            get { return _tmpsurName; }
            set
            {_tmpsurName = value; OnPropertyChanged("tmpsurName");}
        }

        private string _tmpbirth;
        public string tmpbirth
        {
            get { return _tmpbirth; }
            set
            {_tmpbirth = value; OnPropertyChanged("tmpbirth");}
        }

        private string _tmplocation;
        public string tmplocation
        {
            get { return _tmplocation; }
            set
            {_tmplocation = value; OnPropertyChanged("tmplocation");}
        }

        private string _tmpphone;
        public string tmpphone
        {
            get { return _tmpphone; }
            set
            {_tmpphone = value; OnPropertyChanged("tmpphone");}
        }

        private string _tmpgender;
        public string tmpgender
        {
            get { return _tmpgender; }
            set
            {_tmpgender = value; OnPropertyChanged("tmpgender");}
        }

        



        #endregion tmpinfos

        #endregion attribute

        #region constructor

        public VMProfile(Network Server)
        {
           _Server = Server;
           Server.GETUReturn += new EventHandler<serverReturnEventArgs>(r_GETU);
           Server.SETUReturn += new EventHandler<serverReturnEventArgs>(r_SETU);
        }

        #endregion constructor

        #region server return
        
        void r_GETU(object sender, serverReturnEventArgs e)
        {
            _Server.id = int.Parse(getval(e.data, "id"));
            name = getval(e.data, "username");
            mail = getval(e.data, "email");
            firstName = getval(e.data, "name");
            surName = getval(e.data, "givenname");
            birth = getval(e.data, "birthday");
            location = getval(e.data, "location");
            gender = getval(e.data, "gender");
            phone = getval(e.data, "telephone");
            refresh();
        }
        void r_SETU(object sender, serverReturnEventArgs e)
        {
            String r = e.data;
        }
        #endregion server return

        #region methods
        public override void refresh_label() { }

        /// <summary>
        /// confirmation of modification
        /// </summary>
        public void edit()
        {
            if (!mail.Equals(tmpmail) && VMLogIn.IsValidEmail(tmpmail)) {_Server.SetInfoUser(this._name, "email", this.tmpmail);}
            if (!firstName.Equals(tmpfirstName)) {_Server.SetInfoUser(this._name, "name", this.tmpfirstName); }
            if (!surName.Equals(tmpsurName)) {_Server.SetInfoUser(this._name, "givenname", this.tmpsurName); }
            if (!birth.Equals(tmpbirth) && VMLogIn.IsValidDate(tmpbirth)) {_Server.SetInfoUser(this._name, "birthday", this.tmpbirth); }
            if (!location.Equals(tmplocation)) {_Server.SetInfoUser(this._name, "location", this.tmplocation); }
            if (!phone.Equals(tmpphone)) {_Server.SetInfoUser(this._name, "telephone", this.tmpphone); }
            if (!gender.Equals(tmpgender) && VMLogIn.IsValidGender(tmpgender)) {_Server.SetInfoUser(this._name, "gender", this.tmpgender); }
            _Server.GetInfoUser(this._name);
        }

        /// <summary>
        /// cancel modification
        /// </summary>
        public void refresh()
        {
            tmpmail = mail;
            tmpfirstName = firstName;
            tmpsurName = surName;
            tmpbirth = birth;
            tmplocation = location;
            tmpphone = phone;
            tmpgender = gender;
        }

        #endregion methods

        #region static

        /// <summary>
        /// a function for getting a specific value form a string server formated 
        /// </summary>
        /// <param name="data"></param>
        /// <param name="key"></param>
        /// <returns></returns>
        public static string getval(string data, string key)
        {
            string ret = "";

            string[] values = data.Split('\n');

            foreach (string tmp in values)
            {
                if (tmp.IndexOf(key) == 0)
                {
                    int separator = key.Length + 1;
                    ret = tmp.Substring(separator);
                    break;
                }
            }

            return ret;
        }

        #endregion static

    }
}

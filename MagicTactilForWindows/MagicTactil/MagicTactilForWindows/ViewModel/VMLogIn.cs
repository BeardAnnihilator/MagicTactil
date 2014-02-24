using System.Windows.Input;
using MagicTactilForWindows.Utilities;
using System;
using MagicTactilForWindows.Model;
using System.Windows;
using System.Globalization;

namespace MagicTactilForWindows.ViewModel
{
    class VMLogIn : APage
    {
        #region attribute
        /*
         * The link to the server
         */
        private Network _Server;

        #region error message
        private string _message;
        public string message { get { return _message; } set { _message = value; OnPropertyChanged("message"); } }
        #endregion error message

        #region radiobutton,login signup
        /*
         * This boolean represent the Radio button login/signup
         */
        private bool __RBlogIn = true;
        public bool BoolLogIn { get { return __RBlogIn; } set { __RBlogIn = value; this.message = ""; } }
        public bool BoolSignUp { get { return !__RBlogIn; } set { __RBlogIn = !value; this.message = ""; } }

        #endregion radiobutton,login signup

        #region login/password
        /*
         * these string represent the name and password.
         */
        private string _name = "";
        private string _password = "";
        private string _confirmPassword = "";
        public string name { get { return _name; } set { _name = value; } }
        public string password { get { return _password; } set { _password = value; } }
        public string confirmPassword { get { return _confirmPassword; } set { _confirmPassword = value; } }

        #endregion login/password

        #region REGU info
        private string _mail ="";
        public string mail { get { return _mail; } set { _mail = value; } }

        private string _firstName ="";
        public string firstName { get { return _firstName; } set { _firstName = value; } }

        private string _surName = "";
        public string surName { get { return _surName; } set { _surName = value; } }

        private string _birth = "";
        public string birth { get { return _birth; } set { _birth = value; } }

        private string _location ="";
        public string location { get { return _location; } set { _location = value; } }

        private string _phone ="";
        public string phone { get { return _phone; } set { _phone = value; } }

        private string _gender ="";
        public string gender { get { return _gender; } set { _gender = value; } }

        #endregion REGU info

        #region command
        /*
         * command associated to the xaml button
         */
        private ICommand __connect;
        public ICommand connect
        {
            get
            {
                if (__connect == null)
                    __connect = new RelayCommand<object>(connection, null);
                return __connect;
            }
        }

        #endregion command

        #endregion attribute

        #region constructor
        /*
         * constructor, takes the server in argument.
         */
        public VMLogIn(Network Server)
        {
            _Server = Server;

            Server.REGUReturn += this.r_REGU;
            Server.SGNIReturn += this.r_SGNI;
        }
        #endregion

        #region navigation

        private void connection(object param)
        {
            message = "";
            if (this.__RBlogIn && nameCheck(this._name) && passCheck(this._password))
                this._Server.SignIn(this._name, this._password);
            else if (!this.__RBlogIn && emailCheck(this.mail) && nameCheck(this._name) && this._password.Equals(this._confirmPassword) && passCheck(this._password))
                this._Server.SignUp(this._mail, this._name, this._firstName, this._surName,
                    this._birth, this._location, this._password, this._phone, this._gender);
        }

        public void passActu(object source, RoutedEventArgs e)
        {
            password = ((Microsoft.Surface.Presentation.Controls.SurfacePasswordBox)(e.Source)).Password;
        }

        public void confirmPassActu(object source, RoutedEventArgs e)
        {
            confirmPassword = ((Microsoft.Surface.Presentation.Controls.SurfacePasswordBox)(e.Source)).Password;
        }

        void r_REGU(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
                this.message = "Sign up succed, try to login now.";
            else
                this.message = "Sign up failed.";
        }

        void r_SGNI(object sender, serverReturnEventArgs e)
        {
            if (e.data.Contains("OK"))
            {

                password = "";
                MoveToEventArgs m = new MoveToEventArgs("InnerBoard");
                EventHandler<MoveToEventArgs> handler = this.getMoveTo();

                if (handler != null)
                    handler(this, m);
            }
            else
                this.message = "Log in failed.";
        }

        #endregion navigation

        #region error management

        private bool emailCheck(string email)
        {
            bool ret = IsValidEmail(email);
            if (!ret)
                message = "Invalid email";
            return ret;
        }

        private bool nameCheck(string name)
        {
            bool ret = IsValidName(name);
            if (!ret)
                message = "Invalid name (only letters)";
            return ret;
        }

        private bool passCheck(string pass)
        {
            bool ret = IsValidPass(pass);
            if (!ret)
                message = "Invalid password ( \\ is a forbidden character)";
            return ret;
        }

        #endregion error management

        #region static
        public static bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool IsValidName(string name)
        {
            if (name == null || name.Equals(""))
                return false;
            foreach (char c in name)
            {
                if (!char.IsLetter(c))
                    return false;
            }

            return true;
        }

        public static bool IsValidPass(string name)
        {
            if (name == null || name.Equals(""))
                return false;
            foreach (char c in name)
            {
                if (c == '\\')
                    return false;
            }

            return true;
        }

        public static bool IsValidDate(string date)
        {

            
            DateTime value;
            //if (DateTime.TryParseExact(date, "dd/MM/yyyy", 
            //    CultureInfo.InvariantCulture, DateTimeStyles.None, out value))
            if (DateTime.TryParse(date, out value))
                return true;
            return false;
        }

        public static bool IsValidGender(string gender)
        {
            if (gender.Equals("F") || gender.Equals("M"))
                return true;
            return false;
        }
        
        #endregion
    }
}

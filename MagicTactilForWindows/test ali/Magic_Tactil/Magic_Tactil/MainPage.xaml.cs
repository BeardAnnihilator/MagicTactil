using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using Microsoft.Phone.Controls;

namespace Magic_Tactil
{
    public partial class MainPage : PhoneApplicationPage
    {
        // Constructor
        public MainPage()
        {
            InitializeComponent();
        }

        private void Button_Tap(object sender, GestureEventArgs e)
        {
            if (!string.IsNullOrEmpty(Login.Text) && !string.IsNullOrEmpty(Pwd.Password) )
                NavigationService.Navigate(new Uri("/Homepage.xaml?login=" + Login.Text +"&password=" + Pwd.Password, UriKind.Relative));
        }

        private void Password_PasswordChanged(object sender, RoutedEventArgs e)
        {

        }
    }
}
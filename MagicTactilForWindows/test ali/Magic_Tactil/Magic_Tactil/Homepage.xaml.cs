﻿using System;
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
    public partial class Page1 : PhoneApplicationPage
    {
        public Page1()
        {
            InitializeComponent();
        }

        protected override void OnNavigatedTo(System.Windows.Navigation.NavigationEventArgs e)
        {
            string login;
            string password;
            if (NavigationContext.QueryString.TryGetValue("login", out login) && NavigationContext.QueryString.TryGetValue("password", out password))
            {
                Bonjour.Text += " " + login + " ton mot de passe est " + password;
            }
            base.OnNavigatedTo(e);
        }
    }
}
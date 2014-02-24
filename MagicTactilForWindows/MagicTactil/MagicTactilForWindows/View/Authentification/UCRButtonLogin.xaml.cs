using System;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace MagicTactilForWindows
{
	/// <summary>
	/// Interaction logic for UCRButtonLogin.xaml
	/// </summary>
	public partial class UCRButtonLogin : UserControl
	{
        public event EventHandler SGNICheck;
        public event EventHandler REGUCheck;

		public UCRButtonLogin()
		{
			this.InitializeComponent();
		}

        private void RBLogIn_Checked(object sender, RoutedEventArgs e)
        {
            if (this.SGNICheck != null)
                this.SGNICheck(this, e);
        }

        private void RBSignUp_Checked(object sender, RoutedEventArgs e)
        {
            if (this.REGUCheck != null)
                this.REGUCheck(this, e);
        }
	}
}
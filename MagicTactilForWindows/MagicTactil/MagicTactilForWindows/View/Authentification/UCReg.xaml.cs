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
	/// Interaction logic for UCReg.xaml
	/// </summary>
	public partial class UCReg : UserControl
	{
		public UCReg()
		{
			this.InitializeComponent();
		}

        private void PasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            ((ViewModel.VMLogIn)(DataContext)).passActu(sender, e);
        }

        private void confirmPassbox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            ((ViewModel.VMLogIn)(DataContext)).confirmPassActu(sender, e);
        }
	}
}
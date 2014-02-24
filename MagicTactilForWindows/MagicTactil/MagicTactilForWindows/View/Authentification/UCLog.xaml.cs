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
	/// Interaction logic for UCLog.xaml
	/// </summary>
	public partial class UCLog : UserControl
	{
       // public event EventHandler PWDChanged;

		public UCLog()
		{
			this.InitializeComponent();
		}

        private void SurfacePasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            ((ViewModel.VMLogIn)(DataContext)).passActu(sender, e);
        }
	}
}
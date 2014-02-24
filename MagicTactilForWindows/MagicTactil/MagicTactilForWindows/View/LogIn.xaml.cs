using System.Windows.Controls;

namespace MagicTactilForWindows.View
{
	/// <summary>
	/// Interaction logic for LogIn.xaml
	/// </summary>
	public partial class LogIn : UserControl
	{


		public LogIn()
		{
			this.InitializeComponent();
            radioLogin.SGNICheck += new System.EventHandler(radioLogin_SGNICheck);
            radioLogin.REGUCheck += new System.EventHandler(radioLogin_REGUCheck); 
		}


        void radioLogin_REGUCheck(object sender, System.EventArgs e)
        {
            logTools.Visibility = System.Windows.Visibility.Hidden;
            regTools.Visibility = System.Windows.Visibility.Visible;
        }

        void radioLogin_SGNICheck(object sender, System.EventArgs e)
        {
            logTools.Visibility = System.Windows.Visibility.Visible;
            regTools.Visibility = System.Windows.Visibility.Hidden;
        }
	}
}
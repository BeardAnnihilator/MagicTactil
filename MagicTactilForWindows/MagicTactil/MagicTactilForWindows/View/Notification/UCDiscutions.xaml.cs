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
using Microsoft.Surface.Presentation.Controls;

namespace MagicTactilForWindows
{
	/// <summary>
	/// Interaction logic for UCDiscutions.xaml
	/// </summary>
	public partial class UCDiscutions : UserControl
	{
		public UCDiscutions()
		{
			this.InitializeComponent();
            SurfaceScrollViewer.SetHorizontalScrollBarVisibility(ConversList, ScrollBarVisibility.Hidden);
            SurfaceScrollViewer.SetVerticalScrollBarVisibility(ConversList, ScrollBarVisibility.Disabled);
		}
	}
}
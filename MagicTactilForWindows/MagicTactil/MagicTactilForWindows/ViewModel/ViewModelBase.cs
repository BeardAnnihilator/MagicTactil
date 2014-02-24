using System.ComponentModel;
using System;
using MagicTactilForWindows.Utilities;

namespace MagicTactilForWindows.ViewModel
{
    //used for binded property, throw an event in case of modification

  public class ViewModelBase : INotifyPropertyChanged
  {
    #region INotifyPropertyChanged Members
    protected void OnPropertyChanged(string name)
    {
      if (PropertyChanged != null)
        PropertyChanged(this,new PropertyChangedEventArgs(name));
    }
    public event PropertyChangedEventHandler PropertyChanged;
    #endregion
  }
}

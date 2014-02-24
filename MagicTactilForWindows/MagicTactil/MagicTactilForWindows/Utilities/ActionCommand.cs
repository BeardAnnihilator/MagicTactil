using System;
using System.Windows.Input;
using System.Diagnostics;

namespace MagicTactilForWindows.Utilities
{
    public class RelayCommand<T> : ICommand
    {
        #region Fields

        readonly Action<T> _execute = null;
        readonly Predicate<T> _canExecute = null;
        readonly int _p;
        #endregion // Fields

        #region Constructors

        public RelayCommand(Action<T> execute)
            : this(execute, null, 0)
        {
        }

        /// <summary>
        /// Creates a new command.
        /// </summary>
        /// <param name="execute">The execution logic.</param>
        /// <param name="canExecute">The execution status logic.</param>
        public RelayCommand(Action<T> execute, Predicate<T> canExecute)
            : this(execute, canExecute, 0)
        {
            if (execute == null)
                throw new ArgumentNullException("execute");

            _execute = execute;
            _canExecute = canExecute;
        }

        public RelayCommand(Action<T> execute, Predicate<T> canExecute, int p)
        {
            if (execute == null)
                throw new ArgumentNullException("execute");
            _p = p;
            _execute = execute;
            _canExecute = canExecute;
        }

        #endregion // Constructors

        #region ICommand Members

        [DebuggerStepThrough]
        public bool CanExecute(object parameter)
        {
            if (_p == 0)
            return _canExecute == null ? true : _canExecute((T)parameter);
            else
                return _canExecute == null ? true : _canExecute((T)((object)_p));
        }

        public event EventHandler CanExecuteChanged
        {
            add { CommandManager.RequerySuggested += value; }
            remove { CommandManager.RequerySuggested -= value; }
        }

        public void Execute(object parameter)
        {
            if (_p == 0)
                _execute((T)parameter);
            else
                _execute((T)((object)_p));
        }

        #endregion // ICommand Members
    }

}

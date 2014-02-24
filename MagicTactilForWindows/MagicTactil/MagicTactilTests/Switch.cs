using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MagicTactilTests
{
    [TestClass]
    public class Switch
    {
        [TestMethod]
        public void Switcher()
        {
            try
            {

                MagicTactilForWindows.ViewModel.Switcher deck = new MagicTactilForWindows.ViewModel.Switcher();
            }
            catch (Exception)
            {
                var message = "problem with VM";
            }
        
        }
    }
}

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace UnitTestProject1
{
    [TestClass]
    public class Tests
    {
        [TestMethod]
        public void TestMethod1()
        {
            MagicTactilForWindows.Model.Network network = null;
            try
            {
                network = new MagicTactilForWindows.Model.Network();
                network.connect("127.0.0.1", 3000);  //127.0.0.1
            }
            catch (Exception)
            {
                var message = "Unable to connect to the server";
                Assert.Fail(message);
            }

            MagicTactilForWindows.ViewModel.VMLogIn login = new MagicTactilForWindows.ViewModel.VMLogIn(network);

        }

    }
}

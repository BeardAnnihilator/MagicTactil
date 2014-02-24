using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MagicTactilTests
{
    [TestClass]
    public class Login
    {
        [TestMethod]
        public void TestConnection()
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

        [TestMethod]
        public void TestDateValidationOk()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMLogIn.IsValidDate("13-12-1991"), "date should be ok");
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMLogIn.IsValidDate("13/12/1991"), "date should be ok");
        }

        [TestMethod]
        public void TestDateValidationko()
        {
            Assert.IsFalse(MagicTactilForWindows.ViewModel.VMLogIn.IsValidDate("12-13-1991"), "date should be ko");
        }

        [TestMethod]
        public void TestEmailValidationok()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMLogIn.IsValidEmail("boum@toto.com"), "email should be ok");
        }

        [TestMethod]
        public void TestEmailValidationko()
        {
            Assert.IsFalse(MagicTactilForWindows.ViewModel.VMLogIn.IsValidEmail("wwwwourwerla"), "email should be ko");
        }

        [TestMethod]
        public void TestGenderValidationok()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMLogIn.IsValidGender("M"), "gender should be ok");
        }

        [TestMethod]
        public void TestGenderValidationko()
        {
            Assert.IsFalse(MagicTactilForWindows.ViewModel.VMLogIn.IsValidGender("XX"), "gender should be ko");
        }

        [TestMethod]
        public void TestNameValidationok()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMLogIn.IsValidName("Bob"), "name should be ok");
        }

        [TestMethod]
        public void TestNameValidationko()
        {
            Assert.IsFalse(MagicTactilForWindows.ViewModel.VMLogIn.IsValidName(")&$gigi"), "name should be ko");
        }

        [TestMethod]
        public void TestPasswordValidationok()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMLogIn.IsValidPass("salutlol"), "name should be ok");
        }

        [TestMethod]
        public void TestPasswordValidationko()
        {
            Assert.IsFalse(MagicTactilForWindows.ViewModel.VMLogIn.IsValidPass(""), "name should be ko");
        }
    }
}

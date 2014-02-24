using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MagicTactilTests
{
    [TestClass]
    public class profile
    {
        [TestMethod]
        public void VMprofileinstanciation()
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

            try
            {

                MagicTactilForWindows.ViewModel.VMProfile deck = new MagicTactilForWindows.ViewModel.VMProfile(network);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMprofileEdit()
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

            try
            {

                MagicTactilForWindows.ViewModel.VMProfile profile = new MagicTactilForWindows.ViewModel.VMProfile(network);
                profile.mail = "";
                profile.birth = "";
                profile.firstName = "";
                profile.gender = "";
                profile.location = "";
                profile.name = "";
                profile.phone = "";
                profile.surName = "";
                profile.tmpbirth = "";
                profile.tmpfirstName = "";
                profile.tmpgender = "";
                profile.tmplocation = "";
                profile.tmpmail = "";
                profile.tmpphone = "";
                profile.tmpsurName = "";
                profile.edit();
            }
            catch (Exception)
            {
                var message = "problem with VM";
                Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMprofileEditexception()
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

            try
            {

                MagicTactilForWindows.ViewModel.VMProfile profile = new MagicTactilForWindows.ViewModel.VMProfile(network);
                profile.edit();
                Assert.Fail("exception should have benn thrown");
            }
            catch (Exception)
            {
                var message = "OK";
                
            }
        }

        [TestMethod]
        public void getvaltest()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\n", "id").Equals("1"));
        }

        [TestMethod]
        public void getvaltest1()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\n", "nameOwner").Equals("alex"));
        }

        [TestMethod]
        public void getvaltest2()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\n", "nameRoom").Equals("test_01"));
        }

        [TestMethod]
        public void getvaltest3()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rStan\nnameRoom\rtest_01\nstate\r1\n", "format").Equals("Stan"));
        }

        [TestMethod]
        public void getvaltest4()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\n", "state").Equals("1"));
        }

        [TestMethod]
        public void getvaltest5()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\n", "id").Equals("1"));
        }

        [TestMethod]
        public void getvaltest6()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\n", "nameOwner").Equals("alex"));
        }

        [TestMethod]
        public void getvaltest7()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\n", "nameRoom").Equals("test_01"));
        }

        [TestMethod]
        public void getvaltest8()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rStandard\nnameRoom\rtest_01\nstate\r1\n", "format").Equals("Standard"));
        }

        [TestMethod]
        public void getvaltest9()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\n", "state").Equals("1"));
        }

        [TestMethod]
        public void getvaltest10()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\n", "id").Equals("1"));
        }

        [TestMethod]
        public void getvaltest11()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\n","nameOwner").Equals("alex"));
        }

        [TestMethod]
        public void getvaltest12()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\n","nameRoom").Equals("test_01"));
        }

        [TestMethod]
        public void getvaltest13()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\n", "format").Equals("Vintage"));
        }

        [TestMethod]
        public void getvaltest14()
        {
            Assert.IsTrue(MagicTactilForWindows.ViewModel.VMProfile.getval("id\r1\nnameOwner\ralex\nformat\rVintage\nnameRoom\rtest_01\nstate\r1\n", "state").Equals("1"));
        }
    }
}

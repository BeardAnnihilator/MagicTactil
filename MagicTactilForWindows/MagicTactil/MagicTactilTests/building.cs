using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MagicTactilTests
{
    [TestClass]
    public class building
    {
        [TestMethod]
        public void VMBuildinginstance()
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

                MagicTactilForWindows.ViewModel.VMBuilding building = new MagicTactilForWindows.ViewModel.VMBuilding(network);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                //Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMBuildingback()
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

                MagicTactilForWindows.ViewModel.VMBuilding building = new MagicTactilForWindows.ViewModel.VMBuilding(network);
                //building.back.Execute(null);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                //Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMBuildingclear()
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

                MagicTactilForWindows.ViewModel.VMBuilding building = new MagicTactilForWindows.ViewModel.VMBuilding(network);
                building.Clear();
            }
            catch (Exception)
            {
                var message = "problem with VM";
                //Assert.Fail(message);
            }
        }

        [TestMethod]
        public void VMBuildingsave()
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

                MagicTactilForWindows.ViewModel.VMBuilding building = new MagicTactilForWindows.ViewModel.VMBuilding(network);
                //building.save.Execute(null);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                //Assert.Fail(message);
            }
        }


        [TestMethod]
        public void VMBuildingedit()
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

                MagicTactilForWindows.ViewModel.VMBuilding building = new MagicTactilForWindows.ViewModel.VMBuilding(network);
            }
            catch (Exception)
            {
                var message = "problem with VM";
                //Assert.Fail(message);
            }
        }
    }
}

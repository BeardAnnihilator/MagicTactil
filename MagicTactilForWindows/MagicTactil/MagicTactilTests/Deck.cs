using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MagicTactilTests
{
    [TestClass]
    public class Deck
    {
        MagicTactilForWindows.ViewModel.Deck deck = new MagicTactilForWindows.ViewModel.Deck("superdeck");
        [TestMethod]
        public void AddCard()
        {
            deck.Main.Clear();
            MagicTactilForWindows.Model.Card card = new MagicTactilForWindows.Model.Card();
            deck.Main.Add(card);
            Assert.IsTrue(deck.Main.Count == 1);
        }

        [TestMethod]
        public void RemoveCard()
        {
            deck.Main.Clear();
            MagicTactilForWindows.Model.Card card = new MagicTactilForWindows.Model.Card();
            deck.Main.Add(card);
            deck.Main.Remove(card);
            Assert.IsTrue(deck.Main.Count == 0);
        }

        [TestMethod]
        public void ToString()
        {
            deck.Main.Clear();
            MagicTactilForWindows.Model.Card card = new MagicTactilForWindows.Model.Card();
            deck.Main.Add(card);
            Assert.IsTrue(deck.ToString().Equals("superdeck\t1 cards"));
            //Assert.Equals(deck.ToString(), "superdeck\t1 cards");
        }
    }
}

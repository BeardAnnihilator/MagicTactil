using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace NetWork
{
    class Serialize
    {

        public byte[] serializeString(string toSerialize)
        {
            string code = "code\r" + toSerialize + "\n";
            byte[] serialized = new byte[toSerialize.Length];
            return (serialized = Encoding.ASCII.GetBytes(toSerialize));
        }

        public byte[] serializeDictionnaryString(Dictionary<String, String> toSerialize)
        {
            if (toSerialize == null)
                return (serializeString("KO"));
            string data = "code\r" + toSerialize["code"] + "\nemail\r" + toSerialize["email"] +
                "\nusername\r" + toSerialize["username"] + "\nname\r" + toSerialize["name"] + "\ngivenname\r" +
                toSerialize["givenname"] + "\nbirthday\r" + toSerialize["birthday"] + "\nlocation\r" + toSerialize["location"] +
                "\ntelephone\r" + toSerialize["telephone"] + "\ngender\r" + toSerialize["gender"] + "\n";
             byte[] serialized = new byte[data.Length];
            return (serialized = Encoding.ASCII.GetBytes(data));          
        }
    }
}

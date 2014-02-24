using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using Newtonsoft.Json;

namespace MagicTactilForWindows.Utilities
{
    class JsonImporter
    {
        public static T _download_serialized_json_data<T>(string url) where T : new()
        {
            var content = File.ReadAllText(url);
                // if string with JSON data is not empty, deserialize it to class and return its instance 
                return !string.IsNullOrEmpty(content) ? JsonConvert.DeserializeObject<T>(content) : new T();  
        } 
    }
}

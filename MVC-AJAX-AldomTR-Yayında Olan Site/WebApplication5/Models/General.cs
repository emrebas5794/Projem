using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace WebApplication5.Models
{
    public class General
    {
        //public static string ConnectionString = "server=.;database=AldomTR;INTEGRATED SECURITY=SSPI;MultipleActiveResultSets=True";
        public static string ConnectionString = "Server=.;Database=AldomTR;Trusted_Connection=True;";

        internal static string ConvertToUrl(string Source)
        {
            string result = new Regex(@"[\s\&\/\\?=]+").Replace(Source, "_");
            result = new Regex(@"(?:_+)?([,.-])(?:_+)?").Replace(result, "$1");
            char[] tr = { 'ı', 'ğ', 'İ', 'Ğ', 'ç', 'Ç', 'ş', 'Ş', 'ö', 'Ö', 'ü', 'Ü' };
            char[] ing = { 'i', 'g', 'I', 'G', 'c', 'C', 's', 'S', 'o', 'O', 'u', 'U' };
            for (int i = 0; i < tr.Length; i++)
            {
                result = result.Replace(tr[i], ing[i]);
            }

            return result;
        }
    }

    public class Link
    {
        public string Caption { get; set; }
        public string Url { get; set; }
        public List<Link> Submenu { get; set; }
    }

    public class ImageInfo
    {
        public string url { get; set; }
        public string alt { get; set; }
        public string href { get; set; }
    }
}
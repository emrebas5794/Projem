using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace NZLOtomotiv.Models
{
    public static class Globals
    {
        public static List<string> LoggedInUsers = new List<string>();
        private static int SessionTimeout = 10; //dakika

        public static bool ManageSession(bool ThrowOnFail = false)
        {
            if (HttpContext.Current.Session["Username"] == null ||
                HttpContext.Current.Session["IP"] == null ||
                HttpContext.Current.Session["Agent"] == null ||
                (string)HttpContext.Current.Session["IP"] != HttpContext.Current.Request.ServerVariables["remote_addr"] ||
                (string)HttpContext.Current.Session["Agent"] != HttpContext.Current.Request.ServerVariables["http_user_agent"]
                )
            {
                if (ThrowOnFail)
                    throw new Exception("Session doğrulanamdı.");
                HttpContext.Current.Session.Abandon();
                return false;
            }
            if (((DateTime)HttpContext.Current.Session["LastActivity"]).AddMinutes(SessionTimeout) < DateTime.Now)
            {
                if (ThrowOnFail)
                    throw new Exception("Session zaman aşımına uğradı.");
                HttpContext.Current.Session.Abandon();
                return false;
            }
            if (!LoggedInUsers.Any(u => u == (string)HttpContext.Current.Session["Username"]))
            {
                if (ThrowOnFail)
                    throw new Exception("Yeniden giriş yapınız.");
                HttpContext.Current.Session.Abandon();
                return false;
            }

            HttpContext.Current.Session["LastActivity"] = DateTime.Now;
            return true;
        }

        public static bool IsNullOrEmpty(JToken token)
        {
            return (token == null) ||
                   (token.Type == JTokenType.Array && !token.HasValues) ||
                   (token.Type == JTokenType.Object && !token.HasValues) ||
                   (token.Type == JTokenType.String && token.ToString() == String.Empty) ||
                   (token.Type == JTokenType.Null);
        }

        public static bool IsNullOrEmptyAny(params JToken[] tokens)
        {
            bool result = false;
            foreach (JToken token in tokens)
            {
                result = result || IsNullOrEmpty(token);
                if (result)
                    break;
            }
            return result;
        }

        public static string StringExp(string Text)
        { 
            string[] Turkce = { "İ", "ı", "Ö", "ö", "Ü", "ü", "Ş", "ş", "Ğ", "ğ", "Ç", "ç", "s", " ", "-" };
            string[] Engilsh = { "I", "i", "O", "o", "U", "u", "S", "s", "G", "g", "C", "c", "s", "_", "_" };

            for (int i = 0; i < Turkce.Length; i++)
            {
                Text = Text.Replace(Turkce[i], Engilsh[i]);
            }
            return Text;
        }
    }
}
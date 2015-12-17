using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication5.Models
{
    public class SessionManager
    {
        private static int SessionTimeout = 60;
        public static void Register(string Username)
        {
            HttpContext.Current.Session.Add("Username", Username);
            HttpContext.Current.Session.Add("IP", HttpContext.Current.Request.ServerVariables["remote_addr"]);
            HttpContext.Current.Session.Add("UserAgent", HttpContext.Current.Request.ServerVariables["http_user_agent"]);
            HttpContext.Current.Session.Add("LastActivity", DateTime.Now);
        }

        public static bool isValid()
        {
            if (HttpContext.Current.Session["Username"] == null ||
                HttpContext.Current.Session["IP"] == null ||
                HttpContext.Current.Session["UserAgent"] == null ||
                (string)HttpContext.Current.Session["IP"] != HttpContext.Current.Request.ServerVariables["remote_addr"] ||
                (string)HttpContext.Current.Session["UserAgent"] != HttpContext.Current.Request.ServerVariables["http_user_agent"] ||
                ((DateTime)HttpContext.Current.Session["LastActivity"]).AddMinutes(SessionTimeout) < DateTime.Now
                )
            {
                HttpContext.Current.Session.Abandon();
                return false;
            }

            HttpContext.Current.Session.Add("LastActivity", DateTime.Now);
            return true;
        }
    }
}
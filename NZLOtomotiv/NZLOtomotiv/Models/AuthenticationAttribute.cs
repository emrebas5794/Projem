using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NZLOtomotiv.Models
{
    public class AuthenticationAttribute : FilterAttribute, IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationContext filterContext)
        {
            string username = (string)filterContext.HttpContext.Session["username"];
            if ((string)filterContext.HttpContext.Session["ip"] != filterContext.HttpContext.Request.ServerVariables["remote_addr"]
                || (string)filterContext.HttpContext.Session["agent"] != filterContext.HttpContext.Request.ServerVariables["http_user_agent"])
            {
                //throw new SessionExpiredException();
            }
        }
    }

    public class SessionExpiredException : Exception
    {
        
    }
}
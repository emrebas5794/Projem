using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;

namespace NZLOtomotiv.Models
{
    internal class User
    {
        internal string Username { get; set; }
        internal DateTime LastActivity { get; set; }
        internal IPAddress IPAddress { get; set; }
    }
}
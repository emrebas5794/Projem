using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NZLOtomotiv.Models
{
    internal class Database
    {
        internal const string ConnectionString = @"Server=EMRE\MSSQLSERVERR;Database=NazliOtomotiv;Trusted_Connection=True;"; // Ozan Local
        //internal const string ConnectionString = "Server=.\\SQLINSTANCE;Database=NazliOtomotiv;User Id=NazliOtomotiv;Password=msql95MG3,Ed;"; // Server
        //"server=.\\SQLExpress;database=NazliOtomotiv;INTEGRATED SECURITY=SSPI"; // Zafer Local
    }
}
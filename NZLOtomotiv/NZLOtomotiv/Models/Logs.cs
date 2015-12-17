using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;

namespace NZLOtomotiv.Models
{
    internal class Logs
    {

    }

    internal class ErrorLogs
    {
        private static Dictionary<string, ErrorLog> ErrorLog = new Dictionary<string, ErrorLog>();
        internal static void LogNewError(ErrorLog Log)
        {
            ErrorLog.Add(Log.Type, Log);
        }

    }

    internal class ErrorLog
    {
        internal string Type { get; set; }
        internal int Code { get; set; }
        internal string Message { get; set; }
        internal string Context { get; set; }
        internal DateTime Time { get; set; }
        public ErrorLog(string Type, int Code, string Message)
        {
            this.Type = Type;
            this.Code = Code;
            this.Message = Message;
            this.Context = new StackTrace().GetFrame(1).GetMethod().Name;
            this.Time = DateTime.Now;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _5te5 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RedirectTo("5te5.apk");
    }
    private void RedirectTo(string url)
{
    string redirectURL = Page.ResolveClientUrl(url);
string script = "window.location = " + redirectURL + ";";
ScriptManager.RegisterStartupScript(this, typeof(Page), "RedirectTo", script, true);
}
}
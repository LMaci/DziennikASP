using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace DziennikASP
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.Name == ("Student"))
            {
                Oceny.Visible = true;
            }
            else if(HttpContext.Current.User.Identity.Name == ("Wykladowca"))
            {
                Oceny.Visible = true;
                Projekty.Visible = true;
            }
        }

        protected void Wyloguj(object sender, LoginCancelEventArgs e)
        {
            // Clear authentication cookie
            HttpCookie rFormsCookie = new HttpCookie(FormsAuthentication.FormsCookieName, "");
            rFormsCookie.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(rFormsCookie);

            // Clear session cookie 
            HttpCookie rSessionCookie = new HttpCookie("ASP.NET_SessionId", "");
            rSessionCookie.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(rSessionCookie);

            Response.Cookies["MyCookie"].Expires = DateTime.Now.AddDays(-1);

            Session.Clear();
            Session.Abandon();
            FormsAuthentication.SignOut();
            Response.Clear();
            Response.Redirect("~/");
        }
    }
}
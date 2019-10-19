using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DziennikASP.Secure
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.Name == "Student")
                Response.Redirect("~/Student.aspx");
            else if (HttpContext.Current.User.Identity.Name == "Wykladowca")
                Response.Redirect("~/Wykladowca.aspx");
            else if (HttpContext.Current.User.Identity.Name == "Pracownik")
                Response.Redirect("~/Pracownik.aspx");
            else Response.Redirect("~/");
        }
    }
}
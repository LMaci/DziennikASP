using System;
using System.Linq;
using System.Web;


namespace DziennikASP
{
    public partial class Wykladowca : System.Web.UI.Page
    {
        PRZEDMIOT przedmiot = new PRZEDMIOT();
        STUDENT student = new STUDENT();
        PROJEKT projekt = new PROJEKT();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (GridView2.Rows.Count == 0)
            {
                Panel1.Visible = false;
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            String przedmiotNazwa = GridView1.SelectedRow.Cells[1].Text;
            przedmiot = Logowanie.db.PRZEDMIOT.First(x => x.NAZWA == przedmiotNazwa);
            Session["przedmiot_ID"] = przedmiot.ID;
            Panel1.Visible = false;
            GridView3.Visible = true;
        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            String numerIndeksu = GridView2.SelectedRow.Cells[3].Text;
            student = Logowanie.db.STUDENT.First(x => x.NUMER_ALBUMU == numerIndeksu);
            Session["student_ID"] = student.ID;
            Panel1.Visible = true;
            GridView3.Visible = true;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(tbOpis.Text))
            {
                try
                {
                    int stID = int.Parse(Session["student_ID"].ToString());
                    int przID = int.Parse(Session["przedmiot_ID"].ToString());
                    STUDENT_PRZEDMIOT nowaOcena = new STUDENT_PRZEDMIOT();
                    nowaOcena.STUDENT_ID = stID;
                    nowaOcena.PRZEDMIOT_ID = przID;
                    nowaOcena.OCENA = decimal.Parse(DropDownList1.SelectedValue);
                    nowaOcena.OPIS = tbOpis.Text.ToString();

                    Logowanie.db.STUDENT_PRZEDMIOT.Add(nowaOcena);
                    Logowanie.db.SaveChanges();
                    GridView3.DataBind();
                }
                catch { Response.Write("COŚ POSZŁO NIE TAK!"); }
            }
            else Response.Write("Brak opisu oceny!");
        }

    }
}
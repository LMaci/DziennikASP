using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DziennikASP
{
    public partial class Projekty : System.Web.UI.Page
    {
        PRZEDMIOT przedmiot;
        int projektID;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(tbTemat.Text))
            {
                try
                {
                    int przID = int.Parse(Session["przedmiot_ID"].ToString());
                    int prID = int.Parse(Session["pracownik_ID"].ToString());

                    PROJEKT nowyProjekt = new PROJEKT();
                    nowyProjekt.PRACOWNIK_ID = prID;
                    nowyProjekt.PRZEDMIOT_ID = przID;
                    nowyProjekt.TEMAT = tbTemat.Text.ToString();

                    Logowanie.db.PROJEKT.Add(nowyProjekt);
                    Logowanie.db.SaveChanges();
                    DataBind();
                }
                catch { Response.Write("COŚ POSZŁO NIE TAK!"); }
            }
            else Response.Write("Nazwa tematu nie może być pusta!");
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            String przedmiotNazwa = GridView1.SelectedRow.Cells[1].Text;
            przedmiot = Logowanie.db.PRZEDMIOT.First(x => x.NAZWA == przedmiotNazwa);
            Session["przedmiot_ID"] = przedmiot.ID;
            panelNowyTemat.Visible = true;
            lbTemat.Text = null;
            panelNowyTemat.Visible = true;
        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            lbTemat.Text = GridView2.SelectedRow.Cells[1].Text;
            Panel1.Visible = true;
            Panel3.Visible = true;
        }


        protected void GridView4_SelectedIndexChanged(object sender, EventArgs e)
        {
            lbImie.Text = GridView4.SelectedRow.Cells[1].Text;
            lbNazwisko.Text = GridView4.SelectedRow.Cells[2].Text;
            lbIndeks.Text = GridView4.SelectedRow.Cells[3].Text;
            projektID = int.Parse(GridView4.DataKeys[GridView4.SelectedIndex].Value.ToString());
            //Response.Write(projektID);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (GridView4.SelectedIndex != -1)
            {
                projektID = int.Parse(GridView4.DataKeys[GridView4.SelectedIndex].Value.ToString());
                PROJEKT projekt = Logowanie.db.PROJEKT.First(x => x.ID == projektID);
                projekt.POTWIERDZONY = true;
                Logowanie.db.Entry(projekt).State = System.Data.Entity.EntityState.Modified;
                Logowanie.db.SaveChanges();
                DataBind();
                lbImie.Text = "-";
                lbNazwisko.Text = "-";
                lbIndeks.Text = "-";
                projektID = -1;
                GridView4.SelectedIndex = -1;
            }
            else Response.Write("Musisz wybrać studenta aby akceptować zgłoszenie");
            
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            if(GridView4.SelectedIndex != -1)
            {
                projektID = int.Parse(GridView4.DataKeys[GridView4.SelectedIndex].Value.ToString());
                PROJEKT projekt = Logowanie.db.PROJEKT.First(x => x.ID == projektID);
                Logowanie.db.PROJEKT.Remove(projekt);
                Logowanie.db.Entry(projekt).State = System.Data.Entity.EntityState.Deleted;
                Logowanie.db.SaveChanges();
                DataBind();
                lbImie.Text = "-";
                lbNazwisko.Text = "-";
                lbIndeks.Text = "-";
                GridView4.SelectedIndex = -1;
            } else Response.Write("Musisz wybrać studenta aby anulować zgłoszenie");

        }
    }
}
using System;
using System.Linq;

namespace DziennikASP
{
    public partial class Student : System.Web.UI.Page
    {
        DANE_OSOBOWE dane;
        AUTH auth;
        PRZEDMIOT przedmiot;
        bool pokaz = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            dane = Logowanie.db.DANE_OSOBOWE.First(x => x.ID == Logowanie.osoba.ID);
            auth = Logowanie.db.AUTH.First(x => x.ID == dane.ID);
            if (IsPostBack)
                pokaz = true;
            else pokaz = false;
            elementy();
            lbImie.Text = Logowanie.osoba.Imie;
            lbNazwisko.Text = Logowanie.osoba.Nazwisko;
            lbIndeks.Text = Logowanie.osoba.NrIndeksu;
        }

        protected void elementy()
        {
            if(pokaz)
            {
                Panel1.Visible = true;
                Panel2.Visible = true;
                Panel3.Visible = true;
                Panel4.Visible = true;
            } else
            {
                Panel1.Visible = false;
                Panel2.Visible = false;
                Panel3.Visible = false;
                Panel4.Visible = false;
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //GridView2.Visible = true;
            //int indeks = int.Parse(GridView1.SelectedIndex.ToString());
            String przedmiotNazwa = GridView1.SelectedRow.Cells[1].Text;
            przedmiot = Logowanie.db.PRZEDMIOT.First(x => x.NAZWA == przedmiotNazwa);
            Session["przedmiot_id"] = przedmiot.ID;
            pokaz = true;
            elementy();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(TextBox1.Text) && !string.IsNullOrEmpty(TextBox2.Text))
            {
                auth.LOGIN = TextBox1.Text;
                auth.HASLO = TextBox2.Text;

                Logowanie.db.Entry(auth).State = System.Data.Entity.EntityState.Modified;
                Logowanie.db.SaveChanges();
                Response.Write("Zmieniono dane logowania!");
            }
            
        }

        protected void btProjekt_Click(object sender, EventArgs e)
        {
            String przedmiotNazwa = GridView1.SelectedRow.Cells[1].Text;
            przedmiot = Logowanie.db.PRZEDMIOT.First(x => x.NAZWA == przedmiotNazwa);
            int zapytanie = Logowanie.db.PROJEKT.Count(x => x.TEMAT == ddlTematy.SelectedValue && x.STUDENT_ID == Logowanie.osoba.idStudenta);
            if (zapytanie == 0)
            {
                PROJEKT noweZgloszenie = new PROJEKT();
                noweZgloszenie.TEMAT = ddlTematy.SelectedValue;
                noweZgloszenie.STUDENT_ID = int.Parse(Session["student_ID"].ToString());
                noweZgloszenie.PRACOWNIK_ID = przedmiot.PRACOWNIK_ID;
                noweZgloszenie.PRZEDMIOT_ID = przedmiot.ID;
                noweZgloszenie.POTWIERDZONY = false;
                Logowanie.db.PROJEKT.Add(noweZgloszenie);
                Logowanie.db.SaveChanges();
                DataBind();
            }
            else Response.Write("Twoje zgłoszenie zostało już złożone!");
            
        }

        protected void ddlTematy_SelectedIndexChanged(object sender, EventArgs e)
        {
            btProjekt.Visible = true;
            btProjekt.Enabled = true;
        }
    }
}
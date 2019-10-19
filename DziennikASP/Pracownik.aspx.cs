using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DziennikASP
{
    public partial class Pracownik : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            AUTH auth = new AUTH();
            auth.LOGIN = tbLogin.Text;
            auth.HASLO = tbHaslo.Text;
            auth.UPRAWNIENIA = 1;
            Logowanie.db.AUTH.Add(auth);

            DANE_OSOBOWE noweDane = new DANE_OSOBOWE();
            noweDane.IMIE = tbImie.Text.ToString();
            noweDane.NAZWISKO = tbNazwisko.Text.ToString();
            noweDane.PLEC = ddlPlec.SelectedValue;
            noweDane.AUTH_ID = auth.ID;
            Logowanie.db.DANE_OSOBOWE.Add(noweDane);

            

            GRUPA grupa = new GRUPA();
            grupa = Logowanie.db.GRUPA.First(x => x.NAZWA == ddlGrupa.SelectedValue);

            STUDENT nowyStudent = new STUDENT();
            nowyStudent.DANE_OSOBOWE_ID = noweDane.ID;
            nowyStudent.GRUPA_ID = grupa.ID;
            nowyStudent.NUMER_ALBUMU = tbIndeks.Text.ToString();
            Logowanie.db.STUDENT.Add(nowyStudent);

            STUDENT_PRZEDMIOT testowyPrzedmiot = new STUDENT_PRZEDMIOT();
            testowyPrzedmiot.PRZEDMIOT_ID = 1;
            testowyPrzedmiot.STUDENT_ID = nowyStudent.ID;
            Logowanie.db.STUDENT_PRZEDMIOT.Add(testowyPrzedmiot);


            Logowanie.db.SaveChanges();
            GridView1.DataBind();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            tbImie0.Text = GridView1.SelectedRow.Cells[1].Text;
            tbNazwisko0.Text = GridView1.SelectedRow.Cells[2].Text;
            ddlPlec0.ClearSelection();
            ddlPlec0.Items.FindByText(GridView1.SelectedRow.Cells[3].Text).Selected = true;
            tbIndeks0.Text = GridView1.SelectedRow.Cells[4].Text;
            ddlGrupa0.ClearSelection();
            ddlGrupa0.Items.FindByText(GridView1.SelectedRow.Cells[5].Text).Selected = true;


            
            int idStudenta = int.Parse(GridView1.DataKeys[GridView1.SelectedIndex].Value.ToString());
            DANE_OSOBOWE daneOs = Logowanie.db.DANE_OSOBOWE.First(x => x.ID == idStudenta);
            try
            {
                AUTH auth = Logowanie.db.AUTH.First(x => x.ID == daneOs.AUTH_ID);
                tbLogin0.Text = auth.LOGIN;
                tbHaslo0.Text = auth.HASLO;
            }
            catch (System.InvalidOperationException)
            {
                tbLogin0.Text = "";
                tbHaslo0.Text = "";
                Response.Write("Error");
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            int idStudenta = int.Parse(GridView1.DataKeys[GridView1.SelectedIndex].Value.ToString());
              
            DANE_OSOBOWE daneOs = Logowanie.db.DANE_OSOBOWE.First(x=> x.ID == idStudenta);
            daneOs.IMIE = tbImie0.Text;
            daneOs.NAZWISKO = tbNazwisko0.Text;
            daneOs.PLEC = ddlPlec0.SelectedValue;

            if(!string.IsNullOrEmpty(tbHaslo0.Text))
                try
                {
                    AUTH auth = Logowanie.db.AUTH.First(x => x.ID == daneOs.AUTH_ID);
                    if(!string.IsNullOrEmpty(tbLogin0.Text))
                        auth.LOGIN = tbLogin0.Text;
                    auth.HASLO = tbHaslo0.Text;
                    Logowanie.db.Entry(auth).State = System.Data.Entity.EntityState.Modified;
                }
                catch (System.InvalidOperationException)
                {
                    AUTH auth = new AUTH();
                    auth.LOGIN = tbLogin0.Text;
                    auth.HASLO = tbHaslo0.Text;
                    auth.UPRAWNIENIA = 1;
                    Logowanie.db.AUTH.Add(auth);
                    daneOs.AUTH_ID = auth.ID;
                }


            GRUPA gr = Logowanie.db.GRUPA.First(x => x.NAZWA == ddlGrupa0.SelectedValue);
            STUDENT student = Logowanie.db.STUDENT.First(x=>x.DANE_OSOBOWE_ID == idStudenta);
            student.NUMER_ALBUMU = tbIndeks0.Text;
            student.GRUPA_ID = gr.ID;

            Logowanie.db.Entry(daneOs).State = System.Data.Entity.EntityState.Modified;
            Logowanie.db.Entry(student).State = System.Data.Entity.EntityState.Modified;
            Logowanie.db.SaveChanges();
            DataBind();
            Response.Write("DANE ZAUTKUALIZOWANE!");
            
        }
    }
}
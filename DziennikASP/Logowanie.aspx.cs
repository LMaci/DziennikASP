using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace DziennikASP
{
    public partial class Logowanie : System.Web.UI.Page
    {
        public static DziennikEntities db = new DziennikEntities();
        public static Osoba osoba;
        public static PracownikUczelni pracownikUczelni;
        int uprawnienia;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.IsAuthenticated)
                Response.Redirect("~/");
        }


        private bool Zaloguj()
        {
            string username = tbLogin.Text;
            string password = tbHaslo.Text;

            if (db.AUTH.Where(a => a.LOGIN == username && a.HASLO == password).Any())
            {
                AUTH auth = new AUTH();
                auth = db.AUTH.FirstOrDefault(a => a.LOGIN == username);

                DANE_OSOBOWE daneOsobowe = new DANE_OSOBOWE();
                daneOsobowe = db.DANE_OSOBOWE.First(x => x.AUTH_ID == auth.ID);

                if (db.PRACOWNIK.Where(a => a.DANE_OSOBOWE_ID == daneOsobowe.ID).Any())
                {
                    PRACOWNIK pracownik = new PRACOWNIK();
                    pracownik = db.PRACOWNIK.First(x => x.DANE_OSOBOWE_ID == daneOsobowe.ID);

                    SL_STANOWISKO sl_stanowisko = new SL_STANOWISKO();
                    sl_stanowisko = db.SL_STANOWISKO.First(x => x.ID == pracownik.SL_STANOWISKO_ID);


                    pracownikUczelni = new PracownikUczelni(daneOsobowe.ID, daneOsobowe.IMIE, daneOsobowe.NAZWISKO, daneOsobowe.PLEC, pracownik.ID, sl_stanowisko.NAZWA, auth.UPRAWNIENIA);
                    uprawnienia = auth.UPRAWNIENIA;
                }
                else
                {
                    STUDENT student = new STUDENT();
                    student = db.STUDENT.First(x => x.DANE_OSOBOWE_ID == daneOsobowe.ID);

                    try
                    {
                        STUDENT_PRZEDMIOT stuprzed = new STUDENT_PRZEDMIOT();
                        stuprzed = db.STUDENT_PRZEDMIOT.First(x => x.STUDENT_ID == student.ID);

                        osoba = new Osoba(daneOsobowe.ID, daneOsobowe.IMIE, daneOsobowe.NAZWISKO, daneOsobowe.PLEC, student.NUMER_ALBUMU, auth.UPRAWNIENIA, stuprzed.STUDENT_ID);
                        uprawnienia = auth.UPRAWNIENIA;
                    } catch
                    {
                        return false;
                    }

                    
                }
                return true;
            }
            else return false;

        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            //string user;
            if (Zaloguj())
            {
                switch (uprawnienia)
                {
                    case 1: //STUDENT
                        Session["Poziom"] = "Student";
                        Session["student_ID"] = osoba.idStudenta;
                        Session["imie"] = osoba.Imie;
                        Session["nazwisko"] = osoba.Nazwisko;
                        FormsAuthentication.RedirectFromLoginPage("Student", false);
                        break;

                    case 2: //WYKKLADOWCA
                        Session["Poziom"] = "Wykladowca";
                        Session["pracownik_ID"] = pracownikUczelni.PracownikID;
                        FormsAuthentication.RedirectFromLoginPage("Wykladowca", false);
                        break;

                    case 3: // PRACOWNIK
                        Session["Poziom"] = "Pracownik";
                        Session["pracownik_ID"] = pracownikUczelni.PracownikID;
                        FormsAuthentication.RedirectFromLoginPage("Pracownik", false);
                        break;
                }
            }
            else Response.Write("Zły login/hasło!");
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DziennikASP
{
    public class PracownikUczelni
    {
        public int ID { get; set; }
        public String Imie { get; set; }
        public String Nazwisko { get; set; }
        public String Plec { get; set; }
        public int PracownikID { get; set; }
        public int Uprawnienia { get; set; }
        public String Stanowisko { get; set; }

        public PracownikUczelni()
        {
            ID = 0;
            Imie = null;
            Nazwisko = null;
            Plec = null;
            PracownikID = 0;
            Stanowisko = null;
            Uprawnienia = 0;
        }

        public PracownikUczelni(int id, String Im, String Na, String S, int PrID, String Stan, int Upr)
        {
            ID = id;
            Imie = Im;
            Nazwisko = Na;
            Plec = S;
            PracownikID = PrID;
            Stanowisko = Stan;
            Uprawnienia = Upr;
        }
    }
}
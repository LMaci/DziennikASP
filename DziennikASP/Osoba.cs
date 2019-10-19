using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DziennikASP
{
    public class Osoba
    {
        public int ID { get; set; }
        public String Imie { get; set; }
        public String Nazwisko { get; set; }
        public String Plec { get; set; }
        public String NrIndeksu { get; set; }
        public int idStudenta { get; set; }

        public int Uprawnienia { get; set; }

        public Osoba()
        {
            ID = 0;
            Imie = null;
            Nazwisko = null;
            NrIndeksu = null;
            Plec = null;
            Uprawnienia = 0;
            idStudenta = 0;
        }

        public Osoba(int id, String Im, String Na, String S, String NrInd, int Upr, int idSt) //student
        {
            ID = id;
            Imie = Im;
            Nazwisko = Na;
            Plec = S;
            NrIndeksu = NrInd;
            Uprawnienia = Upr;
            idStudenta = idSt;
        }



    }
}
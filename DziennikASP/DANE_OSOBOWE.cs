//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DziennikASP
{
    using System;
    using System.Collections.Generic;
    
    public partial class DANE_OSOBOWE
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DANE_OSOBOWE()
        {
            this.PRACOWNIK = new HashSet<PRACOWNIK>();
            this.STUDENT = new HashSet<STUDENT>();
        }
    
        public int ID { get; set; }
        public string IMIE { get; set; }
        public string NAZWISKO { get; set; }
        public string PLEC { get; set; }
        public Nullable<int> AUTH_ID { get; set; }
    
        public virtual AUTH AUTH { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PRACOWNIK> PRACOWNIK { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<STUDENT> STUDENT { get; set; }
    }
}
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
    
    public partial class AUTH
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public AUTH()
        {
            this.DANE_OSOBOWE = new HashSet<DANE_OSOBOWE>();
        }
    
        public int ID { get; set; }
        public string LOGIN { get; set; }
        public string HASLO { get; set; }
        public int UPRAWNIENIA { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DANE_OSOBOWE> DANE_OSOBOWE { get; set; }
    }
}

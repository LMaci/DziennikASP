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
    
    public partial class PRZEDMIOT
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PRZEDMIOT()
        {
            this.PROJEKT = new HashSet<PROJEKT>();
            this.STUDENT_PRZEDMIOT = new HashSet<STUDENT_PRZEDMIOT>();
        }
    
        public int ID { get; set; }
        public string NAZWA { get; set; }
        public string ALIAS { get; set; }
        public int PRACOWNIK_ID { get; set; }
    
        public virtual PRACOWNIK PRACOWNIK { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PROJEKT> PROJEKT { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<STUDENT_PRZEDMIOT> STUDENT_PRZEDMIOT { get; set; }
    }
}
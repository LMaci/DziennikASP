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
    
    public partial class PROJEKT
    {
        public int ID { get; set; }
        public string TEMAT { get; set; }
        public Nullable<int> STUDENT_ID { get; set; }
        public Nullable<int> PRACOWNIK_ID { get; set; }
        public Nullable<int> PRZEDMIOT_ID { get; set; }
        public Nullable<int> OCENA { get; set; }
        public Nullable<bool> POTWIERDZONY { get; set; }
    
        public virtual PRACOWNIK PRACOWNIK { get; set; }
        public virtual STUDENT STUDENT { get; set; }
        public virtual PRZEDMIOT PRZEDMIOT { get; set; }
    }
}
